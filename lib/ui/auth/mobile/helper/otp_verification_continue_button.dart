import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/forgot_reset_password_controller.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_right_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';

class OtpVerificationBottomButtons extends StatelessWidget with BaseStatelessWidget {
  final FromScreen fromScreen;
  const OtpVerificationBottomButtons({super.key, required this.fromScreen});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final otpVerificationWatch = ref.watch(otpVerificationController);
        final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
        return SlideRightTransition(
          delay: 300,
          child: Column(
            children: [
              CommonButtonMobile(
                onTap: () async {
                  await forgotResetPasswordWatch.forgotPasswordApi(context);
                  if(forgotResetPasswordWatch.forgotPasswordState.success?.status == ApiEndPoints.apiStatus_200) {
                    if (otpVerificationWatch.counterSeconds == 0) {
                      otpVerificationWatch.focusNode.previousFocus();
                      otpVerificationWatch.disposeController(isNotify: true);
                      otpVerificationWatch.startCounter();
                    }
                  }
                },
                onValidateTap: (){
                  otpVerificationWatch.checkIfAllFieldsValid();
                  otpVerificationWatch.formKey.currentState?.validate();
                },
                buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: (otpVerificationWatch.counterSeconds == 0) ? AppColors.primary2 : AppColors.primary2),
                buttonText:
                    '${(otpVerificationWatch.counterSeconds == 0) ? LocalizationStrings.keyResendCode.localized : LocalizationStrings.keyResendCodeIn.localized} ${(otpVerificationWatch.counterSeconds == 0) ? '' : otpVerificationWatch.getCounterSeconds()}',
                buttonEnabledColor: AppColors.white,
                buttonDisabledColor: AppColors.white,
                borderColor: AppColors.grey8F8F8F,
                isButtonEnabled: (otpVerificationWatch.counterSeconds == 0) && !otpVerificationWatch.verifyOtpState.isLoading,
                isLoading: forgotResetPasswordWatch.forgotPasswordState.isLoading,
                loadingAnimationColor: AppColors.primary2,
              ),
              SizedBox(height: 20.h),
              SlideLeftTransition(
                delay: 300,
                child: CommonButtonMobile(
                  absorbing: otpVerificationWatch.verifyOtpState.isLoading,
                  onValidateTap: () {
                    otpVerificationWatch.formKey.currentState?.validate();
                  },
                  onTap: () async {
                    await otpVerificationWatch.verifyOtpApi(context, ref.read(forgotResetPasswordController).emailController.text);
                    if(otpVerificationWatch.verifyOtpState.success?.status == ApiEndPoints.apiStatus_200) {
                      ref.read(navigationStackProvider).pushRemoveUntil(
                          const NavigationStackItem.forgotResetPassword(
                              isForgotPassword: false),const NavigationStackItem.login());
                    }
                  },
                  buttonTextColor: otpVerificationWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor,
                  buttonText: LocalizationStrings.keySubmit.localized,
                  rightIcon: Icon(Icons.arrow_forward, color: otpVerificationWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
                  isButtonEnabled: otpVerificationWatch.isAllFieldsValid && !forgotResetPasswordWatch.forgotPasswordState.isLoading,
                  isLoading: otpVerificationWatch.verifyOtpState.isLoading,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
