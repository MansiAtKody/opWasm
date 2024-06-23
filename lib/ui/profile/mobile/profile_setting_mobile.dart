import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_setting_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/profile/mobile/helper/common_setting_body_container.dart';
import 'package:kody_operator/ui/profile/mobile/helper/shimmer_profile_setting_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';

class ProfileSettingMobile extends ConsumerStatefulWidget {
  const ProfileSettingMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileSettingMobile> createState() =>
      _ProfileSettingMobileState();
}

class _ProfileSettingMobileState extends ConsumerState<ProfileSettingMobile> {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final profileSettingWatch = ref.read(profileSettingController);
      profileSettingWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(seconds: 3), () {
        profileSettingWatch.updateLoadingStatus(false);
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
  Widget build(BuildContext context) {
    final profileSettingWatch = ref.watch(profileSettingController);
    final profileWatch = ref.watch(profileController);
    return profileWatch.deleteOperatorState.isLoading ? DialogProgressBar(isLoading: profileWatch.deleteOperatorState.isLoading) : Scaffold(
      appBar: CommonAppBar(
        isLeadingEnable: true,
        title: LocalizationStrings.keySetting.localized,
      ),
      body: profileSettingWatch.isLoading
          ? const ShimmerProfileSettingMobile()
          : _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return CommonWhiteBackground(child: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final profileSettingWatch = ref.watch(profileSettingController);
        return Column(
          children: [
            /// Notification Preferences Cupertino Switch
            SlideLeftTransition(
              delay: 100,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.lightPink),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                        title: LocalizationStrings.keyNotificationPreferences.localized,
                        textStyle: TextStyles.regular),
                    Transform.scale(
                      scale: 1.2,
                      child: CommonCupertinoSwitch(
                        switchValue: profileSettingWatch.switchValue,
                        height: 27.h,
                        onChanged: (bool? value) {
                          profileSettingWatch.changeSwitch();
                        },
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20.w, vertical: 27.h),
              ),
            ).paddingOnly(bottom: 20.h),

            /// Delete Account
            SlideLeftTransition(
              delay: 200,
              child: CommonSettingBodyContainer(
                onTap: () async {
                  ///Confirmation Dialog
                  showConfirmationDialog(
                      context,
                      LocalizationStrings.keyNo.localized,
                      LocalizationStrings.keyYes.localized,
                          (isPositive) async {
                        if (isPositive) {
                          final profileWatch = ref.read(profileController);
                          final navigatorWatch = ref.read(navigationStackProvider);
                          await profileWatch.deleteOperatorApi(context, profileWatch.profileDetailState.success?.data?.uuid ?? '');
                          if(profileWatch.deleteOperatorState.success?.status == ApiEndPoints.apiStatus_200){
                            await Session.userBox.clear();
                            await Session.saveLocalData(keyIsOnBoardingShowed, true);
                            navigatorWatch.pushAndRemoveAll(const NavigationStackItem.login());
                          }
                        }
                      },
                      title: LocalizationStrings.keyAreYouSure.localized,
                      message: LocalizationStrings.keyAreYouSureYouWantToDeleteAccount.localized,
                  );
                  // ref
                  //     .read(navigationStackProvider)
                  //     .push(const NavigationStackItem.deleteAccount());
                },
                text: LocalizationStrings.keyDeleteAccount.localized,
              ),
            ),
          ],
        ).paddingAll(20.h);
      },
    ));
  }
}
