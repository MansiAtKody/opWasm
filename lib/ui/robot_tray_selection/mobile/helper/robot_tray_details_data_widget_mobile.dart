import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/helper/order_details_widget_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';

class RobotTrayDetailsDataWidgetMobile extends StatelessWidget with BaseStatelessWidget {
  const RobotTrayDetailsDataWidgetMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);

        /// Add Items Into Tray Button
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: context.height,
                decoration: BoxDecoration(
                  borderRadius: robotTraySelectionWatch.selectedTrayNumber != 1 && robotTraySelectionWatch.selectedTrayNumber != robotTraySelectionWatch.selectedRobotNew?.numberOfTray
                      ? BorderRadius.circular(20.r)
                      : robotTraySelectionWatch.selectedTrayNumber == 1
                          ? BorderRadius.only(bottomLeft: Radius.circular(20.r), bottomRight: Radius.circular(20.r), topRight: Radius.circular(20.r))
                          : robotTraySelectionWatch.selectedTrayNumber == robotTraySelectionWatch.selectedRobotNew?.numberOfTray
                              ? BorderRadius.only(bottomLeft: Radius.circular(20.r), bottomRight: Radius.circular(20.r), topLeft: Radius.circular(20.r))
                              : BorderRadius.zero,
                  color: AppColors.white,
                ),
                child: const OrderDetailsWidgetMobile().paddingOnly(left: 20.w, top: 10.h, right: 20.w, bottom: context.height * 0.15),
              ).paddingSymmetric(horizontal: 8.w)
          ],
        );
      },
    );
  }
}
