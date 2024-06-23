import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/helper/order_user_details_widget_mobile.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/helper/robot_tray_empty_trays_widget_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';
import 'package:shimmer/shimmer.dart';

class BottomButtonsRobotTraySelectionMobile extends StatelessWidget with BaseStatelessWidget {
  final Color? buttonBackgroundColor;

  const BottomButtonsRobotTraySelectionMobile({super.key, this.buttonBackgroundColor});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        final orderStatusWatch = ref.watch(orderStatusController);
        return robotTraySelectionWatch.addItemToTrayState.isLoading || robotTraySelectionWatch.deleteItemFromTrayState.isLoading || robotTraySelectionWatch.getTrayListState.isLoading?
        _shimmerBottom().paddingAll(20.h)
            :Container(
          color: buttonBackgroundColor ?? AppColors.white,
          child: Row(
            children: [
              /// Add Order Button
              Expanded(
                child: CommonButton(
                  height: 60.h,
                  buttonTextSize: 18.sp,
                  buttonText: LocalizationStrings.keyAddOrder.localized,
                  buttonTextColor: orderStatusWatch.pastSocketOrders.isNotEmpty ? AppColors.white : AppColors.grey8F8F8F,
                  isButtonEnabled: orderStatusWatch.pastSocketOrders.isNotEmpty,
                  onTap: () {
                    /// Tray Dialog
                    showAnimatedTrayDialogMobile(
                      context,
                      title: '${LocalizationStrings.keyTray.localized} ${robotTraySelectionWatch.selectedTrayNumber}',
                      heightPercentage: 64.h,
                      widthPercentage: 70.w,
                      onPopCall: (animationController) {
                        robotTraySelectionWatch.updateAnimationController(animationController);
                      },
                      onCloseTap: () {
                        robotTraySelectionWatch.animationController?.reverse(from: 0.3);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: context.height * 0.64,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: 25.h),

                                  /// Order User Details Widget
                                  if (orderStatusWatch.pastSocketOrders.isNotEmpty)
                                    const Expanded(child: OrderUserDetailsWidgetMobile())
                                  else
                                    const RobotTrayEmptyTraysWidgetMobile(emptyStateFor: EmptyStateFor.orderUserDetailsList, titleColor: AppColors.black, subTitleColor: AppColors.black171717)
                                ],
                              ),
                            ),

                            /// Bottom Buttons
                            Row(
                              children: [
                                /// Add In Button
                                Expanded(
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
                                      return CommonButton(
                                        buttonText: LocalizationStrings.keyAddIn.localized,
                                        height: 60.h,
                                        buttonTextSize: 16.sp,
                                        buttonDisabledColor:AppColors.grey8F8F8F.withOpacity(0.2),
                                        buttonEnabledColor: AppColors.blue009AF1,
                                        buttonTextColor: robotTraySelectionWatch.orderItemUuidList.isNotEmpty? AppColors.white : AppColors.grey8F8F8F,
                                        isButtonEnabled: robotTraySelectionWatch.orderItemUuidList.isNotEmpty,
                                        isLoading: robotTraySelectionWatch.addItemToTrayState.isLoading,
                                        onTap: () async {
                                          await robotTraySelectionWatch.addItemToTrayApi(context);
                                          robotTraySelectionWatch.orderItemUuidList.clear();
                                          if (robotTraySelectionWatch.addItemToTrayState.success?.status == ApiEndPoints.apiStatus_200) {
                                            robotTraySelectionWatch.animationController?.reverse(from: 0.3);
                                            robotTraySelectionWatch.clearOrderItemUuidList();
                                            if(context.mounted){
                                              Navigator.pop(context);
                                              await robotTraySelectionWatch.getTrayListApi(context);
                                            }
                                          }
                                        },
                                      );
                                    }
                                  )
                                ),
                                SizedBox(width: 17.w),

                                /// Close button
                                Expanded(
                                  child: CommonButton(
                                    buttonText: LocalizationStrings.keyClose.localized,
                                    height: 60.h,
                                    buttonTextSize: 16.sp,
                                    buttonEnabledColor: AppColors.whiteF7F7FC,
                                    buttonTextColor: AppColors.grey8F8F8F,
                                    isButtonEnabled: true,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 17.w),

              /// Go Button
              Expanded(
                child: CommonButton(
                  height: 60.h,
                  buttonTextSize: 18.sp,

                  buttonText: LocalizationStrings.keyGo.localized,
                  buttonTextColor: robotTrayStatusValues.map[robotTraySelectionWatch.selectedRobotNew?.state] == RobotTrayStatusEnum.AVAILABLE &&   (robotTraySelectionWatch.trayDataList?.where((element) => element?.data?.isNotEmpty ?? false).isNotEmpty ?? false)?AppColors.white : AppColors.grey8F8F8F,
                  buttonEnabledColor: AppColors.green14B500,
                  // isButtonEnabled: robotTraySelectionWatch.selectedTray?.trayItem != null || robotTraySelectionWatch.selectedRobot?.robotTrayList?[1].trayItem != null || robotTraySelectionWatch.selectedRobot?.robotTrayList?[2].trayItem != null,
                  isButtonEnabled:  robotTrayStatusValues.map[robotTraySelectionWatch.selectedRobotNew?.state] == RobotTrayStatusEnum.AVAILABLE &&   (robotTraySelectionWatch.trayDataList?.where((element) => element?.data?.isNotEmpty ?? false).isNotEmpty ?? false),
                  isLoading: orderStatusWatch.dispatchOrderState.isLoading,
                  onTap: () {
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

                      ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());

                    });

                  },
                ),
              ),
            ],
          ).paddingAll(20.h),
        );
      },
    );
  }
  Widget _shimmerBottom(){
    return Container(
      color: AppColors.whiteF7F7FC,
     child: Row(
        children: [

          Expanded(
            child: Shimmer.fromColors(
    baseColor: AppColors.shimmerBaseColor,
    highlightColor: AppColors.white ,child:Container(
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
          ),),
          SizedBox(width: 17.w),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.white ,child:Container(
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
            ),),
        ],
      )
    );
  }
}
