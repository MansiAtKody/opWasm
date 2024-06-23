import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/dispatch_order/contract/dispatched_order_repository.dart';
import 'package:kody_operator/framework/repository/dispatch_order/model/response_model/dispatched_order_list_response_model.dart';
import 'package:kody_operator/framework/repository/order_management/contract/order_control_repository.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final dispatchedOrderController = ChangeNotifierProvider(
    (ref) => getIt<DispatchedOrderController>());

@injectable
class DispatchedOrderController extends ChangeNotifier {
  OrderControlRepository orderRepository;

  DispatchedOrderController(
      this.orderRepository, this.dispatchedOrderRepository);

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    dispatchedOrderList.isLoading = true;
    isForCancelOrder = false;
    isForDelivery = false;

    if (isNotify) {
      notifyListeners();
    }
  }

  bool isLoading = true;

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  DispatchedOrderRepository dispatchedOrderRepository;

  var changeOrderStatus = UIState<CommonResponseModel>();
  var dispatchedOrderList = UIState<DispatchedOrderListResponseModel>();

  ///dispatched order list api
  Future<void> getDispatchedOrderListApi(
      {required BuildContext context, required String robotUuid}) async {
    isLoading = false;
    dispatchedOrderList.isLoading = true;
    dispatchedOrderList.success = null;
    notifyListeners();

    final result = await dispatchedOrderRepository.getDispatchedOrderList(robotUuid);

    result.when(success: (data) async {
      dispatchedOrderList.success = data;
      if(dispatchedOrderList.success?.status == ApiEndPoints.apiStatus_200){
        // if(selectedTrayNumber != null) {
        //   trayDataList?[selectedTrayNumber! - 1] = getTrayListState.success;
        // }
      }
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    dispatchedOrderList.isLoading = false;
    notifyListeners();
  }

  bool isForDelivery = false;
  bool isForCancelOrder = false;

  int? updateOrderIndex;

  ///change order status
  Future<void> changeOrderStatusApi(
      {required BuildContext context, required String taskUuid, required String status,required bool isForCancel}) async {
    changeOrderStatus.isLoading = true;
    isForCancel ? isForCancelOrder = true : isForDelivery = true;
    updateOrderIndex = dispatchedOrderList.success!.data?.indexWhere((element) => element.uuid == taskUuid);
    changeOrderStatus.success = null;
    notifyListeners();

    final result = await dispatchedOrderRepository.changeOrderStatus(taskUuid, status);

    result.when(success: (data) async {
      changeOrderStatus.success = data;
      if(changeOrderStatus.success?.status == ApiEndPoints.apiStatus_200){
        dispatchedOrderList.success?.data?.removeWhere((element) => element.uuid==taskUuid);
        notifyListeners();
      }
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });
    isForCancel ? isForCancelOrder = false : isForDelivery = false;
    changeOrderStatus.isLoading = false;
    notifyListeners();
  }
}
