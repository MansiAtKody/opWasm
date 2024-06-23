import 'package:flutter/material.dart';
import 'package:kody_operator/ui/home/web/home_web.dart';
import 'package:kody_operator/ui/order_management/mobile/order_management_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrderManagement extends StatelessWidget with BaseStatelessWidget {
  const OrderManagement({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const OrderManagementMobile();
      },
      desktop: (BuildContext context) {
        return const OrderManagementWeb();
      },
      tablet: (BuildContext context) {
        return const OrderManagementWeb();
      },
    );
  }
}
