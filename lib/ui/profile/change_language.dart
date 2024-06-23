import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/profile/mobile/change_language_mobile.dart';
import 'package:kody_operator/ui/profile/web/change_language_web.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const ChangeLanguageMobile();
        },
        desktop: (BuildContext context) {
          return const ChangeLanguageWeb();
        }
    );
  }
}

