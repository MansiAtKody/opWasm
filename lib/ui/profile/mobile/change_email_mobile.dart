import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/framework/controller/profile/change_email_controller.dart';

class ChangeEmailMobile extends ConsumerStatefulWidget {
  const ChangeEmailMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangeEmailMobile> createState() => _ChangeEmailMobileState();
}

class _ChangeEmailMobileState extends ConsumerState<ChangeEmailMobile> with BaseConsumerStatefulWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final changeEmailWatch = ref.read(changeEmailController);
      final profileWatch = ref.read(profileController);
      changeEmailWatch.disposeController(isNotify : true);
      profileWatch.mobilePasswordController.clear();
      Future.delayed(const Duration(milliseconds: 100), () {
        profileWatch.resetFormKey();
      });
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: (){
        hideKeyboard(context);
      },
      child: Scaffold(
        appBar:CommonAppBar(
          title: LocalizationStrings.keyChangeEmail.localized,
          isLeadingEnable: true,
        ),
        body: _bodyWidget(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return CommonWhiteBackground(
        child: Column(
          children:[ Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideLeftTransition(
                  delay:100,
                  child: CommonText(
                   title: LocalizationStrings.keyChangeEmailMsg.localized,
                    textStyle: TextStyles.regular.copyWith(
                      color: AppColors.black,
                    ),
                  ).paddingOnly(bottom: 30.h,top: 26.h),
                ),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    // final changeEmailWatch = ref.watch(changeEmailController);
                    final profileWatch = ref.watch(profileController);
                    return Form(
                      key: profileWatch.changeEmailKey,
                      child: Column(
                        children: [
                          SlideLeftTransition(
                            delay: 200,
                            child: CommonInputFormField(
                              textEditingController: profileWatch.newEmailController,
                              labelText: LocalizationStrings.keyEmailAddress.localized,
                              hintText: LocalizationStrings.keyEmailAddress.localized,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.emailAddress,
                              onFieldSubmitted: (val){
                                hideKeyboard(context);
                              },
                              validator: (value){
                                return validateEmail(value);
                              },
                              onChanged: (value){
                               profileWatch.checkIfEmailValid();
                              },
                            ),
                          ),

                          SizedBox(height: 20.h,),
                          SlideLeftTransition(
                              delay: 100,
                              child:CommonInputFormField(
                                obscureText: !profileWatch.isShowNewPassword,
                                textEditingController: profileWatch.emailPasswordController,
                                maxLength: 16,
                                hintText: LocalizationStrings.keyCurrentPassword.localized,
                                textInputAction: TextInputAction.next,
                                textInputFormatter: [
                                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                                ],
                                validator: (password) {
                                  return validateCurrentPassword(password);
                                },
                                onChanged: (password) {
                                  profileWatch.checkIfEmailValid();
                                },
                                suffixWidget: IconButton(
                                  onPressed: () {
                                    profileWatch.changePasswordVisibility();
                                  },
                                  icon: CommonSVG(
                                    strIcon: profileWatch.isShowNewPassword ? AppAssets.svgShowPassword : AppAssets.svgHidePassword,
                                  ),
                                ),
                              )

                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w),
          ),

            ///Submit button 
            _bottomWidget(),
          ],
        ),

    );
  }

  /// Bottom widget
  Widget _bottomWidget(){
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          // final changeEmailWatch = ref.watch(changeEmailController);
          final otpVerificationWatch = ref.watch(otpVerificationController);
          final profileWatch = ref.watch(profileController);
          return SlideUpTransition(
            delay: 300,
            child: CommonButtonMobile(
              onTap: () async{
               await sendOTP(context,ref);

              },
              onValidateTap: (){
                profileWatch.changeEmailKey.currentState?.validate();
              },
              isLoading:otpVerificationWatch.resendOtpState.isLoading||profileWatch.checkPasswordState.isLoading,
              buttonTextColor: profileWatch.isEmailFieldsValid?AppColors.white:AppColors.grey8F8F8F,
              rightIcon: Icon(Icons.arrow_forward,color:profileWatch.isEmailFieldsValid?AppColors.white:AppColors.grey8F8F8F,),
              buttonText: LocalizationStrings.keySubmit.localized,
              isButtonEnabled: profileWatch.isEmailFieldsValid,
            ).paddingOnly(left: 20.w,right: 20.w,bottom:buttonBottomPadding),
          );
        },

      );
  }

  Future<void> sendOTP(BuildContext context, WidgetRef ref) async {
    final otpVerificationWatch = ref.watch(otpVerificationController);
    final profileWatch = ref.watch(profileController);
    await profileWatch.checkPassword(context,profileWatch.emailPasswordController.text);
    if (profileWatch.checkPasswordState.success?.status ==
        ApiEndPoints.apiStatus_200 && context.mounted) {
      await otpVerificationWatch.resendOtpApi(context,
          email: profileWatch.newEmailController.text);
      if (otpVerificationWatch.resendOtpState.success?.status ==
          ApiEndPoints.apiStatus_200) {
        profileWatch.updateTempEmail();
        profileWatch.startCounter();
        ref.read(navigationStackProvider).push(
            NavigationStackItem.otpVerificationProfileModule(
                email: profileWatch.newEmailController.text,
                currentPassword: profileWatch.emailPasswordController.text,
                fromScreen: FromScreen.changeEmail));
        if (context.mounted) {
          /*     showCommonDialog(
          context: context,
          height: context.height * 0.65,
          dialogBody: const ChangeEmailVerifyOtpDialog().paddingSymmetric(
            horizontal: 50.w,
            vertical: 30.h,
          ),
        );*/
        }
      }
    }
  }

}
