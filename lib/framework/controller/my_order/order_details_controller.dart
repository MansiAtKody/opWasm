import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';

import 'package:kody_operator/ui/utils/theme/theme.dart';

final orderDetailsController = ChangeNotifierProvider(
  (ref) => getIt<OrderDetailsController>(),
);

@injectable
class OrderDetailsController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;

    if (isNotify) {
      notifyListeners();
    }
  }

  OrderModel? orderModel;

  updateOrderModelFromId(WidgetRef ref, String? id) {
    orderModel = ref.read(myOrderController).allOrderList.where((element) => element.orderId == int.parse(id ?? '0')).firstOrNull;
    notifyListeners();
  }

  getOrderModelFromId(WidgetRef ref, String? id) {
    return ref.read(myOrderController).allOrderList.where((element) => element.orderId == int.parse(id ?? '0')).firstOrNull;
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
