import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/profile/mobile/otp_verification_profile_module_mobile.dart';
import 'package:kody_operator/ui/profile/web/otp_verification_profile_module_web.dart';

class OtpVerificationProfileModule extends StatelessWidget {
  final String email;
  final FromScreen fromScreen;
  final String? currentPassword;
  const OtpVerificationProfileModule({Key? key, required this.email, required this.fromScreen,this.currentPassword}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return OtpVerificationProfileModuleMobile(email: email, fromScreen: fromScreen,currentPassword: currentPassword,);
        },
        desktop: (BuildContext context) {
          return const OtpVerificationProfileModuleWeb();
        }
    );
  }
}

