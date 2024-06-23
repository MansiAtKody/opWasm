import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/setting/setting_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class RightButtonsWidget extends ConsumerWidget with BaseConsumerWidget {
  const RightButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    final settingWatch = ref.watch(settingController);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///Speed
        SlideUpTransition(
          delay: 50,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                title: LocalizationStrings.keySpeed.localized,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.black171717,
                ),
              ),
              const Spacer(),
              Container(
                width: context.width * 0.099,
                decoration: BoxDecoration(color: AppColors.lightPink, borderRadius: BorderRadius.circular(37.r)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () {
                          settingWatch.updateSpeedLevelStatus(false);
                        },
                        child: CommonSVG(strIcon: AppAssets.svgMinusEclipse, height: 43.h, width: 72.w),
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: CommonText(
                        title: settingWatch.speedValue == 10 ? settingWatch.speedValue.toString() : '0${settingWatch.speedValue.toString()}',
                        textStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.black171717),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: InkWell(
                          onTap: () {
                            settingWatch.updateSpeedLevelStatus(true);
                          },
                          child: CommonSVG(strIcon: AppAssets.svgPlusEclipse, height: 43.h, width: 72.w)),
                    ),
                  ],
                ).paddingOnly(left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
              ),
            ],
          ).paddingOnly(bottom: 40.h),
        ),

        ///Light
        SlideUpTransition(
          delay: 100,
          child: Row(
            children: [
              CommonText(
                title: LocalizationStrings.keyLight.localized,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.black171717,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  ///update light status
                  settingWatch.updateLightStatus();
                },
                child: CommonSVG(strIcon: settingWatch.isLightOnn ? AppAssets.svgIosOnn : AppAssets.svgIosOff, boxFit: BoxFit.scaleDown, height: 43.h, width: 72.w),
              ),
            ],
          ).paddingOnly(bottom: 40.h),
        ),

        ///Obstacle sound
        SlideUpTransition(
          delay: 150,
          child: Row(
            children: [
              Expanded(
                child: CommonText(
                  title: LocalizationStrings.keyObstacleSound.localized,
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.black171717,
                  ),
                  maxLines: 2,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  ///update light status
                  settingWatch.updateObstacleSoundStatus();
                },
                child: CommonSVG(strIcon: settingWatch.isObstacleSoundOnn ? AppAssets.svgIosOnn : AppAssets.svgIosOff, boxFit: BoxFit.scaleDown, height: 43.h, width: 72.w),
              ),
            ],
          ).paddingOnly(bottom: 40.h),
        ),

        ///Sound
        SlideUpTransition(
          delay: 200,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                title: LocalizationStrings.keySound.localized,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.black171717,
                ),
              ),
              const Spacer(),
              Container(
                width: context.width * 0.099,
                decoration: BoxDecoration(color: AppColors.lightPink, borderRadius: BorderRadius.circular(37.r)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 4,
                      child: InkWell(
                          onTap: () {
                            settingWatch.updateSoundLevelStatus(false);
                          },
                          child: CommonSVG(strIcon: AppAssets.svgMinusEclipse, height: 43.h, width: 72.w)),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 3,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final settingWatch = ref.watch(settingController);
                          return CommonText(
                            title: settingWatch.soundValue == 10 ? settingWatch.soundValue.toString() : '0${settingWatch.soundValue.toString()}',
                            textStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.black171717),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: InkWell(
                          onTap: () {
                            settingWatch.updateSoundLevelStatus(true);
                          },
                          child: CommonSVG(strIcon: AppAssets.svgPlusEclipse, height: 43.h, width: 72.w)),
                    ),
                  ],
                ).paddingOnly(left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
