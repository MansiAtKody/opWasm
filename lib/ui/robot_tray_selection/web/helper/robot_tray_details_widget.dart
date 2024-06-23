import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/robot_tray_details_data_widget.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/robot_tray_empty_trays_widget.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';

class RobotTrayDetailsWidget extends StatelessWidget with BaseStatelessWidget {
  const RobotTrayDetailsWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.whiteF7F7FC),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
/*              /// Top Buttons
              const RobotTrayDetailsWidgetTopButtonWidget(),*/

              /// Empty tray & Tray Details Widget
              Expanded(
                child: robotTraySelectionWatch.selectedTrayNumber == null
                    ? const FadeBoxTransition(
                        delay: 250,
                        child: RobotTrayEmptyTraysWidget(
                          emptyStateFor: EmptyStateFor.trayList,
                        ),
                      )
                    : const RobotTrayDetailsDataWidget(),
              ),
            ],
          ).paddingSymmetric(vertical: 30.h),
        ).paddingSymmetric(vertical: 22.h, horizontal: 20.w);
      },
    );
  }
}
