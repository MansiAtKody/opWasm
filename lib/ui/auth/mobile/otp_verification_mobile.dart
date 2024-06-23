import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/forgot_reset_password_controller.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/auth/mobile/helper/otp_verification_continue_button.dart';
import 'package:kody_operator/ui/auth/mobile/helper/otp_verification_form.dart';
import 'package:kody_operator/ui/auth/mobile/helper/top_widget.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class OtpVerificationMobile extends ConsumerStatefulWidget {
  final String email;
  final FromScreen fromScreen;
  const OtpVerificationMobile( {Key? key,required this.email, required this.fromScreen,}) : super(key: key);

  @override
  ConsumerState<OtpVerificationMobile> createState() => _OtpVerificationMobileState();
}

class _OtpVerificationMobileState extends ConsumerState<OtpVerificationMobile> {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final otpVerificationMobileWatch = ref.watch(otpVerificationController);
      otpVerificationMobileWatch.counter?.cancel();
      otpVerificationMobileWatch.startCounter();
      otpVerificationMobileWatch.disposeController(isNotify: true);
    });
  }

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      backgroundColor: AppColors.white,
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final resetPasswordWatch = ref.watch(forgotResetPasswordController);
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: Stack(
        children: [
          TopWidget(
            fromScreen: FromScreen.otpVerification,
            strTitle: LocalizationStrings.keyOtpVerification.localized,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)), color: AppColors.white),
                  height: context.height * 0.3,
                  child: SingleChildScrollView(
                    child: OtpVerificationForm(email: resetPasswordWatch.emailController.text, fromScreen: widget.fromScreen,).paddingSymmetric(horizontal: 20.w),
                  ),
                ),
                Container(
                  color: AppColors.white,
                  child: const OtpVerificationBottomButtons(fromScreen: FromScreen.forgotPassword).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
