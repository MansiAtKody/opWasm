import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/cms/cms_controller.dart';
import 'package:kody_operator/framework/controller/profile/language_controller.dart';
import 'package:kody_operator/framework/controller/profile/personal_info_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/profile/web/helper/profile_list_tile.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/hover_animation.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_cms_dialog.dart';
import 'package:kody_operator/ui/widgets/common_top_back_widget.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';

///Profile Screen Body Widget
class ProfileBodyWidget extends ConsumerStatefulWidget {
  const ProfileBodyWidget({super.key});

  @override
  ConsumerState<ProfileBodyWidget> createState() => _ProfileBodyWidgetState();
}

class _ProfileBodyWidgetState extends ConsumerState<ProfileBodyWidget> with BaseConsumerStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    final profileWatch = ref.watch(profileController);
    return profileWatch.deleteOperatorState.isLoading ? DialogProgressBar(isLoading: profileWatch.deleteOperatorState.isLoading) : Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Profile Body Header Widget
            Consumer(builder: (context, ref, child) {
              return CommonBackTopWidget(
                title: LocalizationStrings.keyProfile.localized,
                onTap: () {
                  ref.read(navigationStackProvider).pop();
                },
              ).paddingOnly(bottom: 30.h);
            }),

            ///Profile Body
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Profile body left side widget
                    Expanded(
                      flex: 4,
                      child: Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          final profileWatch = ref.watch(profileController);
                          final cmsWatch = ref.watch(cmsController);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    ///Common Profile List Tile
                                    return InkWell(
                                      onTap: () {
                                        /// Change the screen content based on selected option
                                        profileWatch.updateSelectedProfile(index);
                                        switch (index) {
                                          case 0:
                                            ref.watch(personalInfoController).disposeController(isNotify: true);
                                            Future.delayed(const Duration(seconds: 0), () {
                                              ref.watch(personalInfoController).updateLoadingStatus(false);
                                            });
                                          case 1:
                                            ref.watch(languageController).disposeController(isNotify: true);
                                            Future.delayed(const Duration(seconds: 0), () {
                                              ref.watch(languageController).updateLoadingStatus(false);
                                            });
                                          case 2:
                                            // ref.watch(faqController).disposeController(isNotify: true);
                                            // Future.delayed(const Duration(seconds: 0), () {
                                            //   ref.watch(faqController).updateLoadingStatus(false);
                                            // });
                                        }
                                      },
                                      child: HoverAnimation(
                                        transformSize: profileWatch.selectedProfileItem == index ? 1 : 1.05,
                                        child: Transform.scale(
                                          scale: profileWatch.selectedProfileItem != index ? 1 : 1.05,
                                          child: ProfileListTile(
                                            svgAsset: profileWatch.profileList[index].svgAsset,
                                            tileTitle: profileWatch.profileList[index].tileTitle,
                                            isSelected: profileWatch.selectedProfileItem == index,
                                          ).paddingOnly(left: 30.w),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 20.h);
                                  },
                                  shrinkWrap: true,
                                  itemCount: profileWatch.profileList.length,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      ///Opens Privacy Policy Dialog
                                      await cmsWatch.getCMS(context, CMSType.privacyPolicy).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CommonCMSDialog(
                                              title: LocalizationStrings.keyPrivacyPolicy.localized,
                                              lastUpdated: DateTime.now(),
                                            );
                                          },
                                        );
                                      });
                                    },
                                    child: Text(
                                      LocalizationStrings.keyPrivacyPolicy.localized,
                                      style: TextStyles.regular.copyWith(
                                        fontSize: 16.sp,
                                        color: AppColors.blue009AF1,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.blue009AF1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      ///Opens terms and condition dialog on tap
                                      await cmsWatch.getCMS(context, CMSType.termsCondition).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CommonCMSDialog(
                                              title: LocalizationStrings.keyTermsAndCondition.localized,
                                              lastUpdated: DateTime.now(),
                                            );
                                          },
                                        );
                                      });
                                    },
                                    child: Text(
                                      LocalizationStrings.keyTermsAndCondition.localized,
                                      style: TextStyles.regular.copyWith(
                                        fontSize: 16.sp,
                                        color: AppColors.blue009AF1,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.blue009AF1,
                                      ),
                                    ),
                                  ),
                                ],
                              ).paddingOnly(left: 30.w),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 35.w),

                    ///Profile Body Right Side Widget
                    Expanded(
                      flex: 7,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final profileWatch = ref.watch(profileController);
                          return profileWatch.profileList[profileWatch.selectedProfileItem].screen ?? const Offstage();
                        },
                      ),
                    ),
                    SizedBox(width: 35.w),
                  ],
                ).paddingSymmetric(vertical: 45.h),
              ),
            ),
          ],
        ).paddingOnly(top: 38.h, left: 38.w, right: 38.w, bottom: 38.h),
        DialogProgressBar(isLoading: ref.watch(cmsController).cmsState.isLoading),
      ],
    );
  }
}
