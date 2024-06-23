import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/forgot_reset_password_controller.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class ResetPasswordFormWidget extends ConsumerWidget with BaseConsumerWidget {
  const ResetPasswordFormWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    final resetPasswordWatch = ref.watch(forgotResetPasswordController);
    return Form(
      key: resetPasswordWatch.resetFormKey,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          /// Password Field
          SlideLeftTransition(
            delay: 100,
            child: CommonInputFormField(
              obscureText: !resetPasswordWatch.isShowNewPassword,
              textEditingController: resetPasswordWatch.newPasswordCtr,
              hintText: LocalizationStrings.keyNewPassword.localized,
              cursorColor: AppColors.black,
              textInputFormatter: [LengthLimitingTextInputFormatter(maxPasswordLength)],
              validator: (password) {
                return validateNewPassword(password);
              },
              onChanged: (password) {
                resetPasswordWatch.checkIfPasswordFieldsValid();
              },
              onFieldSubmitted: (password) {
                context.nextField;
                context.nextField;
              },
              suffixWidget: IconButton(
                onPressed: () {
                  resetPasswordWatch.changeNewPasswordVisibility();
                },
                icon: CommonSVG(
                  strIcon: resetPasswordWatch.isShowNewPassword ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
                  svgColor: AppColors.clr8D8D8D,
                ),
              ),
            ).paddingOnly(bottom: 31.h),
          ),

          /// Confirm Password Field
          SlideLeftTransition(
            delay: 200,
            child: CommonInputFormField(
              obscureText: !resetPasswordWatch.isShowConfirmPassword,
              textEditingController: resetPasswordWatch.confirmPasswordCtr,
              hintText: LocalizationStrings.keyConfirmPassword.localized,
              textInputAction: TextInputAction.done,
              cursorColor: AppColors.black,
              onChanged: (email) {
                resetPasswordWatch.checkIfPasswordFieldsValid();
              },
              onFieldSubmitted: (value) async {
              if (resetPasswordWatch.isAllFieldsValid) {
                hideKeyboard(context);
                await _resetPasswordApiCall(context, ref);
              }
            },
              textInputFormatter: [LengthLimitingTextInputFormatter(maxPasswordLength)],
              validator: (password) {
                if (password != null && password.length > 7 && password != resetPasswordWatch.newPasswordCtr.text) {
                  return LocalizationStrings.keyConfirmPasswordMustAsPassword.localized;
                } else {
                  return validateConfirmPasswordResetPass(password);
                }
              },
              suffixWidget: IconButton(
                onPressed: () {
                  resetPasswordWatch.changeConfirmPasswordVisibility();
                },
                icon: CommonSVG(
                  strIcon: resetPasswordWatch.isShowConfirmPassword ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
                  svgColor: AppColors.clr8D8D8D,
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}

/// Reset Password Api Call
Future<void> _resetPasswordApiCall(BuildContext context, WidgetRef ref ) async {
  final resetPasswordWatch = ref.watch(forgotResetPasswordController);
  if (resetPasswordWatch.resetFormKey.currentState?.validate() ?? false) {
    await resetPasswordWatch.resetPasswordApi(context, ref.read(otpVerificationController).otpController.text);
    if(resetPasswordWatch.resetPasswordState.success?.status == ApiEndPoints.apiStatus_200) {
      if(context.mounted){
        showCommonSuccessDialogMobile(
            context:context,
            titleText: resetPasswordWatch.resetPasswordState.success?.message,

            onButtonTap: (){
              Navigator.of(context).pop();
              ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.login());
            });
      }

    }
  }
}