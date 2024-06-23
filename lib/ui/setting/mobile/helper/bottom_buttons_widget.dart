import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/setting/setting_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_right_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class BottomButtonsWidget extends ConsumerWidget with BaseConsumerWidget {
  const BottomButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final settingWatch = ref.watch(settingController);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        /// Speed Button
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SlideRightTransition(
              delay: 400,
              child: CommonText(
                title: LocalizationStrings.keySpeed.localized,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.black171717,
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: SlideLeftTransition(
                delay: 400,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightPink,
                      borderRadius: BorderRadius.circular(36.r)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            settingWatch.updateSpeedLevelStatus(false);
                          },
                          child: CommonSVG(
                              strIcon: AppAssets.svgMinusEclipse,
                              height: 43.h,
                              width: 43.w)),
                        Expanded(
                          flex: 1,
                          child: SizedBox()),
                      CommonText(
                        title:  settingWatch.speedValue==10? settingWatch.speedValue.toString():'0${settingWatch.speedValue.toString()}',
                        textStyle: TextStyles.regular.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.black171717,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Expanded(
                          flex: 1,
                          child:SizedBox()),
                      InkWell(
                          onTap: () {
                            settingWatch.updateSpeedLevelStatus(true);
                          },
                          child: CommonSVG(
                              strIcon: AppAssets.svgPlusEclipse,
                              height: 43.h,
                              width: 43.w)),
                    ],
                  ).paddingOnly(left: 16.w,right: 16.w,top: 15.h,bottom: 15.h),
                ),
              ),
            ),
          ],
        ).paddingOnly(bottom: 16.h),

        /// Light toggle button
        Row(
          children: [
            SlideRightTransition(
              delay: 500,
              child: CommonText(
                title: LocalizationStrings.keyLight.localized,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.black171717,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                ///update light status
                settingWatch.updateLightStatus();
              },
              child: SlideLeftTransition(
                delay: 500,
                child: CommonSVG(
                    strIcon: settingWatch.isLightOnn
                        ? AppAssets.svgIosOnn
                        : AppAssets.svgIosOff,
                    boxFit: BoxFit.scaleDown,
                    height: 43.h,
                    width: 72.w),
              ),
            ),
          ],
        ).paddingOnly(bottom: 16.h),

        /// Obstacle sound toggle button
        Row(
          children: [
            SlideRightTransition(
              delay: 600,
              child: CommonText(
                title: LocalizationStrings.keyObstacleSound.localized,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.black171717,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                ///update light status
                settingWatch.updateObstacleSoundStatus();
              },
              child: SlideLeftTransition(
                delay: 600,
                child: CommonSVG(
                    strIcon: settingWatch.isObstacleSoundOnn
                        ? AppAssets.svgIosOnn
                        : AppAssets.svgIosOff,
                    boxFit: BoxFit.scaleDown,
                    height: 43.h,
                    width: 72.w),
              ),
            ),
          ],
        ).paddingOnly(bottom: 16.h),

        /// Sound button
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SlideRightTransition(
              delay: 700,
              child: CommonText(
                title: LocalizationStrings.keySound.localized,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.black171717,
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: SlideLeftTransition(
                delay: 700,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightPink,
                      borderRadius: BorderRadius.circular(36.r)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            settingWatch.updateSoundLevelStatus(false);
                          },
                          child: CommonSVG(
                              strIcon: AppAssets.svgMinusEclipse,
                              height: 43.h,
                              width: 43.w)),
                      const Expanded(
                          flex: 1,
                          child: SizedBox()),
                      CommonText(
                        title:  settingWatch.soundValue==10? settingWatch.soundValue.toString():'0${settingWatch.soundValue.toString()}',
                        textStyle: TextStyles.regular.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.black171717,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Expanded(
                          flex: 1,
                          child:SizedBox()),
                      InkWell(
                          onTap: () {
                            settingWatch.updateSoundLevelStatus(true);
                          },
                          child: CommonSVG(
                              strIcon: AppAssets.svgPlusEclipse,
                              height: 43.h,
                              width: 43.w)),
                    ],
                  ).paddingOnly(left: 16.w,right: 16.w,top: 15.h,bottom: 15.h),
                ),
              ),
            ),
          ],
        ).paddingOnly(bottom: 16.h),
      ],
    );
  }
}
