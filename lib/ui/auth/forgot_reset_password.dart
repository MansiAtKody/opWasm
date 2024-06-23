import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/auth/mobile/forgot_reset_password_mobile.dart';
import 'package:kody_operator/ui/auth/web/forgot_reset_password_web.dart';

class ForgotResetPassword extends StatelessWidget {
  final bool isForgotPassword;

  const ForgotResetPassword({Key? key, required this.isForgotPassword}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return  ForgotResetPasswordMobile(isForgotPassword: isForgotPassword,
        );
      },
      desktop: (BuildContext context) {
        return ForgotResetPasswordWeb(
          isForgotPassword: isForgotPassword,
        );
      },
      tablet: (BuildContext context) {
        return ForgotResetPasswordWeb(
          isForgotPassword: isForgotPassword,
        );
      },
    );
  }
}
