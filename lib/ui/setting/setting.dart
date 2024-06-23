import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/setting/mobile/setting_mobile.dart';
import 'package:kody_operator/ui/setting/web/setting_web.dart';

class Setting extends StatelessWidget with BaseStatelessWidget {
  const Setting({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const SettingMobile();
      },
      desktop: (BuildContext context) {
        return const SettingWeb();
      },
      tablet: (BuildContext context) {
        return const SettingWeb();
      },
    );
  }
}
