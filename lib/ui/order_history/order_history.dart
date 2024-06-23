import 'package:flutter/material.dart';
import 'package:kody_operator/ui/order_history/mobile/order_history_mobile.dart';
import 'package:kody_operator/ui/order_history/web/order_history_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrderHistory extends StatelessWidget with BaseStatelessWidget{
  final OrderType? orderType;

  const OrderHistory({Key? key, this.orderType}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const OrderHistoryMobile();
      },
      desktop: (BuildContext context) {
        return OrderHistoryWeb(orderType: orderType);
      },
      tablet: (BuildContext context) {
        return OrderHistoryWeb(orderType: orderType);
      },
    );
  }
}
