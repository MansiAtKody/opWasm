import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/controller/my_order/order_status_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/order/contract/order_repository.dart';
import 'package:kody_operator/framework/repository/order/model/order_filter_model.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/framework/repository/order/model/request/order_list_request_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_details_response_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_list_response_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final myOrderController = ChangeNotifierProvider(
  (ref) => getIt<MyOrderController>(),
);

@injectable
class MyOrderController extends ChangeNotifier {
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    startDate = null;
    endDate = null;
    isMenuEnable = false;
    clearFilter();
    selectedOrderStatusFilterList=[];
    updateSelectedOrderFilter(selectedOrderFilter: orderFilterList[0]);
    updateSelectedOrderTypeFilter(selectedOrderTypeFilter: orderTypeFilterList[0]);
    if (isNotify) {
      notifyListeners();
    }
  }

  PageController orderTypePageController = PageController(initialPage: 0);

  void animatePage(int page) {
    orderTypePageController.jumpToPage(
      page,
      /*duration: const Duration(milliseconds: 150),
      curve: selectedOrderTypeFilter?.type == OrderType.order ? Curves.easeOut : Curves.easeIn,*/
    );
  }

  AnimationController? animationController;

  void updateAnimationController(AnimationController? animationController) {
    this.animationController = animationController;
    notifyListeners();
  }

  ///Any pop up menu opened
  bool isMenuEnable = false;

  updateIsMenuEnable(bool isMenuEnable) {
    this.isMenuEnable = isMenuEnable;
    notifyListeners();
  }

  ///to Filter Past Orders
  DateTime? startDate;

  DateTime? endDate;

  ///To Reset all filters
  void clearFilter() {
    startDate = null;
    endDate = null;
    notifyListeners();
  }

  ///Update start and end date
  void updateStartEndDate(bool isStartDate, DateTime? date) {
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

  ///Validation for start and end date
  bool checkStartEndDateValid() {
    if (startDate != null && endDate != null) {
      return true;
    } else {
      return false;
    }
  }

  ///All Order List
  List<OrderModel> allOrderList = [
    OrderModel(
      orderId: 1,
      status: OrderStatusEnum.ACCEPTED,
      isFav: true,
      orderType: OrderType.order,
      itemList: [
        OrderItem(
          itemImage: staticImageMasalaTea,
          itemName: 'Masala Tea',
          description: 'Energize your day with steamed soy milk and a shot of Masala Tea',
        ),
        OrderItem(
          itemImage: staticImageBiscuit,
          itemName: 'Biscuit',
          description: 'Something to go with your Masala Tea',
        ),
        OrderItem(
          itemImage: staticImageCookies,
          itemName: 'Cookies',
          description: 'Something to go with your Latte',
        ),
      ],
    ),
    OrderModel(
      orderId: 2,
      status: OrderStatusEnum.DELIVERED,
      orderType: OrderType.order,
      isFav: false,
      itemList: [
        OrderItem(
          itemImage: staticImageBiscuit,
          itemName: 'Biscuit',
          description: 'Something to go with your Masala Tea',
        ),
        OrderItem(
          itemImage: staticImageLatte,
          itemName: 'Latte',
          description: 'Energize your day with steamed soy milk and a shot of Latte',
        ),
      ],
    ),
    OrderModel(
      orderId: 3,
      status: OrderStatusEnum.REJECTED,
      orderType: OrderType.order,
      isFav: false,
      itemList: [
        OrderItem(
          itemImage: staticImageCookies,
          itemName: 'Cookies',
          description: 'Something to go with your Latte',
        ),
      ],
    ),
    OrderModel(
      orderId: 4,
      status: OrderStatusEnum.PREPARED,
      orderType: OrderType.order,
      isFav: false,
      itemList: [
        OrderItem(
          itemImage: staticImageMasalaTea,
          itemName: 'Masala Tea',
          description: 'Energize your day with steamed soy milk and a shot of Masala Tea',
        ),
        OrderItem(
          itemImage: staticImageBiscuit,
          itemName: 'Biscuit',
          description: 'Something to go with your Masala Tea',
        ),
      ],
    ),
    OrderModel(
      orderId: 5,
      status: OrderStatusEnum.PENDING,
      orderType: OrderType.services,
      isFav: false,
      itemList: [
        OrderItem(
          itemImage: staticImageService,
          itemName: 'Receive Service',
          description: 'I Need A Document...',
        ),
      ],
    ),
    OrderModel(
      orderId: 6,
      status: OrderStatusEnum.ACCEPTED,
      orderType: OrderType.services,
      itemList: [
        OrderItem(
          itemImage: staticImageService,
          itemName: 'Receive Service',
          description: 'I Need A Document...',
        ),
      ],
    ),
    OrderModel(
      orderId: 6,
      status: OrderStatusEnum.ACCEPTED,
      orderType: OrderType.services,
      itemList: [
        OrderItem(
          itemImage: staticImageService,
          itemName: 'Receive Service',
          description: 'I Need A Document...',
        ),
      ],
    ),
    OrderModel(
      orderId: 9,
      status: OrderStatusEnum.DELIVERED,
      orderType: OrderType.services,
      itemList: [
        OrderItem(
          itemImage: staticImageService,
          itemName: 'Receive Service',
          description: 'I Need A Document...',
        ),
      ],
    ),
  ];

  ///Display Order List
  List<OrderModel> displayOrderList = [];

  ///Order type filter list, All, Product, Service
  List<OrderTypeFilterModel> orderTypeFilterList = [
    OrderTypeFilterModel(name: LocalizationStrings.keyOrder.localized, type: OrderType.order),
    OrderTypeFilterModel(name: LocalizationStrings.keyFavouriteOrders.localized, type: OrderType.favourite),
  ];

  ///Order Filter List, Current, Favourite, Past
  List<OrderTypeFilterModel> orderFilterList = [
    OrderTypeFilterModel(name: LocalizationStrings.keyCurrentOrder.localized, type: OrderType.current),
    OrderTypeFilterModel(name: LocalizationStrings.keyFavouritesOrder.localized, type: OrderType.favourite),
    OrderTypeFilterModel(name: LocalizationStrings.keyPastOrder.localized, type: OrderType.past),
  ];

  ///Order status filter list
  List<OrderStatusFilterModel> orderStatusFilterList = [
    OrderStatusFilterModel(name: OrderStatusEnum.PENDING.name, type: OrderStatusEnum.PENDING),
    OrderStatusFilterModel(name: OrderStatusEnum.ACCEPTED.name, type: OrderStatusEnum.ACCEPTED),
    OrderStatusFilterModel(name: OrderStatusEnum.DISPATCH.name, type: OrderStatusEnum.DISPATCH),
    OrderStatusFilterModel(name: OrderStatusEnum.DELIVERED.name, type: OrderStatusEnum.DELIVERED),
    OrderStatusFilterModel(name: OrderStatusEnum.REJECTED.name, type: OrderStatusEnum.REJECTED),
    OrderStatusFilterModel(name: OrderStatusEnum.CANCELED.name, type: OrderStatusEnum.CANCELED),
  ];

  ///update order to favourite
  updateOrderToFavorite(int? orderId) {
    OrderTypeFilterModel? selectedOrderFilter = this.selectedOrderFilter;
    allOrderList[allOrderList.indexWhere((element) => (element.orderId == orderId))].isFav = !allOrderList[allOrderList.indexWhere((element) => (element.orderId == orderId))].isFav;
    updateSelectedOrderFilter(selectedOrderFilter: selectedOrderFilter);
    notifyListeners();
  }

  List<OrderStatusFilterModel> selectedOrderStatusFilterList = [];

  updateSelectedOrderStatusFilterList(BuildContext context, {OrderStatusFilterModel? filter,bool? isClearAll  }) async {
    if(isClearAll??false){
      selectedOrderStatusFilterList=[];
    }else{
      if (selectedOrderStatusFilterList.contains(filter)) {
        selectedOrderStatusFilterList.remove(filter);
      } else {
        selectedOrderStatusFilterList.add(filter??OrderStatusFilterModel(name: '', type: OrderStatusEnum.NONE));
      }
    }

    notifyListeners();
  }

  bool getIfFilterIsInList(OrderStatusFilterModel filter) {
    return selectedOrderStatusFilterList.contains(filter);
  }

  ///All, Product, Service
  OrderTypeFilterModel? selectedOrderTypeFilter;

  ///Current, Favourite, Past
  OrderTypeFilterModel? selectedOrderFilter;

  ///All, Product, Service
  updateSelectedOrderTypeFilter({WidgetRef? ref, OrderTypeFilterModel? selectedOrderTypeFilter}) {
    this.selectedOrderTypeFilter = selectedOrderTypeFilter;
    if (selectedOrderTypeFilter?.type == OrderType.order) {
      orderFilterList = [
        OrderTypeFilterModel(name: LocalizationStrings.keyCurrentOrder.localized, type: OrderType.current),
        OrderTypeFilterModel(name: LocalizationStrings.keyFavouritesOrder.localized, type: OrderType.favourite),
        OrderTypeFilterModel(name: LocalizationStrings.keyPastOrder.localized, type: OrderType.past),
      ];
    } else {
      orderFilterList = [
        OrderTypeFilterModel(name: LocalizationStrings.keyCurrentService.localized, type: OrderType.current),
        OrderTypeFilterModel(name: LocalizationStrings.keyPastService.localized, type: OrderType.past),
      ];
    }
    updateSelectedOrderFilter(selectedOrderFilter: orderFilterList[0]);
    if (ref != null) {
      ref.read(navigationStackProvider).pushRemove(NavigationStackItem.myOrder(type: selectedOrderTypeFilter?.type));
    }
    notifyListeners();
  }

  ///Current, Favourite, Past
  updateSelectedOrderFilter({OrderTypeFilterModel? selectedOrderFilter}) {
    this.selectedOrderFilter = selectedOrderFilter;
    if (selectedOrderTypeFilter?.type == OrderType.order) {
      if (this.selectedOrderFilter?.type == OrderType.favourite) {
        displayOrderList = allOrderList.where((order) => order.isFav && (order.orderType == OrderType.order)).toList();
      } else if (this.selectedOrderFilter?.type == OrderType.current) {
        displayOrderList = allOrderList.where((order) => (order.status == OrderStatusEnum.PREPARED || order.status == OrderStatusEnum.ACCEPTED || order.status == OrderStatusEnum.PENDING) && (order.orderType == OrderType.order)).toList();
      } else {
        displayOrderList = allOrderList.where((order) => (order.status == OrderStatusEnum.DELIVERED || order.status == OrderStatusEnum.REJECTED || order.status == OrderStatusEnum.CANCELED) && (order.orderType == OrderType.order)).toList();
      }
    } else {
      if (this.selectedOrderFilter?.type == OrderType.current) {
        displayOrderList = allOrderList.where((order) => (order.status == OrderStatusEnum.PREPARED || order.status == OrderStatusEnum.ACCEPTED || order.status == OrderStatusEnum.PREPARED) && (order.orderType == OrderType.services)).toList();
      } else {
        displayOrderList = allOrderList.where((order) => (order.status == OrderStatusEnum.DELIVERED || order.status == OrderStatusEnum.REJECTED || order.status == OrderStatusEnum.CANCELED) && (order.orderType == OrderType.services)).toList();
      }
    }
    notifyListeners();
  }

  OrderStyle getOrderStatusTextColor(String? orderStatus) {
    OrderStyle orderStyle;
    switch (orderStatus ?? OrderStatusEnum.PENDING.name) {
      case 'DELIVERED':
        {
          orderStyle = OrderStyle(
            orderStatus: 'DELIVERED',
            buttonTextColor: AppColors.green35A600,
            buttonBgColor: AppColors.lightGreenDDFCE6,
          );
        }
        break;
      case 'CANCELED':
        {
          orderStyle = OrderStyle(
            orderStatus: 'CANCELED',
            buttonTextColor: AppColors.redE80202,
            buttonBgColor: AppColors.lightRedFFECEC,
          );
        }
        break;

      case 'ACCEPTED':
        {
          orderStyle = OrderStyle(
            orderStatus: 'ACCEPTED',
            buttonTextColor: AppColors.primary2,
            buttonBgColor: AppColors.lightBlueE7FBFF,
          );
        }
        break;

      case 'REJECTED':
        {
          orderStyle = OrderStyle(
            orderStatus: 'REJECTED',
            buttonTextColor: AppColors.orangeE95400,
            buttonBgColor: AppColors.lightOrange,
          );
        }
      case 'DISPATCH':
        {
          orderStyle = OrderStyle(
            orderStatus: 'DISPATCH',
            buttonTextColor: AppColors.primary2,
            buttonBgColor: AppColors.lightBlueE7FBFF,
          );
        }
      case 'PREPARED':
        {
          orderStyle = OrderStyle(
            orderStatus: 'PREPARED',
            buttonTextColor: AppColors.primary2,
            buttonBgColor: AppColors.lightBlueE7FBFF,
          );
        }
        break;
      default:
        {
          orderStyle = OrderStyle(
            orderStatus: 'PENDING',
            buttonTextColor: AppColors.black,
            buttonBgColor: AppColors.greyA3A3A3,
          );
        }
        break;
    }
    return orderStyle;
  }

  List<OrderStatusModel> orderStatusList = [
    OrderStatusModel(status: OrderStatusEnum.PENDING, description: ''),
    OrderStatusModel(status: OrderStatusEnum.ACCEPTED, description: ''),
    // OrderStatusModel(status: OrderStatusEnum.PREPARED, description: ''),
    // OrderStatusModel(status: OrderStatusEnum.DISPATCH, description: ''),
    OrderStatusModel(status: OrderStatusEnum.PARTIALLY_DELIVERED, description: ''),
    OrderStatusModel(status: OrderStatusEnum.DELIVERED, description: ''),
  ];


  // --- Pagination ---//
  Timer? debounce;
  ScrollController myOrderListScrollController= ScrollController();
  ///Page number
  int myOrderListPageNumber= 1;

  /// Order list
  List<OrderListResponseData>?  myOrderList =[];

  /// Reset Pagination
  void resetPaginationOrderList() {
    orderListState.success = null;
    myOrderListPageNumber = 1;
    myOrderList = [];
    notifyListeners();
  }
  /// increment order List number
  void incrementOrderListPageNumber() {
    myOrderListPageNumber++;
    notifyListeners();
  }
  bool getIsItemDispatched(){
    bool result = false;
    if((orderDetailsState.success?.data?.ordersItems?.where((element) => element.status == OrderStatusEnum.DISPATCH.name).isNotEmpty??false)||(orderDetailsState.success?.data?.ordersItems?.where((element) => element.status == OrderStatusEnum.DISPATCH.name).isNotEmpty??false)){
      result = false;
    }else{
      result = true;
    }
    return result;

  }

  void clearStartDateEndDate(){
    startDate = null;
    endDate = null;
    notifyListeners();
  }
  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  OrderRepository orderRepository;

  MyOrderController(this.orderRepository);

  var orderListState = UIState<OrderListResponseModel>();
  var orderDetailsState = UIState<OrderDetailsResponseModel>();
  var cancelOrderState = UIState<CommonResponseModel>();

  /// order list API
  Future<void> orderListApi(BuildContext context,{bool? isFavouriteOrders}) async {
    if ((myOrderListPageNumber != 1) && (orderListState.success?.hasNextPage??false)) {
      orderListState.isLoadMore=true;
    }
    else{
      myOrderListPageNumber=1;
      myOrderList?.clear();
      orderListState.isLoading=true;
    }

    orderListState.success = null;
    notifyListeners();

    List<String> selectedStatus = [];
    for (var item in selectedOrderStatusFilterList) {
      selectedStatus.add(item.type.name);
    }
    OrderListRequestModel requestModel;
    if(isFavouriteOrders??false){
      requestModel  = OrderListRequestModel(status: selectedStatus,isFavourite:isFavouriteOrders,fromDate:startDate?.millisecondsSinceEpoch.toString(),
        toDate:endDate?.millisecondsSinceEpoch.toString(), );
    }else{
      requestModel  = OrderListRequestModel(status: selectedStatus,fromDate:startDate?.millisecondsSinceEpoch.toString(),
          toDate:endDate?.millisecondsSinceEpoch.toString());
    }


    String request = orderListRequestModelToJson(requestModel);


    final result = await orderRepository.orderListApi(request,pageNumber: myOrderListPageNumber);

    result.when(success: (data) async {
      orderListState.success = data;
      myOrderList?.addAll(orderListState.success?.data ?? []);
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    orderListState.isLoading = false;
    orderListState.isLoadMore = false;
    notifyListeners();
  }

  /// order details API
  Future<void> orderDetailsApi(BuildContext context, String orderUuid) async {
    orderDetailsState.isLoading = true;
    orderDetailsState.success = null;
    notifyListeners();

    final result = await orderRepository.orderDetailsApi(orderUuid);

    result.when(success: (data) async {
      orderDetailsState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    orderDetailsState.isLoading = false;
    notifyListeners();
  }

  /// cancel order API
  Future<void> cancelOrderApi(BuildContext context, String orderUuid) async {
    cancelOrderState.isLoading = true;
    cancelOrderState.success = null;
    notifyListeners();

    final result = await orderRepository.cancelOrderApi(orderUuid);

    result.when(success: (data) async {
      cancelOrderState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    cancelOrderState.isLoading = false;
    notifyListeners();
  }

  UIState<CommonResponseModel> orderStatusUpdate = UIState<CommonResponseModel>();

  Future<void> orderStatusUpdateApi(BuildContext context, String uuid, OrderStatusEnum status) async {
    orderStatusUpdate.isLoading = true;
    orderStatusUpdate.success = null;

    notifyListeners();

    final result = await orderRepository.updateOrderStatusApi(uuid, status.name);

    result.when(success: (data) async {
      orderStatusUpdate.success = data;
      orderStatusUpdate.isLoading = false;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      orderStatusUpdate.isLoading = false;
      showCommonErrorDialog(context: context, message: errorMsg);
    });
    notifyListeners();
  }

  UIState<CommonResponseModel> orderItemStatusUpdate = UIState<CommonResponseModel>();
  int? updatingOrderItemIndex;

  Future<void> orderItemStatusUpdateApi(BuildContext context, String uuid, OrderStatusEnum status) async {
    orderItemStatusUpdate.isLoading = true;
    orderItemStatusUpdate.success = null;
    updatingOrderItemIndex = orderDetailsState.success?.data?.ordersItems?.indexWhere((element) => element.uuid == uuid);
    notifyListeners();

    final result = await orderRepository.updateOrderItemStatusApi(uuid, status.name);

    result.when(success: (data) async {
      orderItemStatusUpdate.success = data;
      orderItemStatusUpdate.isLoading = false;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      orderItemStatusUpdate.isLoading = false;
      showCommonErrorDialog(context: context, message: errorMsg);
    });
    notifyListeners();
  }

  ///Change Order Location Point Api
  UIState<CommonResponseModel> changeOrderLocationPointState = UIState<CommonResponseModel>();

  Future changeOrderLocationPointApi(BuildContext context, {String? orderUuid, String? locationPointsUuid}) async {
    changeOrderLocationPointState.isLoading = true;
    changeOrderLocationPointState.success = null;
    notifyListeners();

    final result = await orderRepository.changeOrderLocationPointsApi(orderUuid ?? '', locationPointsUuid ?? '');
    result.when(
      success: (data) {
        changeOrderLocationPointState.isLoading = false;
        changeOrderLocationPointState.success = data;
        notifyListeners();
      },
      failure: (NetworkExceptions error) {
        changeOrderLocationPointState.isLoading = false;
        String errorMsg = NetworkExceptions.getErrorMessage(error);
        showCommonErrorDialog(context: context,message: errorMsg);

        notifyListeners();
      },
    );
  }


  UIState<CommonResponseModel> favouriteOrderState = UIState<CommonResponseModel>();
  int? updatingFavouriteOrderIndex;

  Future<void> favouriteOrderApi(BuildContext context, String uuid, bool isFavourite) async {
    favouriteOrderState.isLoading = true;
    favouriteOrderState.success = null;
    updatingFavouriteOrderIndex = orderListState.success?.data?.indexWhere((element) => element.uuid == uuid);
    notifyListeners();

    final result = await orderRepository.favouriteOrderApi(uuid, isFavourite);

    result.when(success: (data) async {
      favouriteOrderState.success = data;
      favouriteOrderState.isLoading = false;
      orderListState.success?.data?.where((element) => element.uuid == uuid).firstOrNull?.isFavourite = isFavourite;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      favouriteOrderState.isLoading = false;
      showCommonErrorDialog(context: context, message: errorMsg);
    });
    notifyListeners();
  }

  ///////////------------------------ Socket Integration ---------------------------/////////////

  int selectedOrderPageIndex = 0;

  updateSelectedOrderPageIndex(int selectedOrderPageIndex) {
    this.selectedOrderPageIndex = selectedOrderPageIndex;
    notifyListeners();
  }

  List<SocketOrders>? ongoingSocketOrders = [];

  ///Socket Order List
  initializeOrderList(SocketOrderResponseModel orderList, WidgetRef ref) async {
    //ref.read(homeController).updateIsShowOrderStatusWidget(true);
    ongoingSocketOrders = orderList.ongoingOrders?.where (
          (order) => ((order.status == OrderStatusEnum.PENDING.name) || (order.status == OrderStatusEnum.ACCEPTED.name) || (order.status == OrderStatusEnum.PREPARED.name) || (order.status == OrderStatusEnum.DISPATCH.name) &&(order.entityUuid == ref.read(profileController).profileDetailState.success?.data?.uuid)  ),
        )
        .toList()
        .reversed
        .toList();
    notifyListeners();
  }
}
