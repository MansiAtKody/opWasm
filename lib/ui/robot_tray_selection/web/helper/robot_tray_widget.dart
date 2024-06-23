import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/tray_list_tile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';
import 'package:shimmer/shimmer.dart';

class RobotTrayWidget extends StatelessWidget with BaseStatelessWidget {
  const RobotTrayWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        final orderStatusWatch = ref.watch(orderStatusController);
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.whiteF7F7FC),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /// Robot Bg Image
                    FadeBoxTransition(
                      delay: 250,
                      child: CommonSVG(
                        strIcon: AppAssets.svgTrayBgRobot,
                        svgColor: robotTraySelectionWatch.selectedRobotNew == null ? AppColors.greyCACACA : AppColors.black,
                      ),
                    ),

                    /// Robot Tray
                    Builder(
                      builder: (BuildContext context) {
                        return FadeBoxTransition(
                          delay: 200,
                          onPopCall: (trayBoxAnimationController) {
                            robotTraySelectionWatch.updateTrayBoxAnimationController(trayBoxAnimationController);
                          },
                          child: (robotTraySelectionWatch.robotListState.isLoading || robotTraySelectionWatch.getTrayListState.isLoading ||robotTraySelectionWatch.deleteItemFromTrayState.isLoading) ? _shimmerTrayWidget().paddingOnly(top: context.height*0.06,left: context.width*0.04,right: context.width*0.04)
                              : ListView.separated(
                            shrinkWrap: true,
                            itemCount: robotTraySelectionWatch.selectedRobotNew?.numberOfTray ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return TrayListTile(trayIndex: index);
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(height: 13.h);
                            },
                          ).paddingOnly(top: context.height*0.06),
                        );
                      },
                    )
                  ],
                ),
              ),

              /// Go Button
            (robotTraySelectionWatch.robotListState.isLoading || robotTraySelectionWatch.getTrayListState.isLoading ||robotTraySelectionWatch.deleteItemFromTrayState.isLoading) ? _shimmerGoButtonWidget()
              :CommonButton(
                      height: 60.h,
                      buttonText: LocalizationStrings.keyGo.localized,
                      buttonTextColor: robotTrayStatusValues.map[robotTraySelectionWatch.selectedRobotNew?.state] == RobotTrayStatusEnum.AVAILABLE &&   (robotTraySelectionWatch.trayDataList?.where((element) => element?.data?.isNotEmpty ?? false).isNotEmpty ?? false)?AppColors.white : AppColors.grey8F8F8F,
                      buttonEnabledColor: AppColors.green14B500,
                      isLoading: orderStatusWatch.dispatchOrderState.isLoading,

                      // isButtonEnabled: (robotTraySelectionWatch.getTrayListState.success?.data?.isNotEmpty ?? false),
                      isButtonEnabled:  robotTrayStatusValues.map[robotTraySelectionWatch.selectedRobotNew?.state] == RobotTrayStatusEnum.AVAILABLE &&   (robotTraySelectionWatch.trayDataList?.where((element) => element?.data?.isNotEmpty ?? false).isNotEmpty ?? false),
                      onTap: () async {
                        orderStatusWatch.dispatchOrderState.isLoading = true;
                        orderStatusWatch.notifyListeners();

                        /// dispatch api call
                        orderStatusWatch.dispatchOrderApi(context, robotTraySelectionWatch.selectedRobotNew?.uuid ?? '').then((value){
                          ref.read(orderStatusController).socketManager.sendRobotStatus(RobotTrayStatusEnum.SERVING.name,robotTraySelectionWatch.selectedRobotNew?.entityId.toString() ?? '');
                          orderStatusWatch.dispatchOrderState.isLoading = false;
                          orderStatusWatch.notifyListeners();
                          ref.read(orderStatusController).socketManager.sendData(
                            {
                              'action': 'getRobotTask',
                              'robotUuid': robotTraySelectionWatch.selectedRobotNew?.uuid,
                            },
                            userSendTo: '${robotTraySelectionWatch.selectedRobotNew?.entityId.toString() ?? ''}_ROBOT_robot_queue',
                          );
                          if(orderStatusWatch.dispatchOrderState.success?.status == ApiEndPoints.apiStatus_200){
                            showCommonErrorDialog(context: context, message: orderStatusWatch.dispatchOrderState.success?.message ?? '');
                          }
                          robotTraySelectionWatch.updateSelectedRobotNew(context, selectedRobot: robotTraySelectionWatch.selectedRobotNew);

                          // robotTraySelectionWatch.robotTrayStatusModelList[0].robotTrayList?.forEach((element) => element.trayItem = null);

                          ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());

                        });
                      },
                      borderColor: AppColors.greyCACACA,
                    ).paddingSymmetric(vertical: 30.h)
            ],
          ).paddingOnly(top: 30.h),
        ).paddingSymmetric(vertical: 22.h);
      },
    );
  }
  /// shimmer
  Widget _shimmerTrayWidget(){
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.white,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
              ),
                alignment: AlignmentDirectional.center,
               width:context.height * 0.21,
               height: context.height * 0.137);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 13.h);
        },
      ),
    );
  }

  Widget _shimmerGoButtonWidget(){
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: Container(
          height: 40.h,
          width:  233.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(40.r),
          ),
        ).paddingSymmetric(vertical: 30.h)
    );
  }
}
