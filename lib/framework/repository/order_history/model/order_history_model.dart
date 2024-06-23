import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class OrderHistoryModel {
  String name;
  OrderType orderType;
  Widget screen;

  OrderHistoryModel({
    required this.name,
    required this.orderType,
    required this.screen,
  });
}