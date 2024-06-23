import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/order_history/contract/order_history_repository.dart';
import 'package:kody_operator/framework/repository/order_history/model/order_history_model.dart';
import 'package:kody_operator/framework/repository/order_history/model/product_history_model.dart';
import 'package:kody_operator/framework/repository/order_history/model/request/order_list_request_model.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_detail_response_model.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_list_response_model.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_status_model.dart';
import 'package:kody_operator/framework/repository/order_history/model/service_history_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/order_history/web/helper/product_list.dart';
import 'package:kody_operator/ui/routing/delegate.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

export 'package:kody_operator/framework/repository/order_history/model/order_history_model.dart';

final orderHistoryController = ChangeNotifierProvider(
  (ref) => getIt<OrderHistoryController>(),
);

@injectable
class OrderHistoryController extends ChangeNotifier {
  Timer? debounce;
  TextEditingController ctrSearch = TextEditingController();
  FocusNode searchFocus = FocusNode();

  ///Dispose Controller
  void disposeController({bool isNotify = false,WidgetRef? ref}) {
    isLoading = true;
    orderListPageNumber=1;
    ctrSearch.clear();
    endDate = null;
    startDate = DateTime.now();
    endDate=DateTime.now();
    selectedOrderStatusFilterList = [];
    selectedOrderType = orderTypeList[0];
    selectedDateFilter=dateFilterList[0].filterName;
    orderStatusFilterList = [

      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyPending.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyAccepted.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyRejected.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyPartiallyDelivered.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyDelivered.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyCanceled.localized,
      ),
    ];
    if (isNotify) {
      notifyListeners();
    }
  }


  ///Clear Filters
  void clearFilter(){
    ctrSearch.clear();
    startDate = DateTime.now();
    endDate=DateTime.now();
    selectedOrderStatusFilterList = [];
    selectedDateFilter=dateFilterList[0].filterName;
    orderStatusFilterList = [

      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyPending.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyAccepted.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyRejected.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyPartiallyDelivered.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyDelivered.localized,
      ),
      OrderStatusModel(
        isSelected: false,
        filterName: LocalizationStrings.keyCanceled.localized,
      ),
    ];
    notifyListeners();
  }

  ///Order history title list
  List<OrderHistoryModel> orderTypeList = [
    OrderHistoryModel(name: LocalizationStrings.keyProducts.localized, orderType: OrderType.products, screen: const ProductList()),
    ///Do not Remove this code
    //OrderHistoryModel(name: LocalizationStrings.keyServices.localized, orderType: OrderType.services, screen: const ServiceList()),
  ];


  /// Update Order history selection from order or service
  OrderHistoryModel? selectedOrderType;
  updateSelectedOrderType(WidgetRef ref, {OrderHistoryModel? selectedOrderType, OrderType? orderType}) {
    if (orderType != null) {
      selectedOrderType = orderTypeList.firstWhere((element) => element.orderType == orderType);
    }
    this.selectedOrderType = selectedOrderType ?? orderTypeList[0];
    notifyListeners();
    ref.read(navigationStackProvider).pushRemove(NavigationStackItem.history(orderType: orderType ?? this.selectedOrderType?.orderType ?? OrderType.products));
  }

  ///to Filter Past Orders
  DateTime? startDate;
  DateTime? tempDate;
  DateTime? endDate;

  ///Update Temp date
  updateTempDate(DateTime? tempDate) {
    this.tempDate = tempDate;
    notifyListeners();
  }

  ///Check if filter applied
  bool isFilterApplied() {
    return startDate != null || endDate != null;
  }

  bool isDatePickerVisible = false;

  void updateIsDatePickerVisible(bool isDatePickerVisible) {
    this.isDatePickerVisible = isDatePickerVisible;
    notifyListeners();
  }

  bool isCheckStartEndDateValid = false;

  ///Validation for start and end date
  bool checkStartEndDateValid() {
    if (startDate != null && endDate != null) {
      isCheckStartEndDateValid = true;
    } else {
      isCheckStartEndDateValid = false;
    }
    return isCheckStartEndDateValid;
  }

  ///Update start and end date
  void updateStartEndDate(bool isStartDate, DateTime? date) {
    dateFilterUpdate();
    if (isStartDate) {
      if (endDate != null) {
        if (!(endDate!.difference(startDate ?? DateTime.now()).isNegative)) {
          endDate = null;
        }
      }
      startDate = date;
    } else {
      endDate = date;
    }
    checkStartEndDateValid();
    notifyListeners();
  }

  ///Animation Controller for dialog
  AnimationController? animationController;

  updateAnimationController(AnimationController animationController) {
    this.animationController = animationController;
    notifyListeners();
  }

  /// recent search list
  List<String> searchList = [];

  /// search controler
  void updateSearchController(String searchText) {
    searchFocus.requestFocus();
    ctrSearch.text = searchText;
    notifyListeners();
  }

  /// update search list
  void updateSearchList() {
    if (ctrSearch.text.isNotEmpty) {
      int index = searchList.indexWhere((element) => element.toLowerCase() == ctrSearch.text.toLowerCase());
      if (index != -1) {
        searchList.removeAt(index);
      }
      searchList.add(ctrSearch.text);
      searchList = searchList.reversed.toList();
      notifyListeners();
    }
  }

  /// Order Info title list
  List<String> title = [
    LocalizationStrings.keyOrderId.localized,
    LocalizationStrings.keyName.localized,
    LocalizationStrings.keyLocationPoint.localized,
    LocalizationStrings.keyDate.localized,
  ];

  List<String> productDetailTitle = [
    LocalizationStrings.keyOrderId.localized,
    LocalizationStrings.keyFrom.localized,
    LocalizationStrings.keyTo.localized,
    LocalizationStrings.keyItemType.localized,
  ];
  List<String> productDetailSubTitle = [
    '#12345634',
    'Maharajah',
    'Krishan trade',
    'Document',
  ];

  /// search history demo list
  List<ProductHistoryModel> serviceHistoryListMobile = [
    ProductHistoryModel(
        orderId: '#1', userName: 'Krishna ', department: 'UI/UX Designer', date: '23/03/23', order: 'Services', customization: 'Sugar, Almond Milk, Medium', status: LocalizationStrings.keyAccept.localized, orderDetail: []),
    ProductHistoryModel(
        orderId: '#12', userName: 'Deep ', department: 'UI/UX Designer', date: '23/03/23', order: 'services ---', customization: 'Sugar, Almond Milk, Medium', status: LocalizationStrings.keyAccept.localized, orderDetail: []),
    ProductHistoryModel(
        orderId: '#123', userName: 'Amman ', department: 'UI/UX Designer', date: '23/03/23', order: 'Services --- 3', customization: 'Sugar, Almond Milk, Medium', status: LocalizationStrings.keyAccept.localized, orderDetail: []),
    ProductHistoryModel(
        orderId: '#1234', userName: 'Musk-an ', department: 'UI/UX Designer', date: '23/03/23', order: 'services --- 4', customization: 'Sugar, Almond Milk, Medium', status: LocalizationStrings.keyDelivered.localized, orderDetail: []),
    ProductHistoryModel(
        orderId: '#12345', userName: 'Hafiza ', department: 'UI/UX Designer', date: '23/03/23', order: 'Services --- 5', customization: 'Sugar, Almond Milk, Medium', status: LocalizationStrings.keyDelivered.localized, orderDetail: [])
  ];

  List<ServiceHistoryModel> serviceHistoryList = [
    ServiceHistoryModel(serviceId: '#1', type: 'Krishna ', department: 'UI/UX Designer', date: '23/03/23', name: 'Krishna', status: LocalizationStrings.keyDelivered.localized),
    ServiceHistoryModel(serviceId: '#12', type: 'Deep ', department: 'UI/UX Designer', date: '23/03/23', name: 'Krishna', status: LocalizationStrings.keyRejected.localized),
    ServiceHistoryModel(serviceId: '#123', type: 'Amman ', department: 'UI/UX Designer', date: '23/03/23', name: 'Krishna', status: LocalizationStrings.keyCanceled.localized),
    ServiceHistoryModel(serviceId: '#1234', type: 'Hafiza ', department: 'UI/UX Designer', date: '23/03/23', name: 'Krishna', status: LocalizationStrings.keyDelivered.localized),
    ServiceHistoryModel(serviceId: '#12345', type: 'Musk-an ', department: 'UI/UX Designer', date: '23/03/23', name: 'Krishna', status: LocalizationStrings.keyDelivered.localized)
  ];

  /// Order Status Filter List
  List<OrderStatusModel> orderStatusFilterList = [

    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyPending.localized,
    ),
    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyAccepted.localized,
    ),
    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyRejected.localized,
    ),
    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyPartiallyDelivered.localized,
    ),
    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyDelivered.localized,
    ),
    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyCanceled.localized,
    ),
  ];

  ///Date filter list
  List<OrderStatusModel> dateFilterList = [
    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyToday.localized,
    ),
    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyYesterday.localized,
    ),
    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyLastWeek.localized,
    ),
    OrderStatusModel(
      isSelected: false,
      filterName: LocalizationStrings.keyLastMonth.localized,
    ),
  ];

  /// Update status selection filter
   List<String> selectedOrderStatusFilterList =[];
   void orderStatusFilterUpdate(bool value, int index) {
    orderStatusFilterList[index].isSelected = value;
    if(orderStatusFilterList[index].filterName == LocalizationStrings.keyPartiallyDelivered.localized){
      if(selectedOrderStatusFilterList.contains('PARTIALLY_DELIVERED')){
        selectedOrderStatusFilterList.removeWhere((element) => element == 'PARTIALLY_DELIVERED');
     }else{
        selectedOrderStatusFilterList.add('PARTIALLY_DELIVERED');
      }
    }else{
        if(selectedOrderStatusFilterList.contains(orderStatusFilterList[index].filterName.toUpperCase())){
          selectedOrderStatusFilterList.removeWhere((element) => element == orderStatusFilterList[index].filterName.toUpperCase());
         }else {
           selectedOrderStatusFilterList.add(
          orderStatusFilterList[index].filterName.toUpperCase());
         }
    }

    notifyListeners();
  }

  /// Update date selection filter
  String? selectedDateFilter;
  void dateFilterUpdate({int? index}) {
    if(index != null){
      selectedDateFilter = dateFilterList[index].filterName;
      DateFilterEnum? dateFilterEnum = dateFilterEnumValues.map[selectedDateFilter ?? DateFilterEnum.yesterday.name];
      switch(dateFilterEnum){
        case DateFilterEnum.today:{
          startDate = DateTime.now();
          endDate=DateTime.now();
        }
        case DateFilterEnum.yesterday:{
          startDate = DateTime.now().subtract(const Duration(days:1));
          endDate=DateTime.now().subtract(const Duration(days:1));
        }
        case DateFilterEnum.lastWeek:
          startDate = DateTime.now().subtract(const Duration(days:7));
          endDate=DateTime.now();
        case DateFilterEnum.lastMonth:
          endDate = DateTime.now();
          startDate=DateTime.now().subtract(const Duration(days:30));
        case null:
      }
    }else{
      selectedDateFilter = null;
    }
    notifyListeners();
  }

  ///service history search function
  List<ServiceHistoryModel> serviceSearchedItemList = [];

  updateSearchedItemList(List<ServiceHistoryModel> itemList) {
    serviceSearchedItemList = itemList.where((element) => element.serviceId.toLowerCase().contains(ctrSearch.text.toLowerCase())).toList();
    serviceSearchedItemList.addAll(itemList.where((element) => element.type.toLowerCase().contains(ctrSearch.text.toLowerCase())).toList());

    if (ctrSearch.text.isEmpty) {
      serviceSearchedItemList.clear();
    }
    notifyListeners();
  }

  ///product list searching
  List<ProductHistoryModel> productSearchedItemList = [];

  updateProductSearchedItemList(List<ProductHistoryModel> itemList) {
    productSearchedItemList = itemList.where((element) => element.orderId.toLowerCase().contains(ctrSearch.text.toLowerCase())).toList();
    productSearchedItemList.addAll(itemList.where((element) => element.order.toLowerCase().contains(ctrSearch.text.toLowerCase())).toList());
    if (ctrSearch.text.isEmpty) {
      productSearchedItemList.clear();
    }
    notifyListeners();
  }

  //-------------Pagination-------------//

  /// Scroll Controller
  ScrollController orderListScrollController = ScrollController();

  /// Page number
  int orderListPageNumber = 1;

  /// Order List
  List<OrderData>? orderList =[];

  /// Reset Pagination
  void resetPaginationOrderList() {
    orderListState.success = null;
    orderListPageNumber = 1;
    orderList = [];
    notifyListeners();
  }

  /// increment order List number
  void incrementOrderListPageNumber() {
    orderListPageNumber++;
    notifyListeners();
  }
  ///To Show Loader at particular index while showing details
  int? updatingOrderIndex;


  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }


  OrderHistoryRepository orderHistoryRepository;
  OrderHistoryController(this.orderHistoryRepository);

  UIState<OrderListResponseModel> orderListState =  UIState<OrderListResponseModel>();
  UIState<OrderDetailResponseModel> orderDetailState =  UIState<OrderDetailResponseModel>();
  /// Order List  API
  Future<void> getOrderListApi(BuildContext context) async {
    if ((orderListState.success?.hasNextPage??false) && (orderListPageNumber != 1)  ) {
      orderListState.isLoadMore=true;
    }
    else{
      orderListPageNumber=1;
      orderList?.clear();
      orderListState.isLoading=true;
    }
   // orderListState.isLoading = true;
    orderListState.success = null;
    notifyListeners();

    String request = orderListRequestModelToJson(OrderListRequestModel(
      status:selectedOrderStatusFilterList,
      searchKeyword: ctrSearch.text,
      entityType: [],
      fromDate:startDate?.millisecondsSinceEpoch.toString(),
      toDate:endDate?.millisecondsSinceEpoch.toString(),
    ));
    final result = await orderHistoryRepository.getOrderListApi(request,orderListPageNumber);

    result.when(success: (data) async {
      orderListState.success = data;
      orderList?.addAll(orderListState.success?.data ?? []);
      orderListState.isLoading =false;
      orderListState.isLoadMore=false;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context:globalNavigatorKey.currentContext?? context , message: errorMsg);
    });

    orderListState.isLoading =false;
    notifyListeners();
  }

  /// Order Detail API
  Future<void> orderDetailApi(BuildContext context,String orderId) async {
    orderDetailState.isLoading = true;
    orderDetailState.success = null;
    updatingOrderIndex = orderListState.success?.data?.indexWhere((element) => element.uuid == orderId);
    notifyListeners();

    final result = await orderHistoryRepository.getOrderDetailApi(orderId);

    result.when(success: (data) async {
      orderDetailState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    orderDetailState.isLoading =false;
    notifyListeners();
  }
}


