import 'package:flutter/material.dart';
import 'package:kody_operator/ui/home/mobile/home_mobile.dart';
import 'package:kody_operator/ui/home/web/home_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Home extends StatelessWidget with BaseStatelessWidget {
  const Home({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const HomeMobile();
      },
      desktop: (BuildContext context) {
        return const OrderManagementWeb();
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape ? const OrderManagementWeb() : const HomeMobile();
          },
        );
      },
    );
  }
}
