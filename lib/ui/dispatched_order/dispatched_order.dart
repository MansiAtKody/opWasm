import 'package:flutter/material.dart';
import 'package:kody_operator/ui/dispatched_order/mobile/dispatched_order_mobile.dart';
import 'package:kody_operator/ui/dispatched_order/web/dispatched_order_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DispatchedOrder extends StatelessWidget with BaseStatelessWidget{
  const DispatchedOrder({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const DispatchedOrderMobile();
        },
        desktop: (BuildContext context) {
          return const DispatchedOrderWeb();
        },
        tablet: (BuildContext context) {
          return const DispatchedOrderWeb();
        }
    );
  }
}

