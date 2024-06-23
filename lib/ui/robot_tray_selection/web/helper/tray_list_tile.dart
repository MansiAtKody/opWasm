import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class TrayListTile extends StatelessWidget with BaseStatelessWidget {
  final int trayIndex;

  const TrayListTile({super.key, required this.trayIndex});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        // RobotTrayModel? trayModel = robotTraySelectionWatch.selectedRobot?.robotTrayList?[trayIndex];
        return Stack(
          alignment: Alignment.center,
          children: [
            ListBounceAnimation(
              transformSize: 1.5,
              onTap: () async {
                if (robotTraySelectionWatch.selectedRobotNew != null) {
                  robotTraySelectionWatch.updateSelectedTrayNumber(context, trayIndex+1);
                }
              },
              child: Container(
                alignment: AlignmentDirectional.center,
                width: MediaQuery.sizeOf(context).height * 0.21,
                height: MediaQuery.sizeOf(context).height * 0.137,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: robotTraySelectionWatch.getSelectedTrayColor(selectedTrayNumber: trayIndex+1)),
                  color: AppColors.white,
                ),
                child: CommonText(
                  title: (trayIndex + 1).toString(),
                  textStyle: TextStyles.regular.copyWith(fontSize: 35.sp, color: robotTraySelectionWatch.getSelectedTrayColor(selectedTrayNumber: trayIndex+1)),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).height * 0.21,
              height: MediaQuery.sizeOf(context).height * 0.137,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: List.generate(
                  robotTraySelectionWatch.trayDataList?[trayIndex]?.data?.length ?? 0,
                  (index) => SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CacheImage(
                      imageURL: robotTraySelectionWatch.trayDataList?[trayIndex]?.data?[index].ordersItem?.productImage ?? '',
                      contentMode: BoxFit.scaleDown,
                    ),
                  ).paddingAll(5.h),
                ),
              ).paddingOnly(left: 5.w, right: 5.w, top: 7.h, bottom: 7.h),
            )
          ],
        );
      },
    );
  }
}
