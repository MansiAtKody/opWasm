import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/forgot_reset_password_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';

class ForgotPasswordContinueButton extends StatelessWidget with BaseStatelessWidget {
   ForgotPasswordContinueButton({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return SlideUpTransition(
      duration: 300,
      delay: 200,
      child: Consumer(
        builder: (context, ref, child) {
          final forgotPasswordWatch = ref.watch(forgotResetPasswordController);
          return CommonButtonMobile(
            absorbing: forgotPasswordWatch.forgotPasswordState.isLoading,
            onTap: () async {
              await forgotPasswordWatch.forgotPasswordApi(context);
              if(forgotPasswordWatch.forgotPasswordState.success?.status == ApiEndPoints.apiStatus_200) {
                if(context.mounted){hideKeyboard(context);}
                ref.read(navigationStackProvider).push( NavigationStackItem.otpVerification(email: forgotPasswordWatch.emailController.text, fromScreen: FromScreen.forgotPassword));
              }
            },
            onValidateTap: () {
              forgotPasswordWatch.formKey.currentState?.validate();
            },
            withBackground: false,
            buttonTextStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: forgotPasswordWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
            buttonText: LocalizationStrings.keySendOTP.localized,
            rightIcon: Icon(Icons.arrow_forward, color: forgotPasswordWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
            isButtonEnabled: forgotPasswordWatch.isAllFieldsValid,
            isLoading: forgotPasswordWatch.forgotPasswordState.isLoading,
          ).paddingOnly(left: 20.w, right: 20.w, bottom: buttonBottomPadding);
        },
      ),
    );
  }
}
