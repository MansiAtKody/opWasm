import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/auth/mobile/login_mobile.dart';
import 'package:kody_operator/ui/auth/web/login_web.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const LoginMobile();
      },
      desktop: (BuildContext context) {
        return const LoginWeb();
      },
      tablet: (BuildContext context) {
        return const LoginWeb();
      },
    );
  }
}
