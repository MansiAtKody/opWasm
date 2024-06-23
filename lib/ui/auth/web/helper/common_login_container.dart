import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonLoginContainer extends ConsumerWidget with BaseConsumerWidget {
  const CommonLoginContainer({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final loginWatch = ref.watch(loginController);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Text login to Dasher
          CommonText(
            title: LocalizationStrings.keyLoginToDasher.localized,
            textStyle: TextStyles.regular.copyWith(color: AppColors.clr171717, fontSize: 30.sp),
          ).paddingOnly(bottom: 20.h),

          Form(
            key: loginWatch.formKey,
            child: Column(
              children: [
                /// Email Id
                CommonInputFormField(
                  textEditingController: loginWatch.emailController,
                  hintText: LocalizationStrings.keyEmailId.localized,
                  hasLabel: true,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    context.nextField;
                  },
                  hintTextStyle: TextStyles.regular.copyWith(color: AppColors.clr8D8D8D, fontSize: 14.sp),
                  validator: (email) {
                    return validateEmail(email);
                  },
                  onChanged: (email) {
                    loginWatch.checkIfAllFieldsValid();
                  },

                ),
                SizedBox(
                  height: 20.h,
                ),

                /// Password
                CommonInputFormField(
                  obscureText: !loginWatch.isShowPassword,
                  textEditingController: loginWatch.passwordController,
                  hintText: LocalizationStrings.keyPassword.localized,
                  hasLabel: true,
                  textInputAction: TextInputAction.done,
                  hintTextStyle: TextStyles.regular.copyWith(color: AppColors.clr8D8D8D, fontSize: 14.sp),
                  onFieldSubmitted: (value) async {
                    if (loginWatch.isAllFieldsValid) {
                      hideKeyboard(context);
                      await _loginApiCall(context, ref);
                    }
                  },
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
                      strIcon: !loginWatch.isShowPassword ? AppAssets.svgShowPassword : AppAssets.svgHidePassword,
                      svgColor: AppColors.clr8D8D8D,
                    ),
                  ),
                ),
              ],
            ),
          ).paddingOnly(bottom: 20.h),

          /// Forgot password  & Remember Password
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    ref.read(navigationStackProvider).push(const NavigationStackItem.forgotResetPassword(isForgotPassword: true));
                  },
                  child: CommonText(
                    title: LocalizationStrings.keyForgetPassword.localized,
                    textStyle: TextStyles.regular.copyWith(color: AppColors.clr101010, decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ).paddingOnly(bottom: 20.h),
          // // SizedBox(height: 34.h,),
          // /// Terms and conditions
          // Row(
          //   children: [
          //     CommonCheckBox(
          //       value: loginWatch.termsAndConditionsSelected,
          //       onChanged: (termsAndConditionsSelected) {
          //         loginWatch.updateTermsAndConditionsSelected(termsAndConditionsSelected ?? false);
          //       },
          //     ),
          //     Expanded(
          //       flex: 2,
          //       child: RichText(
          //         maxLines: 2,
          //         text: TextSpan(
          //           style: TextStyles.regular.copyWith(color: AppColors.black),
          //           text: '${LocalizationStrings.keyByContinuingYouAgreeWithOur.localized} ',
          //           children: [
          //             TextSpan(
          //                 recognizer: TapGestureRecognizer()
          //                   ..onTap = () async {
          //                     ///Opens Privacy Policy Dialog
          //                     await cmsWatch.getCMS(context, CMSType.privacyPolicy).then((value) {
          //                       showDialog(
          //                         context: context,
          //                         builder: (context) {
          //                           return CommonCMSDialog(
          //                             title: LocalizationStrings.keyPrivacyPolicy.localized,
          //                           );
          //                         },
          //                       );
          //                     });
          //                   },
          //                 text: LocalizationStrings.keyPrivacyPolicy.localized,
          //                 style: TextStyles.regular.copyWith(color: AppColors.black, decoration: TextDecoration.underline)),
          //             TextSpan(text: ' ${LocalizationStrings.keyAnd.localized} '),
          //             TextSpan(
          //                 recognizer: TapGestureRecognizer()
          //                   ..onTap = () async {
          //                     ///Opens Privacy Policy Dialog
          //                     await cmsWatch.getCMS(context, CMSType.termsCondition).then((value) {
          //                       showDialog(
          //                         context: context,
          //                         builder: (context) {
          //                           return CommonCMSDialog(
          //                             title: LocalizationStrings.keyTermsOfUse.localized.capsFirstLetterOfSentence,
          //                           );
          //                         },
          //                       );
          //                     });
          //                   },
          //                 text: LocalizationStrings.keyTermsOfUse.localized,
          //                 style: TextStyles.regular.copyWith(color: AppColors.black, decoration: TextDecoration.underline)),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ).paddingOnly(bottom: 20.h),

          /// Login button
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  onTap: () async {
                    await _loginApiCall(context, ref);
                  },
                  onValidateTap: () {
                    loginWatch.formKey.currentState?.validate();
                  },
                  buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: loginWatch.isAllFieldsValid ? AppColors.white : AppColors.clr616161),
                  buttonText: LocalizationStrings.keyLogin.localized,
                  isButtonEnabled: loginWatch.isAllFieldsValid,
                  isLoading: loginWatch.loginState.isLoading,
                ),
              ),
              const Spacer(flex: 2,)
            ],
          ),
        ],
      ),
    );
  }
}

/// Login Api Call
Future<void> _loginApiCall(BuildContext context, WidgetRef ref) async {
  final loginWatch = ref.watch(loginController);
  if( loginWatch.formKey.currentState?.validate()??false){
    await loginWatch.loginApi(context);
    if (loginWatch.loginState.success?.status == ApiEndPoints.apiStatus_200) {
      /// Saving auth token
      Session.saveLocalData(keyUserAuthToken, loginWatch.loginState.success?.data?.accessToken);
      Session.saveLocalData(keyUserUuid, loginWatch.loginState.success?.data?.userUuid);
      Session.saveLocalData(keyUuid, loginWatch.loginState.success?.data?.uuid);
      Session.saveLocalData(keyUserPassword, loginWatch.passwordController.text);
      Session.saveLocalData(keyIsOperatorUser, loginWatch.loginState.success?.data?.entityType);
      Session.saveLocalData(keyUserEntityId, loginWatch.loginState.success?.data?.entityId);
      Session.saveLocalData(keyUserEntityType, loginWatch.loginState.success?.data?.entityType);
      if(Session.getNewFCMToken().isEmpty){
        String? fcmToken;
        try{
          fcmToken = await FirebaseMessaging.instance.getToken();
          if(fcmToken != null){
            await Session.saveLocalData(keyNewFCMToken, fcmToken);
            print('**************This is fcm token:$fcmToken *********');
            print('NEW Token Saved:${Session.getNewFCMToken()} ');

          }
        }catch(e){}
      }
      ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
      loginWatch.emailController.clear();
      loginWatch.passwordController.clear();
    }
  }

}