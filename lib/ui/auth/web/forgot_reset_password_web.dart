import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/forgot_reset_password_controller.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/auth/web/helper/common_background_container.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ForgotResetPasswordWeb extends ConsumerStatefulWidget {
  final bool isForgotPassword;

  const ForgotResetPasswordWeb({Key? key, required this.isForgotPassword}) : super(key: key);

  @override
  ConsumerState<ForgotResetPasswordWeb> createState() => _ForgotResetPasswordWebState();
}

class _ForgotResetPasswordWebState extends ConsumerState<ForgotResetPasswordWeb> with BaseConsumerStatefulWidget{
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
      forgotResetPasswordWatch.disposeController(isNotify: true);

    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    // final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
    return CommonBackGroundContainer(fromScreen: widget.isForgotPassword ? FromScreen.forgotPassword : FromScreen.resetPassword, child: widget.isForgotPassword ? forgotPassword() : resetPassword());
  }

  /// Widget for forgot Password
  Widget forgotPassword() {
    final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            title: LocalizationStrings.keyForgetPassword.localized,
            textStyle: TextStyles.medium.copyWith(color: AppColors.clr171717, fontSize: 30.sp),
          ).paddingSymmetric(vertical: 40.h),

          /// Email Id
          Form(
            key: forgotResetPasswordWatch.formKey,
            child: CommonInputFormField(
              textEditingController: forgotResetPasswordWatch.emailController,
              hintText: LocalizationStrings.keyEmailId.localized,
              hasLabel: true,
              // focusNode: forgotResetPasswordWatch.emailFocus,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) async {
                if (forgotResetPasswordWatch.isAllFieldsValid) {
                  hideKeyboard(context);
                  await _forgotPasswordApiCall(context, ref);
                }
              },
              validator: (email) {
                return validateEmail(email);
              },
              onChanged: (email) {
                forgotResetPasswordWatch.checkIfAllFieldsValid();
              },
            ),
          ),

          /// Send OTP Button
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  onTap: () async {
                    await _forgotPasswordApiCall(context, ref);
                  },
                  onValidateTap: () {
                    forgotResetPasswordWatch.formKey.currentState?.validate();
                  },
                  buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: forgotResetPasswordWatch.isAllFieldsValid ? AppColors.white : AppColors.clr616161),
                  buttonText: LocalizationStrings.keySendOTP.localized,
                  isButtonEnabled: forgotResetPasswordWatch.isAllFieldsValid,
                  isLoading: forgotResetPasswordWatch.forgotPasswordState.isLoading,
                ),
              ),
              const Expanded(flex: 2, child: SizedBox())
            ],
          ).paddingSymmetric(vertical: 40.h),

        ],
      ),
    );
  }

  /// Widget for Reset Password
  Widget resetPassword() {
    final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            title: LocalizationStrings.keyResetPassword.localized,
            textStyle: TextStyles.medium.copyWith(color: AppColors.clr171717, fontSize: 30.sp),
          ).paddingSymmetric(vertical: 40.h),

          /// Email Id
          Form(
            key: forgotResetPasswordWatch.resetFormKey,
            child: Column(
              children: [
                CommonInputFormField(
                  obscureText: !forgotResetPasswordWatch.isShowNewPassword,
                  textEditingController: forgotResetPasswordWatch.newPasswordCtr,
                  hintText: LocalizationStrings.keyNewPassword.localized,
                  hasLabel: true,
                  validator: (password) {
                    return validatePassword(password);
                  },
                  onChanged: (password) {
                    forgotResetPasswordWatch.checkIfPasswordFieldsValid();
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    context.nextField;
                    context.nextField;
                  },
                  hintTextStyle: TextStyles.regular.copyWith(color: AppColors.clr8D8D8D, fontSize: 14.sp),
                  suffixWidget: IconButton(
                    onPressed: () {
                      forgotResetPasswordWatch.changeNewPasswordVisibility();
                    },
                    icon: CommonSVG(
                      strIcon: !forgotResetPasswordWatch.isShowNewPassword ? AppAssets.svgShowPassword : AppAssets.svgHidePassword,
                      svgColor: AppColors.clr8D8D8D,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                CommonInputFormField(
                  obscureText: !forgotResetPasswordWatch.isShowConfirmPassword,
                  textEditingController: forgotResetPasswordWatch.confirmPasswordCtr,
                  hintText: LocalizationStrings.keyConfirmPassword.localized,
                  hasLabel: true,
                  validator: (password) {
                    return validateConfirmPassword(password, forgotResetPasswordWatch.newPasswordCtr.text);
                  },
                  onChanged: (password) {
                    forgotResetPasswordWatch.checkIfPasswordFieldsValid();
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) async {
                    if (forgotResetPasswordWatch.isAllFieldsValid) {
                      hideKeyboard(context);
                      await _resetPasswordApiCall(context, ref);
                    }
                  },
                  hintTextStyle: TextStyles.regular.copyWith(color: AppColors.clr8D8D8D, fontSize: 14.sp),
                  suffixWidget: IconButton(
                    onPressed: () {
                      forgotResetPasswordWatch.changeConfirmPasswordVisibility();
                    },
                    icon: CommonSVG(
                      strIcon: !forgotResetPasswordWatch.isShowConfirmPassword ? AppAssets.svgShowPassword : AppAssets.svgHidePassword,
                      svgColor: AppColors.clr8D8D8D,
                    ),
                  ),
                ),
              ],
            ),
          ).paddingOnly(bottom: 40.h),

          /// Submit Button
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  onTap: () async {
                    await _resetPasswordApiCall(context, ref);
                  },
                  buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: forgotResetPasswordWatch.isAllFieldsValid ? AppColors.white : AppColors.clr616161),
                  buttonText: LocalizationStrings.keySubmit.localized,
                  isButtonEnabled: forgotResetPasswordWatch.isAllFieldsValid,
                  isLoading: forgotResetPasswordWatch.resetPasswordState.isLoading,
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

/// Forgot Password Api Call
Future<void> _forgotPasswordApiCall(BuildContext context, WidgetRef ref) async {
  final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
  await forgotResetPasswordWatch.forgotPasswordApi(context);
  if(forgotResetPasswordWatch.forgotPasswordState.success?.status == ApiEndPoints.apiStatus_200) {
    ref.read(navigationStackProvider).push(  NavigationStackItem.otpVerification(email: forgotResetPasswordWatch.emailController.text, fromScreen: FromScreen.forgotPassword));
    forgotResetPasswordWatch.setEmail();
  }
}

/// Reset Password Api Call
Future<void> _resetPasswordApiCall(BuildContext context, WidgetRef ref) async {
  final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
  await forgotResetPasswordWatch.resetPasswordApi(context, ref.read(otpVerificationController).otpController.text);
  if(forgotResetPasswordWatch.resetPasswordState.success?.status == ApiEndPoints.apiStatus_200) {
    if(context.mounted){
      showCommonAnimationDialog(
          context: context, image: AppAssets.icChangePasswordSuccess,
          title: LocalizationStrings.keyChangePasswordSuccessfully.localized, description: forgotResetPasswordWatch.resetPasswordState.success?.message??'', buttonText:  LocalizationStrings.keyClose.localized,
          onButtonTap: (){
            ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.login());
          }
      );
    }
  }
}

