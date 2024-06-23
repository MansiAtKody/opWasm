import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/profile/change_password_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
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
import 'package:lottie/lottie.dart';

class ChangePasswordDialog extends StatelessWidget with BaseStatelessWidget {
  const ChangePasswordDialog({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final profileWatch = ref.watch(profileController);
        final changePasswordWatch = ref.watch(changePasswordController);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                    key: profileWatch.changePasswordKey,
                    child: Column(
                      children: [
                        CommonInputFormField(
                          obscureText: !changePasswordWatch.isShowCurrentPassword,
                          textEditingController:
                              profileWatch.oldPasswordController,
                          hintText: LocalizationStrings.keyOldPassword.localized,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).nextFocus();
                          },
                          onChanged: (value) {
                            profileWatch.checkIfPasswordValid();
                          },
                          validator: (value) {
                            ///Confirm whether entered Password is same as previous Password
                            return validatePassword(value);
                          },
                          suffixWidget: IconButton(
                            onPressed: () {
                              changePasswordWatch.changeCurrentPasswordVisibility();
                            },
                            icon: CommonSVG(
                              strIcon: changePasswordWatch.isShowCurrentPassword ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
                            ),
                          ),
                        ).paddingSymmetric(vertical: 15.h),
                        CommonInputFormField(
                          obscureText: !changePasswordWatch.isShowNewPassword,
                          textEditingController:
                              profileWatch.newPasswordController,
                          hintText: LocalizationStrings.keyNewPassword.localized,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).nextFocus();
                          },
                          onChanged: (value) {
                            profileWatch.checkIfPasswordValid();
                          },
                          suffixWidget: IconButton(
                            onPressed: () {
                              changePasswordWatch.changeNewPasswordVisibility();
                            },
                            icon: CommonSVG(
                              strIcon: changePasswordWatch.isShowNewPassword ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
                            ),
                          ),
                          validator: (value) {
                            // if (validatePassword(value) == null) {
                            //   return profileWatch
                            //       .checkIfNewPasswordIsSameAsConfirmPassword();
                            // }
                             return validatePassword(value);
                            // return profileWatch
                            //           .checkIfNewPasswordIsSameAsConfirmPassword()
                            //       ? validatePassword(value)
                            //       : LocalizationStrings.keyNewPasswordAndConfirmPassword.localized;
                          },
                        ).paddingSymmetric(vertical: 15.h),
                        CommonInputFormField(
                            obscureText: !changePasswordWatch.isShowConfirmPassword,
                            textEditingController:
                              profileWatch.confirmNewPasswordController,
                          hintText: LocalizationStrings.keyConfirmPassword.localized,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {
                            hideKeyboard(context);
                            },
                          onChanged: (value) {
                            profileWatch.checkIfPasswordValid();
                          },
                            suffixWidget: IconButton(
                              onPressed: () {
                                changePasswordWatch.changeConfirmPasswordVisibility();
                              },
                              icon: CommonSVG(
                                strIcon: changePasswordWatch.isShowConfirmPassword ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
                              ),
                            ),
                          validator: (value) {
                            return profileWatch
                                .checkIfNewPasswordIsSameAsConfirmPassword()
                                ? validatePassword(value)
                                : LocalizationStrings.keyNewPasswordAndConfirmPassword.localized;
                          }
                        ).paddingSymmetric(vertical: 15.h),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              CommonButton(
                onTap: () async {
                  // profileWatch.updateTempPassword();
                  // profileWatch.updatePassword();
                  //profileWatch.startCounter();
                  await profileWatch.changePassword(context: context,oldPass: profileWatch.oldPasswordController.text,confirmPass: profileWatch.confirmNewPasswordController.text);
                  ///Change Password Success Animation
                  if (profileWatch.changePasswordState.success?.status == ApiEndPoints.apiStatus_200) {
                    Session.saveLocalData(keyUserAuthToken, profileWatch.changePasswordState.success?.data?.accessToken);
                    Session.saveLocalData(keyUserPassword, profileWatch.confirmNewPasswordController.text);
                    ///Change Password Success Animation
                    if(context.mounted){
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
                            ),
                          ],
                        ).paddingOnly(right: 10.w),
                        title: LocalizationStrings.keyChangePasswordSuccessfully.localized,
                        description: LocalizationStrings.keyYourRequestForwardedToAdmin.localized,
                        buttonText: LocalizationStrings.keyClose.localized,
                      );
                    }
                  }
                },
                width: context.width * 0.1,
                height: 60.h,
                buttonText: LocalizationStrings.keySubmit.localized,
                buttonTextStyle: TextStyles.regular.copyWith(
                  color: profileWatch.isPasswordFieldsValid
                      ? AppColors.white
                      : AppColors.black171717,
                ),
                isLoading: profileWatch.changePasswordState.isLoading,
                isButtonEnabled: profileWatch.isPasswordFieldsValid,
              ),
            ],
          ).paddingSymmetric(
            horizontal: 50.w,
            vertical: 30.h,
          ),
        );
      },
    );
  }
}
