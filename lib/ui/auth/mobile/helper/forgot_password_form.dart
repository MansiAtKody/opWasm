import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/forgot_reset_password_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ForgotPasswordForm extends StatelessWidget with BaseStatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final forgotPasswordWatch = ref.watch(forgotResetPasswordController);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            CommonText(
              title: LocalizationStrings.keyForgotPasswordDescription.localized,
              maxLines: 2,
              textStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.black),
            ),
            SizedBox(height: 30.h),
            Form(
              key: forgotPasswordWatch.formKey,
              child: CommonInputFormField(
                textEditingController: forgotPasswordWatch.emailController,
                hintText: LocalizationStrings.keyEmailId.localized,
                textInputType: TextInputType.emailAddress,
                cursorColor: AppColors.black,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) async {
                if (forgotPasswordWatch.isAllFieldsValid) {
                  hideKeyboard(context);
                  await _forgetPasswordApiCall(context, ref);
                }
              },
                validator: (email) {
                  return validateEmail(email);
                },
                onChanged: (email) {
                  forgotPasswordWatch.checkIfAllFieldsValid();
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w);
      },
    );
  }
}

/// Forget Password Api Call
Future<void> _forgetPasswordApiCall(BuildContext context, WidgetRef ref ) async {
  final forgotPasswordWatch = ref.watch(forgotResetPasswordController);
  await forgotPasswordWatch.forgotPasswordApi(context);
  if(forgotPasswordWatch.forgotPasswordState.success?.status == ApiEndPoints.apiStatus_200) {
    if(context.mounted){hideKeyboard(context);}
    ref.read(navigationStackProvider).push( NavigationStackItem.otpVerification(email: forgotPasswordWatch.emailController.text, fromScreen: FromScreen.forgotPassword));
  }
}