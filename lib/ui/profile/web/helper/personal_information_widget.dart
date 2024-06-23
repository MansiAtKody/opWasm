import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/profile/web/helper/change_mobile_no_button.dart';
import 'package:kody_operator/ui/profile/web/helper/change_password_dialog.dart';
import 'package:kody_operator/ui/profile/web/helper/change_email_button.dart';
import 'package:kody_operator/ui/profile/web/helper/common_personal_info_row.dart';
import 'package:kody_operator/ui/profile/web/helper/profile_top_widget.dart';
import 'package:kody_operator/ui/profile/web/shimmer/shimmer_personal_information_widget_web.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';

class PersonalInformationWidget extends ConsumerWidget with BaseConsumerWidget {
  const PersonalInformationWidget({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final profileWatch = ref.watch(profileController);
    return profileWatch.profileDetailState.isLoading /*|| profileWatch.profileDetailState.isLoading 0271383081*/
        ? const ShimmerPersonalInformationWidgetWeb()
        : FadeBoxTransition(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightPinkF7F7FC,
                borderRadius: BorderRadius.circular(20.r),
                shape: BoxShape.rectangle,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Profile Top Widget
                    const ProfileTopWidget(),
                    SlideUpTransition(
                      delay: 250,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40.h),

                            ///Title
                            Text(
                              LocalizationStrings.keyUserInformation.localized,
                              style: TextStyles.medium.copyWith(
                                fontSize: 20.sp,
                                color: AppColors.black171717,
                              ),
                            ),
                            SizedBox(height: 40.h),

                            ///Common Personal information Tile - Operator Name
                            CommonPersonalInfoRow(
                              svgAsset: AppAssets.svgOperatorName,
                              label:
                                  LocalizationStrings.keyOperatorName.localized,
                              value: profileWatch.profileDetailState.success?.data?.name ?? '',
                            ),
                            Divider(
                              height: 40.h,
                            ),

                            ///Common Personal information Tile - Email Id
                            CommonPersonalInfoRow(
                              svgAsset: AppAssets.svgEmailId,
                              label: LocalizationStrings.keyEmailId.localized,
                              value: profileWatch.profileDetailState.success?.data?.email ?? '',
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ///Change Email button
                                ChangeEmailButton(),
                              ],
                            ),
                            Divider(
                              height: 40.h,
                            ),

                            ///Common Personal information Tile - Mobile Number
                            CommonPersonalInfoRow(
                              svgAsset: AppAssets.svgMobileNumber,
                              label:
                                  LocalizationStrings.keyMobileNumber.localized,
                              value: profileWatch.profileDetailState.success?.data?.contactNumber ?? '',
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ///Change Mobile button
                                ChangeMobileNolButton(),
                              ],
                            ),
                            SizedBox(
                              height: 50.h,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            /// Change Password Button
                                CommonButton(
                                    height: 60.h,
                                    backgroundColor: AppColors.blue009AF1,
                                    buttonEnabledColor: AppColors.blue009AF1,
                                    isButtonEnabled: true,
                                    onTap: () {
                                      ///Opens Change Password Dialog
                                      showCommonWebDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        dialogBody: const ChangePasswordDialog(),
                                      );
                                    },
                                    buttonText: LocalizationStrings
                                        .keyChangePassword.localized,
                                    width: 190.w),
                                /// delete account Button
                                CommonButton(
                                    height: 60.h,
                                    backgroundColor: AppColors.redFF3D00,
                                    buttonEnabledColor: AppColors.redFF3D00,
                                    isButtonEnabled: true,
                                    onTap: () async {
                                      /// show popup confirmation popup
                                      showConfirmationDialogWeb(
                                        context: context,
                                        title: LocalizationStrings.keyAreYouSure.localized,
                                        message: LocalizationStrings.keyAreYouSureYouWantToDeleteAccount.localized,
                                        titleFontSize: 20.sp,
                                        messageFontSize: 16.sp,
                                        dialogWidth: context.width * 0.35,
                                        didTakeAction: (isPositive) async {
                                          if(isPositive) {
                                            /// delete account
                                            final profileWatch = ref.read(
                                                profileController);
                                            final navigatorWatch = ref.read(
                                                navigationStackProvider);
                                            await profileWatch
                                                .deleteOperatorApi(context,
                                                profileWatch.profileDetailState
                                                    .success?.data?.uuid ?? '');
                                            if (profileWatch.deleteOperatorState
                                                .success?.status ==
                                                ApiEndPoints.apiStatus_200) {
                                              await Session.userBox.clear();
                                              await Session.saveLocalData(
                                                  keyIsOnBoardingShowed, true);
                                              navigatorWatch.pushAndRemoveAll(
                                                  const NavigationStackItem
                                                      .login());
                                            }
                                          }
                                        },
                                      );
                                    },
                                    buttonText: LocalizationStrings
                                        .keyDeleteAccount.localized,
                                    width: 190.w),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 38.w),
                      ).paddingSymmetric(horizontal: 40.w),
                    ),
                  ],
                ).paddingOnly(top: 57.h, bottom: 36.h),
              ),
            ),
          );
  }
}
