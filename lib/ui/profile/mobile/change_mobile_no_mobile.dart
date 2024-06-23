import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/profile/change_mobile_no_controller.dart';
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

class ChangeMobileNoMobile extends ConsumerStatefulWidget {
  const ChangeMobileNoMobile( {Key? key,}) : super(key: key);

  @override
  ConsumerState<ChangeMobileNoMobile> createState() =>
      _ChangeMobileNoMobileState();
}

class _ChangeMobileNoMobileState extends ConsumerState<ChangeMobileNoMobile> with BaseConsumerStatefulWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final changeMobileNoWatch = ref.read(changeMobileNoController);
      final profileWatch = ref.read(profileController);
      // final changeMobileNoWatch = ref.watch(changeMobileNoController);
      changeMobileNoWatch.disposeController(isNotify : true);
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
          title: LocalizationStrings.keyChangeMobile.localized,
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
              /// Title Change number
              SlideLeftTransition(
                delay:100,
                child: CommonText(
                  title: LocalizationStrings.keyChangeMobileMsg.localized,
                  textStyle: TextStyles.regular.copyWith(
                    color: AppColors.black,
                  ),
                ).paddingOnly(bottom: 30.h,top: 26.h),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  // final changeMobileNoWatch = ref.watch(changeMobileNoController);
                  final profileWatch = ref.watch(profileController);
                  return Form(
                    key: profileWatch.changeMobileKey,
                    child: Column(
                      children: [
                        /// Mobile Number
                        SlideLeftTransition(
                          delay: 200,
                          child: CommonInputFormField(
                            textEditingController: profileWatch.newMobileController,
                            labelText: LocalizationStrings.keyMobileNo.localized,
                            hintText: LocalizationStrings.keyMobileNo.localized,
                            textInputAction: TextInputAction.done,
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            textInputType: TextInputType.number,
                            onFieldSubmitted: (val){
                              hideKeyboard(context);
                            },
                            validator: (value){
                              return validateMobile(value);
                            },
                            onChanged: (value){
                              profileWatch.validateNewMobile();
                            },
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        /// Confirm Password
                        SlideLeftTransition(
                            delay: 100,
                            child:CommonInputFormField(
                              obscureText: !profileWatch.isShowNewPassword,
                              textEditingController: profileWatch.mobilePasswordController,
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
                                profileWatch.validateNewMobile();
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

                        ),                      ],
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
        // final changeMobileNoWatch = ref.watch(changeMobileNoController);
        final otpVerificationWatch = ref.watch(otpVerificationController);
        final profileWatch = ref.watch(profileController);
        return SlideUpTransition(
          delay: 300,
          child: CommonButtonMobile(
            onTap: () async{
              await sendOTP(context,ref);
            },
            onValidateTap: (){
              profileWatch.changeMobileKey.currentState?.validate();
            },
            isLoading: otpVerificationWatch.resendOtpState.isLoading||profileWatch.checkPasswordState.isLoading,
            buttonTextColor: profileWatch.isNewMobileValid?AppColors.white:AppColors.grey8F8F8F,
            rightIcon: Icon(Icons.arrow_forward,color:profileWatch.isNewMobileValid?AppColors.white:AppColors.grey8F8F8F,),
            buttonText: LocalizationStrings.keySubmit.localized,
            isButtonEnabled: profileWatch.isNewMobileValid,
          ).paddingOnly(left: 20.w,right: 20.w,bottom:buttonBottomPadding),
        );
      },

    );
  }

  Future<void> sendOTP(BuildContext context, WidgetRef ref) async {
    final otpVerificationWatch = ref.read(otpVerificationController);
    // final changeMobileNoWatch = ref.watch(changeMobileNoController);
    final profileWatch = ref.watch(profileController);
    await profileWatch.checkPassword(context,profileWatch.mobilePasswordController.text);
    if (profileWatch.checkPasswordState.success?.status ==
        ApiEndPoints.apiStatus_200 && context.mounted) {
      await otpVerificationWatch.resendOtpApi(context,
          mobileNo: profileWatch.newMobileController.text);
      if (otpVerificationWatch.resendOtpState.success?.status ==
          ApiEndPoints.apiStatus_200) {
        profileWatch.updateTempEmail();
        profileWatch.startCounter();
        ref.read(navigationStackProvider).push(
            NavigationStackItem.otpVerificationProfileModule(
                email: profileWatch.newMobileController.text,
                currentPassword: profileWatch.mobilePasswordController.text,
                fromScreen: FromScreen.changeMobile));
      }
    }
  }
}
