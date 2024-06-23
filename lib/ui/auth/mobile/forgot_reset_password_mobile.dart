import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/forgot_reset_password_controller.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/auth/mobile/helper/forgot_password_continue_button.dart';
import 'package:kody_operator/ui/auth/mobile/helper/forgot_password_form.dart';
import 'package:kody_operator/ui/auth/mobile/helper/reset_password_form.dart';
import 'package:kody_operator/ui/auth/mobile/helper/top_widget.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';

class ForgotResetPasswordMobile extends ConsumerStatefulWidget {
  final bool isForgotPassword;

  const ForgotResetPasswordMobile({Key? key, required this.isForgotPassword}) : super(key: key);

  @override
  ConsumerState<ForgotResetPasswordMobile> createState() => _ForgotResetPasswordMobileState();
}

class _ForgotResetPasswordMobileState extends ConsumerState<ForgotResetPasswordMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
      forgotResetPasswordWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(milliseconds: 100), () {
        forgotResetPasswordWatch.disposeFormKey();
      });
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.clrEAE9E4,
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: Stack(
        children: [
          TopWidget(
            fromScreen: widget.isForgotPassword ? FromScreen.forgotPassword : FromScreen.resetPassword,
            strTitle: widget.isForgotPassword ? LocalizationStrings.keyForgetPasswordTitle.localized : LocalizationStrings.keyResetPassword.localized,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)), color: AppColors.white),
                  height: context.height * 0.3,
                  child: widget.isForgotPassword ? const ForgotPasswordForm() : const ResetPasswordFormWidget(),
                ),
                Container(
                  color: AppColors.white,
                  child: widget.isForgotPassword ? ForgotPasswordContinueButton() : const ForgotPasswordBottomWidget(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ForgotPasswordBottomWidget extends StatelessWidget {
  const ForgotPasswordBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final resetPasswordWatch = ref.watch(forgotResetPasswordController);
        return SlideLeftTransition(
          delay: 300,
          child: CommonButtonMobile(
            withBackground: true,
            onValidateTap: () {
              resetPasswordWatch.resetFormKey.currentState?.validate();
            },
            onTap: () async {
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
            },
            buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: resetPasswordWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
            buttonText: LocalizationStrings.keySubmit.localized,
            rightIcon: Icon(Icons.arrow_forward, color: resetPasswordWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
            isButtonEnabled: resetPasswordWatch.isAllFieldsValid,
            isLoading: resetPasswordWatch.resetPasswordState.isLoading,
          ),
        );
      },
    );
  }
}
