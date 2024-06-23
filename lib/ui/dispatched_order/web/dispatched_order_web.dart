import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/dispatched_order/dispatched_order_controller.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/dispatched_order/web/helper/dispatch_order_left_widget.dart';
import 'package:kody_operator/ui/dispatched_order/web/helper/dispatch_order_list.dart';
import 'package:kody_operator/ui/dispatched_order/web/helper/dispatched_order_list_top_widget.dart';
import 'package:kody_operator/ui/dispatched_order/web/helper/shimmer_dispatched_order_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DispatchedOrderWeb extends ConsumerStatefulWidget {
  const DispatchedOrderWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<DispatchedOrderWeb> createState() => _DispatchedOrderModuleWebState();
}

class _DispatchedOrderModuleWebState extends ConsumerState<DispatchedOrderWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
      final dispatchedOrderWatch = ref.watch(dispatchedOrderController);
      robotTraySelectionWatch.disposeController(isNotify: true);
      dispatchedOrderWatch.disposeController(isNotify: true);
      await robotTraySelectionWatch.robotListApi(context).then((value) async {
        robotTraySelectionWatch.updateSelectedRobotForDispatchOrder(context, selectedRobot: robotTraySelectionWatch.robotListForOrder.first);
        await dispatchedOrderWatch.getDispatchedOrderListApi(context: context,robotUuid: robotTraySelectionWatch.robotListForOrder.first.uuid ?? '');
      });
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final dispatchedOrderWatch = ref.watch(dispatchedOrderController);
    final robotTraySelectionWatch = ref.watch(robotTraySelectionController);

    return Column(
      children: [
        SizedBox(height: 15.h),
        Expanded(
          child: Column(
            children: [
              /// Body Widget
              Expanded(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
                  child:  Column(
                    children: [
                      /// Top Title And Status Widget
                      const DispatchedOrderListTopWidget(),

                      Expanded(
                        child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Robot Tray Left Widget
                              const Expanded(
                                child: DispatchOrderLeftWidget(),
                              ),
                              Expanded(flex: 6, child:   dispatchedOrderWatch.isLoading || dispatchedOrderWatch.dispatchedOrderList.isLoading /*|| dispatchedOrderWatch.changeOrderStatus.isLoading*/ ? const ShimmerDispatchedOrderWeb() : const DispatchedOrderListWeb().paddingOnly(right: 20.w,bottom: 20.h)),
                              robotTraySelectionWatch.isSwitchLoading ?
                              LoadingAnimationWidget.waveDots(color: AppColors.black, size: 24.h).paddingOnly(right: 17.w) :
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
                              ),
                            ],
                          );
                        },),
                      ),


                    ],
                  ),
                ).paddingSymmetric(horizontal: 40.w),
              )
            ],
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
