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
import 'package:kody_operator/ui/profile/web/helper/change_email_verify_otp_dialog.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ChangeEmailDialog extends ConsumerWidget with BaseConsumerWidget {
  const ChangeEmailDialog({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final profileWatch = ref.watch(profileController);
    final otpVerificationWatch = ref.watch(otpVerificationController);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                title: LocalizationStrings.keyChangeEmail.localized,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 24.sp,
                  color: AppColors.black171717,
                ),
              ),
              InkWell(
                onTap: () {
                  profileWatch.clearFormData();
                   profileWatch.disposeKeys();
                  Navigator.pop(context);
                },
                child:   const CommonSVG(
                  strIcon: AppAssets.svgCrossRounded,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Form(
                key: profileWatch.changeEmailKey,
                child: Column(
                  children: [
                    CommonInputFormField(
                      textEditingController: profileWatch.newEmailController,
                      hintText: LocalizationStrings.keyNewEmail.localized,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        context.nextField;
                      },
                      onChanged: (value) {
                        profileWatch.checkIfEmailValid();
                      },
                      validator: (value) {
                        /*  if (validateEmail(value) == null) {
                          return profileWatch
                              .checkIfNewEmailIsNotSameAsOldEmail();
                        }*/
                        return validateEmail(value);
                      },
                    ).paddingSymmetric(vertical: 15.h),
                    CommonInputFormField(
                      obscureText: !profileWatch.isShowNewPassword,
                      textEditingController: profileWatch.emailPasswordController,
                      maxLength: 16,
                      hintText: LocalizationStrings.keyCurrentPassword.localized,
                      textInputAction: TextInputAction.next,
                      textInputFormatter: [
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                      ],
                      validator: (password) {
                        return validateCurrentPassword(password);
                      },
                      onChanged: (password) {
                        profileWatch.checkIfEmailValid();
                      },
                      suffixWidget: IconButton(
                        onPressed: () {
                          profileWatch.changePasswordVisibility();
                        },
                        icon: CommonSVG(
                          strIcon: profileWatch.isShowNewPassword ? AppAssets.svgShowPassword : AppAssets.svgHidePassword,
                        ),
                      ),
                    )

/*
                    CommonInputFormField(
                      textEditingController:
                      profileWatch.confirmNewEmailController,
                      hintText: LocalizationStrings.keyReEnter.localized,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        hideKeyboard(context);
                      },
                      onChanged: (value) {
                        profileWatch.checkIfEmailValid();
                      },
                      validator: (value) {
                        return profileWatch
                            .checkIfNewEmailIsSameAsConfirmEmail()
                            ? null
                            : LocalizationStrings
                            .keyNewEmailAndConfirmEmail.localized;
                      },
                    ).paddingSymmetric(vertical: 15.h),
*/
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          CommonButton(
            onTap: ()async {
              await sendOTP(context,ref);
            },
            isLoading:otpVerificationWatch.resendOtpState.isLoading || profileWatch.checkPasswordState.isLoading,
            width: context.width * 0.1,
            height: 60.h,
            buttonText: LocalizationStrings.keySave.localized,
            buttonTextStyle: TextStyles.regular.copyWith(
              color: profileWatch.isEmailFieldsValid
                  ? AppColors.white
                  : AppColors.black171717,
            ),
            isButtonEnabled: profileWatch.isEmailFieldsValid,
          ),
        ],
      ).paddingSymmetric(
        horizontal: 50.w,
        vertical: 30.h,
      ),
    );
  }

  Future<void> sendOTP(BuildContext context, WidgetRef ref) async {
    final otpVerificationWatch = ref.watch(otpVerificationController);
    final profileWatch = ref.watch(profileController);
    await profileWatch.checkPassword(context,profileWatch.emailPasswordController.text);
    if(profileWatch.checkPasswordState.success?.status== ApiEndPoints.apiStatus_200 && context.mounted) {
      await otpVerificationWatch.resendOtpApi(
          context, email: profileWatch.newEmailController.text);
      if (otpVerificationWatch.resendOtpState.success?.status ==
          ApiEndPoints.apiStatus_200) {
        profileWatch.updateTempEmail();
        profileWatch.startCounter();
        if (context.mounted) {
          showCommonDialog(
            context: context,
            height: context.height * 0.65,
            dialogBody: ChangeEmailVerifyOtpDialog(
              email: profileWatch.newEmailController.text,).paddingSymmetric(
              horizontal: 50.w,
              vertical: 30.h,
            ),
          );
        }
      }
    }
  }
}
