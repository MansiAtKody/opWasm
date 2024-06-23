import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/profile/mobile/personal_info_mobile.dart';
import 'package:kody_operator/ui/profile/web/personal_info_web.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const PersonalInfoMobile();
        },
        desktop: (BuildContext context) {
          return const PersonalInfoWeb();
        }
    );
  }
}

