import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/login_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';

class LoginBottomWidget extends StatelessWidget with BaseStatelessWidget {
  const LoginBottomWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final loginWatch = ref.watch(loginController);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SlideLeftTransition(
              delay: 300,
              child: CommonButtonMobile(
                absorbing: loginWatch.loginState.isLoading,
                withBackground: false,
                onValidateTap: () {
                  loginWatch.formKey.currentState?.validate();
                },
                onTap: () async {
                  await loginWatch.loginApi(context);
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
                },
                buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: loginWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
                buttonText: LocalizationStrings.keyLogin.localized,
                rightIcon: Icon(Icons.arrow_forward, color: loginWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
                isButtonEnabled: loginWatch.isAllFieldsValid,
                isLoading: loginWatch.loginState.isLoading,
              ),
            ),
          ],
        );
      },
    ).paddingOnly(left: 20.w, right: 20.w, bottom: buttonBottomPadding);
  }
}

// loginWatch.loginApi(context).then((value){
//   // if (loginWatch.loginState.success?.status == ApiEndPoints.apiStatus_200) {
//   //   Session.saveLocalData(keyUserEmail, loginWatch.emailController.text);
//   //   ///Saving temproray auth token
//   //   Session.saveLocalData(keyUserAuthToken,'123456');
//   //
//   //   Session.saveLocalData(keyLoginResponse, loginResponseModelToJson(loginWatch.loginState.success!));
//   //   if (loginWatch.emailController.text.contains('maharaj')) {
//   //     ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.maharajDashboard());
//   //   } else {
//   //     ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.employeeDashboard());
//   //   }
//   // }else{
//   //   showErrorSnackBar(context, loginWatch.loginState.success?.message?.capsFirstLetterOfSentence ?? '');
//   // }
//
//   Session.saveLocalData(keyUserEmail, loginWatch.emailController.text);
//   ///Saving temproray auth token
//   Session.saveLocalData(keyUserAuthToken,'123456');
//
//   Session.saveLocalData(keyLoginResponse, loginResponseModelToJson(loginWatch.loginState.success!));
//
//
// });
