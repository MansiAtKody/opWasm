import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/dispatched_order/dispatched_order_controller.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/dispatched_order/mobile/helper/dispatched_order_list_widget_mobile.dart';
import 'package:kody_operator/ui/dispatched_order/mobile/helper/order_top_widget.dart';
import 'package:kody_operator/ui/dispatched_order/mobile/helper/shimmer_robot_tray_selection_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';

class DispatchedOrderMobile extends ConsumerStatefulWidget {
  const DispatchedOrderMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<DispatchedOrderMobile> createState() =>
      _DispatchedOrderModuleMobileState();
}

class _DispatchedOrderModuleMobileState
    extends ConsumerState<DispatchedOrderMobile>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final robotTraySelectionModuleWatch = ref.read(robotTraySelectionController);
      robotTraySelectionModuleWatch.disposeController(isNotify: true);
      final dispatchedOrderWatch = ref.watch(dispatchedOrderController);
      robotTraySelectionModuleWatch.disposeController(isNotify: true);
      await robotTraySelectionModuleWatch.robotListApi(context).then((value) async {
        robotTraySelectionModuleWatch.updateSelectedRobotForDispatchOrder(context, selectedRobot: robotTraySelectionModuleWatch.robotListForOrder.first);
        await dispatchedOrderWatch.getDispatchedOrderListApi(context: context,robotUuid: robotTraySelectionModuleWatch.robotListForOrder.first.uuid ?? '');
      });      // robotTraySelectionModuleWatch.initSelectedRobotTray();
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final robotTraySelectionModuleWatch =
        ref.watch(robotTraySelectionController);
    final dispatchedOrderWatch = ref.watch(dispatchedOrderController);

    return CommonWhiteBackground(
      appBar: CommonAppBar(
        title: LocalizationStrings.keyOrderDispatched.localized,
        isDrawerEnable: true,
        actions: [
          ///Appbar actions
          InkWell(
              onTap: () {
                if (!robotTraySelectionModuleWatch.robotListState.isLoading) {
                  ref
                      .read(navigationStackProvider)
                      .push(const NavigationStackItem.notification());
                }
              },
              child: const CommonSVG(strIcon: AppAssets.svgNotificationMobile)
                  .paddingOnly(right: 12.w))
        ],
      ),
      child:  robotTraySelectionModuleWatch.robotListState.isLoading || dispatchedOrderWatch.isLoading || dispatchedOrderWatch.dispatchedOrderList.isLoading || dispatchedOrderWatch.changeOrderStatus.isLoading
        ? const ShimmerDispatchedOrderMobile()
        : _bodySliver(),
    );
  }

  ///silver scrolling
  Widget _bodySliver() {
    final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
    return Column(
      children: [
        Expanded(
          child: NestedScrollView(
            controller: robotTraySelectionWatch.gridScrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(10.h),
                    child: SizedBox(
                      height: 10.h,
                    ),
                  ),
                  backgroundColor: AppColors.white,
                  floating: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r),
                    ),
                  ),
                  expandedHeight: 263.h,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,

                    /// Robot Tray †øp Widget
                    background: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteF7F7FC,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.r),
                            topRight: Radius.circular(18.r),
                          ),
                        ),
                        child: const OrderTopWidgetMobile().paddingAll(8.h),
                      ),
                    ),
                  ),
                ),

              ];
            },
            body: Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteF7F7FC,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      topRight: Radius.circular(18.r))),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ///Dispatched order list
                  robotTraySelectionWatch.isSwitchLoading ?
                  LoadingAnimationWidget.waveDots(color: AppColors.black, size: 24.h).paddingOnly(left: 35.w) :
                  CommonCupertinoSwitch(
                    switchValue: robotTraySelectionWatch.isRobotAvailable,
                    onChanged: (val) {
                      robotTraySelectionWatch.updateSwitchLoading(true);
                      robotTraySelectionWatch.updateRobotStatus();
                      ref.read(orderStatusController).socketManager.sendRobotStatus(robotTraySelectionWatch.isRobotAvailable ? RobotTrayStatusEnum.AVAILABLE.name : RobotTrayStatusEnum.UNAVAILABLE.name,robotTraySelectionWatch.selectedRobotNew?.entityId.toString() ?? '').then((value) {

                        Future.delayed(const Duration(milliseconds: 400), () {
                          robotTraySelectionWatch.changeRobotSwitchStatus();
                          robotTraySelectionWatch.updateSwitchLoading(false);
                        });
                      });
                    },
                  ).paddingOnly(left: 17.w),
                  const Expanded(child:  DispatchedOrderListWidgetMobile())
                ],
              ),
            ),
          ),
        ),
        //robotTraySelectionWatch.selectedRobotNew != null? const BottomButtonsRobotTraySelectionMobile(): const Offstage(),
      ],
    );
  }
}
