import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ChangePasswordVerifyOtpDialog extends ConsumerWidget
    with BaseConsumerWidget {
  const ChangePasswordVerifyOtpDialog({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final profileWatch = ref.watch(profileController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocalizationStrings.keyChangePassword.localized,
              style: TextStyles.regular.copyWith(
                fontSize: 24.sp,
                color: AppColors.black171717,
              ),
            ),
            InkWell(
              onTap: () {
                profileWatch.passwordOtpController.clear();
                Navigator.pop(context);
              },
              child: CommonSVG(
                strIcon: AppAssets.svgCrossIcon,
                width: 44.w,
                height: 44.h,
              ),
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            text: LocalizationStrings.keyWeHaveSentYouAnOtp.localized,
            style: TextStyles.regular.copyWith(
              fontSize: 16.sp,
              color: AppColors.black171717,
            ),
            children: [
              TextSpan(
                text: profileWatch.email,
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
        Form(
          key: profileWatch.passwordVerifyOtpKey,
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
              fieldWidth: context.height * 0.07,
              fieldHeight: context.height * 0.07,
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
              InkWell(
                onTap: () {
                  if (profileWatch.counterSeconds == 0) {
                    profileWatch.startCounter();
                    profileWatch.emailOtpController.clear();
                  }
                },
                child: CommonText(
                  title:
                      '${(profileWatch.counterSeconds == 0) ? LocalizationStrings.keyResendCode.localized : LocalizationStrings.keyResendCodeIn.localized} ${(profileWatch.counterSeconds == 0) ? '' : profileWatch.getCounterSeconds()}',
                  textStyle: TextStyles.medium.copyWith(
                    color: AppColors.blue009AF1,
                    decorationColor: AppColors.blue009AF1,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
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
        CommonButton(
          onTap: () {
            profileWatch.updatePassword();
            Navigator.pop(context);
            showCommonAnimationDialog(
              context: context,
              animationWidget: Column(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: Lottie.asset(
                      AppAssets.animChangePasswordSuccess,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              title:
                  LocalizationStrings.keyChangePasswordSuccessfully.localized,
              description:
                  LocalizationStrings.keyYourRequestForwardedToAdmin.localized,
              buttonText: LocalizationStrings.keyClose.localized,
            );
          },
          width: context.width * 0.1,
          height: 60.h,
          buttonText: LocalizationStrings.keySubmit.localized,
          isButtonEnabled: profileWatch.isEmailVerifyOtpValid,
        )
      ],
    );
  }
}
