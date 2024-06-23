import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/profile/mobile/profile_setting_mobile.dart';
import 'package:kody_operator/ui/profile/web/profile_setting_web.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const ProfileSettingMobile();
        },
        desktop: (BuildContext context) {
          return const ProfileSettingWeb();
        }
    );
  }
}

