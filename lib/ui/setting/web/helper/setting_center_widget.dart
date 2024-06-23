import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/setting/web/helper/left_buttons_widget.dart';
import 'package:kody_operator/ui/setting/web/helper/right_buttons_widget.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SettingCenterWidget extends ConsumerWidget with BaseConsumerWidget {
  const SettingCenterWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///Left buttons
        Expanded(
            flex: 3,
            child: const LeftButtonsWidget().paddingOnly(
              left: 48.w,
            )),

        const Spacer(flex: 1),

        ///Emergency stop button
        Expanded(
          flex: 4,
          child: FadeBoxTransition(
            delay: 100,
            child: ListBounceAnimation(
              onTap: () {
                // SocketManager.instance.sendRobotStatus(RobotTrayStatusEnum.SERVING.name);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 310.h,
                  width: 310.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.redF2a5a6,
                        AppColors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonSVG(
                        strIcon: AppAssets.svgPower,
                        height: 86.h,
                        width: 96.w,
                        svgColor: AppColors.black,
                      ).paddingOnly(bottom: 30.h),
                      CommonText(
                        title: LocalizationStrings.keyEmergencyStop.localized,
                        textStyle: TextStyles.regular.copyWith(color: AppColors.black171717, fontSize: 23.sp),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        const Spacer(flex: 1),

        ///Right buttons
        Expanded(
          flex: 3,
          child: const RightButtonsWidget().paddingOnly(
            right: 48.w,
          ),
        ),
      ],
    );
  }
}
