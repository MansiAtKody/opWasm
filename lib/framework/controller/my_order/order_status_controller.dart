import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';

import 'package:kody_operator/ui/utils/theme/theme.dart';


final orderStatusController = ChangeNotifierProvider(
      (ref) => getIt<OrderStatusController>(),
);

@injectable
class OrderStatusController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;

    if (isNotify) {
      notifyListeners();
    }
  }

  List<OrderStatusModel> orderStatusList = [
    OrderStatusModel(status: OrderStatusEnum.PENDING, description: ''),
    OrderStatusModel(status: OrderStatusEnum.ACCEPTED, description: ''),
    OrderStatusModel(status: OrderStatusEnum.PREPARED, description: ''),
    OrderStatusModel(status: OrderStatusEnum.DISPATCH, description: ''),
    OrderStatusModel(status: OrderStatusEnum.DELIVERED, description: ''),
  ];

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

class OrderStatusModel{
  OrderStatusEnum status;
  String description;

  OrderStatusModel({required this.status, required this.description});
}
