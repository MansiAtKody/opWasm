import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class ChangeEmailVerifyOtpDialog extends ConsumerWidget
    with BaseConsumerWidget {
  final String email;
  const ChangeEmailVerifyOtpDialog({
    super.key,
    required this.email,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final profileWatch = ref.watch(profileController);
    final otpVerificationWatch = ref.watch(otpVerificationController);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocalizationStrings.keyOtpVerify.localized,
                  style: TextStyles.regular.copyWith(
                    fontSize: 24.sp,
                    color: AppColors.black171717,
                  ),
                ),
                InkWell(
                  onTap: () {
                    profileWatch.emailOtpController.clear();
                    Navigator.pop(context);
                  },
                  child: CommonSVG(
                    strIcon: AppAssets.svgCrossRounded,
                    width: 44.w,
                    height: 44.h,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            RichText(
              text: TextSpan(
                text: '${LocalizationStrings.keyWeHaveSentYouAnOtp.localized} ',
                style: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.black171717,
                ),
                children: [
                  TextSpan(
                    text: profileWatch.tempEmail,
                    style: TextStyles.regular.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.black171717,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.black171717,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),

            /// OTP Text Field
            Form(
              key: profileWatch.emailVerifyOtpKey,
              child: PinCodeTextField(
                appContext: context,
                autoDisposeControllers: false,
                cursorColor: AppColors.black171717,
                length: 6,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                controller: profileWatch.emailOtpController,
                keyboardType: TextInputType.number,
                onChanged: (code) {
                  profileWatch.checkIfOtpValid();
                },
                textStyle: TextStyles.regular.copyWith(
                  color: AppColors.black,
                ),
                onCompleted: (String? code) {},
                pinTheme: PinTheme(
                  borderRadius: BorderRadius.circular(10.r),
                  shape: PinCodeFieldShape.box,
                  fieldWidth: context.height * 0.1,
                  fieldHeight: context.height * 0.1,
                  activeColor: AppColors.textFieldBorderColor,
                  inactiveColor: AppColors.textFieldBorderColor,
                  selectedColor: AppColors.textFieldBorderColor,
                  fieldOuterPadding: EdgeInsets.zero,
                  activeBorderWidth: 1.w,
                  selectedBorderWidth: 1.w,
                  inactiveBorderWidth: 1.w,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Resend OTP Button
                  InkWell(
                    onTap: () async{
                      if (profileWatch.counterSeconds == 0) {
                        profileWatch.startCounter();
                        profileWatch.emailOtpController.clear();
                        await resendOTP(context,ref);
                      }
                    },
                    child: CommonText(
                      title:
                      '${(profileWatch.counterSeconds == 0) ?
                      LocalizationStrings.keyResendCode.localized :
                      LocalizationStrings.keyResendCodeIn.localized} ${(profileWatch.counterSeconds == 0) ? '' : profileWatch.getCounterSeconds()}',
                      textStyle: TextStyles.medium.copyWith(
                        color: AppColors.blue009AF1,
                        decorationColor: AppColors.blue009AF1,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  ///Edit Email Button
                  RichText(
                    text: TextSpan(
                      text: LocalizationStrings.keyNotYourEmailId.localized,
                      style: TextStyles.medium.copyWith(
                        color: AppColors.black171717,
                      ),
                      children: [
                        TextSpan(
                          text: ' ${LocalizationStrings.keyEdit.localized}',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              profileWatch.emailOtpController.clear();
                              Navigator.pop(context);
                            },
                          style: TextStyles.medium.copyWith(
                            color: AppColors.blue009AF1,
                            decorationColor: AppColors.blue009AF1,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///Submit OTP Button
            CommonButton(

              onTap: () async{
                /// Call the update email API
                await updateEmail(context,ref);
              },
              width: context.width * 0.1,
              height: 60.h,
              isLoading:profileWatch.updateEmailState.isLoading,
              buttonTextStyle: TextStyles.regular.copyWith(
                fontSize: 14.sp,
                color: profileWatch.isEmailVerifyOtpValid ? AppColors.white : AppColors.black,
              ),
              buttonText: LocalizationStrings.keySubmit.localized,
              isButtonEnabled: profileWatch.isEmailVerifyOtpValid,
            )
          ],
        ),
        DialogProgressBar(isLoading: otpVerificationWatch.resendOtpState.isLoading,),
      ],
    );
  }


  /// Update Email API
  Future<void> updateEmail(BuildContext context, WidgetRef ref) async {
    final profileWatch = ref.watch(profileController);
    await profileWatch.updateEmailMobileApi(context,true, otp:profileWatch.emailOtpController.text, password: profileWatch.emailPasswordController.text);
    if (profileWatch.updateEmailState.success?.status == ApiEndPoints.apiStatus_200) {
      profileWatch.updateEmail();
      Session.saveLocalData(keyUserAuthToken, profileWatch.updateEmailState.success?.data?.accessToken??'');
      profileWatch.profileDetailState.success?.data?.email =email ;

      ///Show Success Animation
      if(context.mounted)
      {
        Navigator.of(context).pop();
        profileWatch.disposeController(isNotify: true);
        profileWatch.clearFormData();
        showCommonAnimationDialog(
          context: context,
          animationWidget: Column(
            children: [
              const Spacer(),
              Expanded(
                flex: 4,
                child: Lottie.asset(
                  AppAssets.animChangeEmailSuccess,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ).paddingOnly(right: 10.w),
          title: LocalizationStrings.keyChangeEmailSuccessfully.localized,
          description: LocalizationStrings.keyYourRequestForwardedToAdmin.localized,
          buttonText: LocalizationStrings.keyClose.localized,
          buttonTextStyle: TextStyles.regular.copyWith(
            fontSize: 23.sp,
            color: AppColors.white,
          ),
          item: const NavigationStackItem.profile(),
        );
      }
    }
  }


  /// Resend OTP
  Future<void> resendOTP(BuildContext context, WidgetRef ref) async {
    final otpVerificationWatch = ref.watch(otpVerificationController);
    await otpVerificationWatch.resendOtpApi(context, email: email);
    if (otpVerificationWatch.resendOtpState.success?.status == ApiEndPoints.apiStatus_200) {
      if(context.mounted)
      {
        showCommonErrorDialog(context: context, message:LocalizationStrings.keyResendOTPMessage.localized);
      }
    }
  }
}
