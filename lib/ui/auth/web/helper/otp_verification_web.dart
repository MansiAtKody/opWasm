import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/forgot_reset_password_controller.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationHelperWeb extends ConsumerWidget with BaseConsumerWidget {
  final String email;
  final FromScreen fromScreen;

  const OtpVerificationHelperWeb(
      {super.key, required this.email, required this.fromScreen});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final otpVerificationWatch = ref.watch(otpVerificationController);
    final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            title: LocalizationStrings.keyEnterOTP.localized,
            textStyle: TextStyles.medium
                .copyWith(color: AppColors.clr171717, fontSize: 30.sp),
          ).paddingOnly(bottom: 30.h, top: 40.h),
          RichText(
                  text: TextSpan(
                      children: [
                TextSpan(
                    text: email.isNotEmpty ? '$email' : '',
                    style: TextStyles.regular.copyWith(
                      color: AppColors.clr171717,
                      fontSize: 16.sp,
                      decoration: TextDecoration.underline,
                    ))
              ],
                      text: '${LocalizationStrings.keyEnterOTPDesc.localized} ',
                      style: TextStyles.regular.copyWith(
                          color: AppColors.clr171717, fontSize: 16.sp)))
              .paddingOnly(bottom: 40.h),
          Form(
            key: otpVerificationWatch.formKey,
            child: PinCodeTextField(
              autoFocus: true,
              appContext: context,
              autoDisposeControllers: false,
              cursorColor: AppColors.blue009AF1,
              length: 6,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6)
              ],
              controller: otpVerificationWatch.otpController,
              keyboardType: TextInputType.number,
              onChanged: (code) {
                otpVerificationWatch.checkIfAllFieldsValid();
              },
              textStyle: TextStyles.regular.copyWith(
                color: AppColors.black,
              ),
              onCompleted: (String? code) {
                otpVerificationWatch.checkIfAllFieldsValid();
              },
              validator: (v) {
                return validateOtp(v);
              },
              pinTheme: PinTheme(
                borderRadius: BorderRadius.circular(4.r),
                shape: PinCodeFieldShape.box,
                activeColor: AppColors.textFieldBorderColor,
                inactiveColor: AppColors.textFieldBorderColor,
                selectedColor: AppColors.blue009AF1,
                fieldHeight: context.width * 0.035,
                fieldWidth: context.width * 0.035,
                activeBorderWidth: 1.w,
                selectedBorderWidth: 1.w,
                inactiveBorderWidth: 1.w,
              ),
            ),
          ).paddingOnly(bottom: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  if (otpVerificationWatch.counterSeconds == 0) {
                    final forgotResetPasswordWatch =
                        ref.watch(forgotResetPasswordController);
                    await forgotResetPasswordWatch.forgotPasswordApi(context);
                    if (forgotResetPasswordWatch
                            .forgotPasswordState.success?.status ==
                        ApiEndPoints.apiStatus_200) {
                      if (otpVerificationWatch.counterSeconds == 0) {
                        otpVerificationWatch.startCounter();
                        otpVerificationWatch.otpController.clear();
                      }
                    }
                  }
                },
                child: forgotResetPasswordWatch.forgotPasswordState.isLoading
                    ? LoadingAnimationWidget.waveDots(
                        color: AppColors.primary2,
                        size: 48.h,
                      )
                    : CommonText(
                        title:
                            '${(otpVerificationWatch.counterSeconds == 0) ? LocalizationStrings.keyResendCode.localized : LocalizationStrings.keyResendCodeIn.localized} ${(otpVerificationWatch.counterSeconds == 0) ? '' : otpVerificationWatch.getCounterSeconds()}',
                        textStyle: TextStyles.regular.copyWith(
                            color: AppColors.clr009AF1, fontSize: 16.sp),
                      ),
              ),
              RichText(
                  text: TextSpan(
                      children: [
                    TextSpan(
                      text: ' ${LocalizationStrings.keyEdit.localized}',
                      style: TextStyles.regular.copyWith(
                        color: AppColors.clr009AF1,
                        fontSize: 16.sp,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          ref.read(navigationStackProvider).pop();
                        },
                    )
                  ],
                      text: LocalizationStrings.keyNotYourEmailId.localized,
                      style: TextStyles.regular.copyWith(
                        color: Colors.black,
                        fontSize: 16.sp,
                      )))
            ],
          ).paddingOnly(bottom: 30.h),

          /// Submit Button
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  onTap: () async {
                    await otpVerificationWatch.verifyOtpApi(
                        context,
                        ref
                            .read(forgotResetPasswordController)
                            .emailController
                            .text);
                    if (otpVerificationWatch.verifyOtpState.success?.status ==
                        ApiEndPoints.apiStatus_200) {
                      ref.read(navigationStackProvider).pushRemoveUntil(
                          const NavigationStackItem.forgotResetPassword(
                              isForgotPassword: false),
                          const NavigationStackItem.login());
                    }
                  },
                  onValidateTap: () {
                    otpVerificationWatch.formKey.currentState?.validate();
                  },
                  buttonTextStyle: TextStyles.regular.copyWith(
                      fontSize: 18.sp,
                      color: otpVerificationWatch.isAllFieldsValid
                          ? AppColors.white
                          : AppColors.clr616161),
                  buttonText: LocalizationStrings.keySubmit.localized,
                  isButtonEnabled: otpVerificationWatch.isAllFieldsValid &&
                      !forgotResetPasswordWatch.forgotPasswordState.isLoading,
                  isLoading: otpVerificationWatch.verifyOtpState.isLoading,
                ),
              ),
              const Expanded(flex: 2, child: SizedBox())
            ],
          ),
        ],
      ),
    );
  }
}
