import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/repository/order/model/order_status_model.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/order_management/contract/order_control_repository.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/ongoing_order_list_mobile.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/past_order_list_mobile.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/upcoming_order_list_mobile.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';
import 'package:kody_operator/ui/widgets/socket_manager.dart';

final orderStatusController = ChangeNotifierProvider(
  (ref) => getIt<OrderStatusController>(),
);

@injectable
class OrderStatusController extends ChangeNotifier {
  final GlobalKey<AnimatedListState> pastOrderKey = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> orderDetailKey = GlobalKey<AnimatedListState>();

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    selectedTabIndex = 0;
    if (isNotify) {
      notifyListeners();
    }
  }

  List<String> orderTitle = [
    LocalizationStrings.keyUpcoming.localized,
    LocalizationStrings.keyAccepted.localized,
    LocalizationStrings.keyPrepared.localized,
  ];

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  // List<OrderStatus> pastOrders = [];

  List<SocketOrders> upcomingSocketOrders = [];

  List<SocketOrders> ongoingSocketOrders = [];

  List<SocketOrders> pastSocketOrders = [];

  initializeOrderList(SocketOrderResponseModel orderList, WidgetRef ref) async {
    upcomingSocketOrders = orderList.upcomingOrders ?? [];
    ongoingSocketOrders = orderList.ongoingOrders ?? [];
    pastSocketOrders = orderList.preparedOrders ?? [];
    isLoading = false;
    notifyListeners();
  }

  int selectedTabIndex = 0;

  List<OrderStatusModel> orderStatusList = [
    OrderStatusModel(status: OrderStatusEnum.PENDING.name, description: ''),
    OrderStatusModel(status: OrderStatusEnum.ACCEPTED.name, description: ''),
    OrderStatusModel(status: OrderStatusEnum.PREPARED.name, description: ''),
    OrderStatusModel(status: OrderStatusEnum.DISPATCH.name, description: ''),
    OrderStatusModel(status: OrderStatusEnum.DELIVERED.name, description: ''),
  ];

  List<Widget> orderListWidgets = [const UpcomingOrderListMobile(), const OngoingOrderListMobile(), const PastOrderListMobile()];

  updateTabIndex(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //////////------------------ Api Integration --------------------////////////////
  OrderControlRepository orderControlRepository;
  SocketManager socketManager;

  OrderStatusController(this.orderControlRepository, this.socketManager);

  UIState<CommonResponseModel> orderItemStatusUpdate = UIState<CommonResponseModel>();


  int? updateItemIndex;
  Future<void> orderItemStatusUpdateApi(BuildContext context, String orderUuid,String itemUuid,OrderStatusEnum status) async {
    orderItemStatusUpdate.isLoading = true;
    orderItemStatusUpdate.success = null;
    notifyListeners();

    final result = await orderControlRepository.updateOrderItemStatusApi(itemUuid, status.name);

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

  UIState<CommonResponseModel> orderStatusUpdate = UIState<CommonResponseModel>();
  OrderStatusEnum? updatingOrderEnum;
  int? updatingOrderIndex;
  int? updatingOrderItemIndex;

  updateOrderStatus(String uuid, OrderStatusEnum status,{String? itemUuid}) {
    updatingOrderEnum = status;
    if (status == OrderStatusEnum.ACCEPTED) {
      updatingOrderIndex = upcomingSocketOrders.indexWhere((element) => element.uuid == uuid);
    } else if (status == OrderStatusEnum.PREPARED) {
      updatingOrderIndex = ongoingSocketOrders.indexWhere((element) => element.uuid == uuid);
      updatingOrderItemIndex  = ongoingSocketOrders[updatingOrderIndex??-1].ordersItems?.indexWhere((element) => element.uuid == itemUuid) ??-1;
    }else{
      updatingOrderIndex = upcomingSocketOrders.indexWhere((element) => element.uuid == uuid);
      updatingOrderItemIndex  =upcomingSocketOrders[updatingOrderIndex??-1].ordersItems?.indexWhere((element) => element.uuid == itemUuid) ??-1;

    }

    notifyListeners();
  }
  bool isCanceling = false;
  updateCancelLoading(bool value) {
    isCanceling = value;
    notifyListeners();
  }
  updateAcceptedOrderStatus(String uuid, OrderStatusEnum status,{String? itemUuid}) {
    isCanceling = true;
    updatingOrderEnum = status;
      updatingOrderIndex = ongoingSocketOrders.indexWhere((element) => element.uuid == uuid);
      updatingOrderItemIndex  = ongoingSocketOrders[updatingOrderIndex??-1].ordersItems?.indexWhere((element) => element.uuid == itemUuid) ??-1;
    notifyListeners();
  }

  updatePreparedOrderStatus(String uuid, OrderStatusEnum status,{String? itemUuid}) {
    updatingOrderEnum = status;
    updatingOrderIndex = pastSocketOrders.indexWhere((element) => element.uuid == uuid);
    updatingOrderItemIndex  =pastSocketOrders[updatingOrderIndex??-1].ordersItems?.indexWhere((element) => element.uuid == itemUuid) ??-1;

    notifyListeners();
  }


  int? updateOrderIndex;
  Future<void> orderStatusUpdateApi(BuildContext context, String uuid, OrderStatusEnum status) async {

    updatingOrderEnum = status;
    updateOrderIndex = upcomingSocketOrders.indexWhere((element) => element.uuid == uuid);
    orderStatusUpdate.isLoading = true;
    orderStatusUpdate.success = null;
    notifyListeners();

    final result = await orderControlRepository.updateOrderStatus(uuid, status.name);

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

  UIState<CommonResponseModel> dispatchOrderState = UIState<CommonResponseModel>();

  Future<void> dispatchOrderApi(BuildContext context, String robotUuid) async {
    dispatchOrderState.isLoading = true;
    dispatchOrderState.success = null;
    notifyListeners();

    final result = await orderControlRepository.dispatchOrderApi(robotUuid);

    result.when(success: (data) async {
      dispatchOrderState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      dispatchOrderState.isLoading = false;
      showCommonErrorDialog(context: context, message: errorMsg);
    });
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
