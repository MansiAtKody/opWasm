import 'package:flutter/material.dart';
import 'package:kody_operator/ui/my_order/mobile/order_home_mobile.dart';
import 'package:kody_operator/ui/my_order/web/order_home_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrderHome extends StatelessWidget with BaseStatelessWidget {
  const OrderHome({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const OrderHomeMobile();
      },
      desktop: (BuildContext context) {
        return const OrderHomeWeb();
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape
                ? const OrderHomeWeb()
                : const OrderHomeMobile();
          },
        );
      },
    );
  }
}

