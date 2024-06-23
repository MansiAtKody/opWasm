import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/robot_tray_details_widget.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/robot_tray_left_widget.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/robot_tray_selection_top_status_widget.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/robot_tray_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class RobotTraySelectionWeb extends ConsumerStatefulWidget {
  const RobotTraySelectionWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<RobotTraySelectionWeb> createState() => _RobotTraySelectionModuleWebState();
}

class _RobotTraySelectionModuleWebState extends ConsumerState<RobotTraySelectionWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final robotTraySelectionWatch = ref.read(robotTraySelectionController);
      robotTraySelectionWatch.disposeController(isNotify: true);
      await robotTraySelectionWatch.robotListApi(context);
      // robotTraySelectionWatch.getRobotDetailsApi(context).then((value) {
      //   robotTraySelectionWatch.updateRobot();
      // });

    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
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
                      const RobotTraySelectionTopStatusWidget(),

                      Expanded(
                        child: Consumer(
                            builder: (context,ref,Widget? child){
                              final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Robot Tray Left Widget
                                const Expanded(
                                  child: RobotTrayLeftWidget(),
                                ),
                                /*ref.watch(robotTraySelectionController).selectedRobot?.status == RobotTrayStatusEnum.SERVING
                                    ? const MapScreenWeb()
                                    :*/

                                /// Robot Tray Widget
                                robotTraySelectionWatch.selectedRobotNew != null? const Expanded(flex: 3, child: RobotTrayWidget()):const Offstage(),

                                /*ref.watch(robotTraySelectionController).selectedRobot?.status == RobotTrayStatusEnum.SERVING
                                    ? const Offstage()
                                    :*/

                                /// Tray Details Widget
                                robotTraySelectionWatch.selectedRobotNew != null? const Expanded(flex: 6, child: RobotTrayDetailsWidget()):const Offstage(),

                              robotTraySelectionWatch.selectedRobotNew == null?  Expanded(
                                flex:9,
                                child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: AppColors.whiteF7F7FC),
                                    child: const EmptyStateWidget(
                                      title: 'No Robots',
                                      subTitle: 'No robots are currently available',
                                    ),).paddingOnly(right: 20.w,bottom: 20.h),
                              ): const Offstage()

                              ],
                            );
                          }
                        ),
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
