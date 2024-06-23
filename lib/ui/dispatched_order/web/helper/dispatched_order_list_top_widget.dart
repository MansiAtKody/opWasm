import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_top_back_widget.dart';

class DispatchedOrderListTopWidget extends StatelessWidget with BaseStatelessWidget {
  const DispatchedOrderListTopWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        return Row(
          children: [
            CommonBackTopWidget(
              title: LocalizationStrings.keyOrderDispatched.localized,
              showBackButton: false,
              // showBackButton: false,
            ).paddingOnly(left: 40.w, right: 15.w),
            // CommonSVG(
            //     strIcon: AppAssets.svgOrderHome,
            //     height: 40.h,
            //     width: 40.h,
            //   svgColor: AppColors.black,
            //   ),

            const Spacer(flex: 2,),
            /// Robot Status Icons & Text
            ...List.generate(
              robotTraySelectionWatch.robotTrayStatusList.length,
                  (index) => Expanded(
                child: FadeBoxTransition(
                  delay: (index * 100) + 200,
                  child: Row(
                    children: [
                      ///Status Icon
                      Container(
                        height: 16.h,
                        width: 16.h,
                        decoration: BoxDecoration(
                            color: robotTraySelectionWatch.robotTrayStatusList[index] == RobotTrayStatusEnum.AVAILABLE
                                ? AppColors.green14B500
                                : robotTraySelectionWatch.robotTrayStatusList[index] == RobotTrayStatusEnum.UNAVAILABLE
                                ? AppColors.redEE0000
                                : AppColors.clr009AF1,
                            borderRadius: BorderRadius.circular(100.r)),
                      ).paddingOnly(left: 5.w, right: 6.w),

                      /// Status Text
                      Expanded(
                        child: CommonText(
                          title: robotTrayStatusValues.reverse[robotTraySelectionWatch.robotTrayStatusList[index]].toString(),
                          textStyle: TextStyles.medium.copyWith(
                            fontSize: 12.sp,
                            color: robotTraySelectionWatch.robotTrayStatusList[index] == RobotTrayStatusEnum.AVAILABLE
                                ? AppColors.green14B500
                                : robotTraySelectionWatch.robotTrayStatusList[index] == RobotTrayStatusEnum.UNAVAILABLE
                                ? AppColors.redEE0000
                                : AppColors.clr009AF1,
                          ),
                        ).paddingOnly(right: 10.w),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ).paddingOnly(top: 34.h, bottom: 42.h);
      },
    );
  }
}
