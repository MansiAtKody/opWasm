import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/login_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class LoginForm extends ConsumerWidget with BaseConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final loginWatch = ref.watch(loginController);
    return Column(
      children: [
        Form(
          key: loginWatch.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30.h),
              CommonInputFormField(
                textEditingController: loginWatch.emailController,
                hintText: LocalizationStrings.keyEmailId.localized,
                focusNode: loginWatch.emailFocus,
                cursorColor: AppColors.black,
                textInputType: TextInputType.emailAddress,
                validator: (email) {
                  return validateEmail(email);
                },
                textInputFormatter: [LengthLimitingTextInputFormatter(maxEmailLength)],
                onFieldSubmitted: (email) {
                  context.nextField;
                },
                onChanged: (email) {
                  loginWatch.checkIfAllFieldsValid();
                },
              ),
              SizedBox(height: 30.h),
              CommonInputFormField(
                focusNode: loginWatch.passwordFocus,
                obscureText: !loginWatch.isShowPassword,
                textEditingController: loginWatch.passwordController,
                cursorColor: AppColors.black,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) async {
                  if (loginWatch.isAllFieldsValid) {
                    hideKeyboard(context);await loginWatch.loginApi(context);
                    if (loginWatch.loginState.success?.status == ApiEndPoints.apiStatus_200) {
                      /// Saving auth token
                      Session.saveLocalData(keyUserAuthToken, loginWatch.loginState.success?.data?.accessToken);
                      Session.saveLocalData(keyUserUuid, loginWatch.loginState.success?.data?.userUuid);
                      Session.saveLocalData(keyUserPassword, loginWatch.passwordController.text);
                      Session.saveLocalData(keyUuid, loginWatch.loginState.success?.data?.uuid);
                      Session.saveLocalData(keyIsOperatorUser, loginWatch.loginState.success?.data?.entityType);
                      loginWatch.clearLoginForm();
                      Session.saveLocalData(keyUserEntityId, loginWatch.loginState.success?.data?.entityId);
                      Session.saveLocalData(keyUserEntityType, loginWatch.loginState.success?.data?.entityType);
                      if(Session.getNewFCMToken().isEmpty){
                        String? fcmToken;
                        try{
                          fcmToken = await FirebaseMessaging.instance.getToken();
                          if(fcmToken != null){
                            await Session.saveLocalData(keyNewFCMToken, fcmToken);
                          }
                        }catch(e){}
                      }
                      ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
                    }
                  }
                },
                hintText: LocalizationStrings.keyPassword.localized,
                textInputFormatter: [LengthLimitingTextInputFormatter(maxPasswordLength)],
                validator: (password) {
                  return validatePassword(password);
                },
                onChanged: (password) {
                  loginWatch.checkIfAllFieldsValid();
                },
                suffixWidget: IconButton(
                  onPressed: () {
                    loginWatch.changePasswordVisibility();
                  },
                  icon: CommonSVG(
                    strIcon: loginWatch.isShowPassword ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
                    svgColor: AppColors.clr8D8D8D,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        loginWatch.clearLoginForm();
                        ref.read(navigationStackProvider).push(const NavigationStackItem.forgotResetPassword(isForgotPassword: true));
                      },
                      child: CommonText(
                        title: LocalizationStrings.keyForgetPassword.localized,
                        textStyle: TextStyles.regular.copyWith(color: AppColors.black, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
        ),
        // SizedBox(height: 20.h),
        // Divider(color: AppColors.textFieldBorderColor).paddingSymmetric(horizontal: 20.w),
        // SizedBox(height: 5.h),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     CommonCheckBox(
        //       value: loginWatch.termsAndConditionsSelected,
        //       onChanged: (termsAndConditionsSelected) {
        //         loginWatch.updateTermsAndConditionsSelected(termsAndConditionsSelected ?? false);
        //       },
        //     ),
        //     Expanded(
        //       flex: 3,
        //       child: RichText(
        //         text: TextSpan(
        //           style: TextStyles.regular.copyWith(color: AppColors.black),
        //           text: '${LocalizationStrings.keyByContinuingYouAgreeWithOur.localized} ',
        //           children: [
        //             TextSpan(
        //                 recognizer: TapGestureRecognizer()
        //                   ..onTap = () {
        //                     loginWatch.clearLoginForm();
        //                     ref.read(navigationStackProvider).push(const NavigationStackItem.cms(cmsType: CMSType.privacyPolicy));
        //                   },
        //                 text: LocalizationStrings.keyPrivacyPolicy.localized.toLowerCase(),
        //                 style: TextStyles.regular.copyWith(color: AppColors.black, decoration: TextDecoration.underline)),
        //             TextSpan(text: ' ${LocalizationStrings.keyAnd.localized} '),
        //             TextSpan(
        //                 recognizer: TapGestureRecognizer()
        //                   ..onTap = () {
        //                     loginWatch.clearLoginForm();
        //                     ref.read(navigationStackProvider).push(const NavigationStackItem.cms(cmsType: CMSType.termsCondition));
        //                   },
        //                 text: LocalizationStrings.keyTermsOfUse.localized,
        //                 style: TextStyles.regular.copyWith(color: AppColors.black, decoration: TextDecoration.underline)),
        //           ],
        //         ),
        //       ).paddingOnly(top: 10.h),
        //     ),
        //     const Expanded(child: SizedBox()),
        //   ],
        // ).paddingOnly(left: 10.w, right: 20.w, bottom: buttonBottomPadding)
      ],
    );
  }
}
