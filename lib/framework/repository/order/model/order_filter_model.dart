import 'package:kody_operator/ui/utils/const/app_enums.dart';

class OrderTypeFilterModel {
  String name;
  OrderType type;

  OrderTypeFilterModel({required this.name, required this.type});
}

class OrderStatusFilterModel {
  String name;
  OrderStatusEnum type;

  OrderStatusFilterModel({required this.name, required this.type});
}
