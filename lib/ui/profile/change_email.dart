import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/profile/mobile/change_email_mobile.dart';
import 'package:kody_operator/ui/profile/web/change_email_web.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const ChangeEmailMobile();
        },
        desktop: (BuildContext context) {
          return const ChangeEmailWeb();
        }
    );
  }
}

