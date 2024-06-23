import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/profile/mobile/change_mobile_no_mobile.dart';
import 'package:kody_operator/ui/profile/web/change_mobile_no_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class ChangeMobileNo extends StatelessWidget with BaseStatelessWidget {
  const ChangeMobileNo({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return  const ChangeMobileNoMobile();
      },
      desktop: (BuildContext context) {
        return const ChangeMobileNoWeb();
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape
                ? const ChangeMobileNoWeb()
                :  const ChangeMobileNoMobile();
          },
        );
      },
    );
  }
}

