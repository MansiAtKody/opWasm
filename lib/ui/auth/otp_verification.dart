import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/auth/mobile/otp_verification_mobile.dart';
import 'package:kody_operator/ui/auth/web/otp_verification_web.dart';

class OtpVerification extends StatelessWidget {
  final String email;
  final FromScreen fromScreen;
  const OtpVerification({Key? key, required this.email, required this.fromScreen}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    print('email in otp>>>>$email');
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return  OtpVerificationMobile(email: email,fromScreen: fromScreen,);
      },
      desktop: (BuildContext context) {
        return OtpVerificationWeb(email: email, fromScreen: fromScreen,);
      },
        tablet: (BuildContext context) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.landscape
                  ? OtpVerificationWeb(email: email, fromScreen: fromScreen,) : OtpVerificationMobile(email: email,fromScreen: fromScreen,);
            },
          );
        }
    );
  }
}
