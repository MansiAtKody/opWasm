import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/profile/mobile/change_password_mobile.dart';
import 'package:kody_operator/ui/profile/web/change_password_web.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const ChangePasswordMobile();
        },
        desktop: (BuildContext context) {
          return const ChangePasswordWeb();
        }
    );
  }
}

