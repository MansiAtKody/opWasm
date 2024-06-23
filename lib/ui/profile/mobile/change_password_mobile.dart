import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/profile/mobile/helper/change_password_form.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/framework/controller/profile/change_password_controller.dart';

class ChangePasswordMobile extends ConsumerStatefulWidget {
  const ChangePasswordMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangePasswordMobile> createState() =>
      _ChangePasswordMobileState();
}

class _ChangePasswordMobileState extends ConsumerState<ChangePasswordMobile>  with BaseConsumerStatefulWidget{

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final changePasswordWatch = ref.read(changePasswordController);
      changePasswordWatch.disposeController(isNotify : true);
      Future.delayed(const Duration(milliseconds: 100), () {
        changePasswordWatch.formKey.currentState?.reset();
      });
    });
  }


  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: (){
        hideKeyboard(context);
      },

      child: Scaffold(
        appBar: CommonAppBar(
          title: LocalizationStrings.keyChangePassword.localized,
          isLeadingEnable: true,
        ),
        body: _bodyWidget()
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return CommonWhiteBackground(
        height: context.height,
        child: Column(
          children: [

            /// Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(children:
                [
                  const ChangePasswordForm().paddingOnly(top: 27.h,left: 14.w,right: 14.w),
                ],
                )
              ),
            ),

            /// Save changes button
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final changePasswordWatch = ref.watch(changePasswordController);
                final profileWatch = ref.watch(profileController);
                return SlideUpTransition(
                  delay: 300,
                  child: CommonButtonMobile(
                    onTap: () async {

                      await profileWatch.changePassword(context: context,oldPass: changePasswordWatch.currentPasswordController.text,confirmPass: changePasswordWatch.confirmPasswordController.text);

                      ///Change Password Success Animation
                      if (profileWatch.changePasswordState.success?.status == ApiEndPoints.apiStatus_200) {
                        Session.saveLocalData(keyUserAuthToken, profileWatch.changePasswordState.success?.data?.accessToken);
                        Session.saveLocalData(keyUserPassword, changePasswordWatch.confirmPasswordController.text);
                        ///Change Password Success Animation
                        if(mounted)
                          {
                            showCommonSuccessDialogMobile(
                                context: context,
                                anim: AppAssets.animChangePasswordSuccess,
                                titleText: LocalizationStrings.keyPasswordChangeSuccessMsg.localized,
                                onButtonTap: (){
                                  Navigator.of(context).pop();
                                  ref.read(navigationStackProvider).pop();
                                  ref.read(navigationStackProvider).pop();
                                }
                            );
                          }

                      }
                      },
                    onValidateTap: (){
                      changePasswordWatch.formKey.currentState?.validate();
                    },
                    buttonTextColor: changePasswordWatch.isAllFieldsValid?AppColors.white:AppColors.grey8F8F8F,
                    rightIcon: Icon(Icons.arrow_forward,color:changePasswordWatch.isAllFieldsValid?AppColors.white:AppColors.grey8F8F8F,),
                    buttonText: LocalizationStrings.keySaveChanges.localized,
                    isButtonEnabled: changePasswordWatch.isAllFieldsValid,
                  ).paddingOnly(left: 10.w,right: 10.w,bottom:buttonBottomPadding),
                );
              },

            ),
          ],
        )
    );
  }
}
