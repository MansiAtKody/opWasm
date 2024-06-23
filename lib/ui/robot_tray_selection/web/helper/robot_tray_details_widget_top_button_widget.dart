import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class RobotTrayDetailsWidgetTopButtonWidget extends StatelessWidget with BaseStatelessWidget{
  const RobotTrayDetailsWidgetTopButtonWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        return SizedBox(
          height: 50.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: robotTraySelectionWatch.selectedRobotNew?.numberOfTray ?? 0,
            itemBuilder: (BuildContext context, int index) {
              // RobotTrayModel? trayModel = robotTraySelectionWatch.selectedRobot?.robotTrayList?[index];
              return FadeBoxTransition(
                delay: 250,
                child: ListBounceAnimation(
                  transformSize: 1.4,
                  onTap: () {
                    // RobotTrayModel? trayModel = robotTraySelectionWatch.selectedRobot?.robotTrayList?[index];
                    if (robotTraySelectionWatch.selectedRobotNew != null) {
                      robotTraySelectionWatch.updateSelectedTrayNumber(context, index+1);
                    }
                  },
                  child: Container(
                    width: context.width * 0.15,
                    height: 49.h,
                    decoration: BoxDecoration(
                      color: robotTraySelectionWatch.selectedTrayNumber == (index+1) ? AppColors.blue009AF1 : AppColors.white,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: CommonText(
                        title: 'Tray ${index + 1}',
                        textStyle: TextStyles.medium.copyWith(
                          color: robotTraySelectionWatch.selectedTrayNumber == (index+1) ? AppColors.white : AppColors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 30.w,
              );
            },
          ),
        ).paddingSymmetric(horizontal: 30.w);
      },
    );
  }
}
