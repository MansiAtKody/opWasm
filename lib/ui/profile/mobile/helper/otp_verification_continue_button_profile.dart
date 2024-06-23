import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_right_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

class OtpVerificationProfileBottomButtons extends StatelessWidget with BaseStatelessWidget {
  final FromScreen fromScreen;
  final String email;
  final String password;
  const OtpVerificationProfileBottomButtons({super.key, required this.fromScreen, required this.email, required this.password,});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final otpVerificationWatch = ref.watch(otpVerificationController);
        final profileWatch = ref.watch(profileController);
        return SlideRightTransition(
          delay: 300,
          child: Column(
            children: [
              CommonButtonMobile(
                onTap: () async {
                  if (otpVerificationWatch.counterSeconds == 0) {
                   if(fromScreen == FromScreen.changeEmail)
                  {
                    await otpVerificationWatch.resendOtpApi(context,email:email);
                    if(context.mounted)
                    {
                      showCommonErrorDialog(context: context, message: LocalizationStrings.keyResendOTPMessage.localized);
                    }
                    if(otpVerificationWatch.resendOtpState.success?.status==ApiEndPoints.apiStatus_200);
                    {
                      profileWatch.profileDetailState.success?.data?.email = email;

                      otpVerificationWatch.disposeController(isNotify: true);
                      otpVerificationWatch.startCounter();
                      profileWatch.emailOtpController.clear();

                    }
                  }
                  else if(fromScreen == FromScreen.changeMobile)
                  {
                    await otpVerificationWatch.resendOtpApi(context,
                        mobileNo:email);
                    if(otpVerificationWatch.resendOtpState.success?.status==ApiEndPoints.apiStatus_200);
                    {
                      if(context.mounted)
                      {
                        showCommonErrorDialog(context: context, message: LocalizationStrings.keyResendOTPMessage.localized);

                      }
                      if(otpVerificationWatch.counterSeconds==0)
                      {
                        otpVerificationWatch.disposeController(isNotify: true);
                        otpVerificationWatch.startCounter();
                        profileWatch.mobileOtpController.clear();
                      }
                    }
                  }
                   otpVerificationWatch.startCounter();
                   otpVerificationWatch.otpController.clear();
                   otpVerificationWatch.focusNode.previousFocus();
                   otpVerificationWatch.disposeController(isNotify: true);
                  }
                },
                buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: (otpVerificationWatch.counterSeconds == 0) ? AppColors.primary2 : AppColors.primary2),
                buttonText:
                '${(otpVerificationWatch.counterSeconds == 0) ? LocalizationStrings.keyResendCode.localized : LocalizationStrings.keyResendCodeIn.localized} ${(otpVerificationWatch.counterSeconds == 0) ? '' : otpVerificationWatch.getCounterSeconds()}',
                buttonEnabledColor: AppColors.white,
                buttonDisabledColor: AppColors.white,
                borderColor: AppColors.grey8F8F8F,
                isButtonEnabled: (otpVerificationWatch.counterSeconds == 0),
              ),
              SizedBox(height: 20.h),
              SlideLeftTransition(
                delay: 300,
                child: CommonButtonMobile(
                  onTap: () async {
                    hideKeyboard(context);
                    if(fromScreen==FromScreen.changeEmail)
                    {
                      await profileWatch.updateEmailMobileApi(context,true,
                          email: email,
                          otp:otpVerificationWatch.otpController.text,password: password);
                      if (profileWatch.updateEmailState.success?.status == ApiEndPoints.apiStatus_200) {
                        profileWatch.updateEmail();
                        profileWatch.profileDetailState.success?.data?.email =email ;
                        Session.saveLocalData(keyUserAuthToken, profileWatch.updateEmailState.success?.data?.accessToken??'');
                        if(context.mounted)
                        {
                          showCommonSuccessDialogMobile(
                              context: context,
                              anim: AppAssets.animEmailChangeSuccess,
                              titleText:LocalizationStrings.keyEmailChangeSuccessMsg.localized,
                              onButtonTap: ()async{
                                Navigator.of(context).pop();
                                ref.read(navigationStackProvider).popUntil(const NavigationStackItem.personalInformation());
                              }
                          );
                        }

                        // ref.read(navigationStackProvider).popUntil(const NavigationStackItem.personalInformation());
                      }
                    }
                    else if(fromScreen==FromScreen.changeMobile)
                    {
                      await profileWatch.updateEmailMobileApi(context,false,otp:otpVerificationWatch.otpController.text,mobileNo: email, password: password);
                      if (profileWatch.updateEmailState.success?.status == ApiEndPoints.apiStatus_200) {
                        profileWatch.updateEmail();
                        profileWatch.profileDetailState.success?.data?.contactNumber =email ;
                        Session.saveLocalData(keyUserAuthToken, profileWatch.updateEmailState.success?.data?.accessToken??'');
                        if(context.mounted)
                          {
                            showCommonSuccessDialogMobile(
                                context: context,
                                anim: AppAssets.animEmailChangeSuccess,
                                titleText:LocalizationStrings.keyChangeMobileSuccessfully.localized,
                                onButtonTap: ()async{
                                  Navigator.of(context).pop();
                                  ref.read(navigationStackProvider).popUntil(const NavigationStackItem.personalInformation());
                                }
                            );
                          }
                        // ref.read(navigationStackProvider).popUntil(const NavigationStackItem.personalInformation());
                      }
                    }
                    },
                  isLoading: profileWatch.updateEmailState.isLoading,
                  buttonTextColor: otpVerificationWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor,
                  buttonText: LocalizationStrings.keyVerifyNow.localized,
                  rightIcon: Icon(Icons.arrow_forward, color: otpVerificationWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
                  isButtonEnabled: otpVerificationWatch.isAllFieldsValid,
                  //isLoading: otpVerificationWatch.verifyOtpState.isLoading,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

/*  /// Update Email API
  Future<void> updateEmail(BuildContext context, WidgetRef ref) async {
    final profileWatch = ref.watch(profileController);
    final otpVerificationWatch = ref.watch(otpVerificationController);
    await profileWatch.updateEmailMobileApi(context,true,otp:otpVerificationWatch.otpController.text);
    if (profileWatch.updateEmailState.success?.status == ApiEndPoints.apiStatus_200) {
      profileWatch.updateEmail();
      Session.saveLocalData(keyUserAuthToken, profileWatch.updateEmailState.success?.data?.accessToken??'');
      ref.read(navigationStackProvider).popUntil(const NavigationStackItem.personalInformation());
    }
  }*/

}
