import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrdersRobotTrayTabWidgetRobotTraySelection extends ConsumerStatefulWidget {
  const OrdersRobotTrayTabWidgetRobotTraySelection({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersRobotTrayTabWidgetRobotTraySelection> createState() => _OrdersTabWidgetRobotTraySelectionState();
}

class _OrdersTabWidgetRobotTraySelectionState extends ConsumerState<OrdersRobotTrayTabWidgetRobotTraySelection> with BaseConsumerStatefulWidget {
  // ///Init Override
  // @override
  // void initState() {
  //   super.initState();
  //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //     final robotTraySelectionModuleWatch = ref.watch(robotTraySelectionController);
  //     robotTraySelectionModuleWatch.initSelectedRobotTray();
  //   });
  // }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
    return  Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  color: AppColors.whiteF7F7FC,
                  height: 35.h,
                  width: double.maxFinite,
                ),

                /// Without list.generate
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: robotTraySelectionWatch.selectedTrayNumber == robotTraySelectionWatch.selectedRobotNew?.numberOfTray ?  AppColors.whiteF7F7FC : AppColors.white,
                            borderRadius: robotTraySelectionWatch.selectedTrayNumber == 1 ? BorderRadius.all(Radius.circular(15.r)) : const BorderRadius.all(Radius.circular(0))
                        ),
                        height: 35.h,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: robotTraySelectionWatch.selectedTrayNumber == 1 ? BorderRadius.all(Radius.circular(15.r)) : const BorderRadius.all(Radius.circular(0)),
                          color: robotTraySelectionWatch.selectedTrayNumber == 1 ? AppColors.whiteF7F7FC : AppColors.white,

                        ),
                        height: 35.h,
                      ),
                    )
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 12.w),
            Row(
              children: [
                SizedBox(
                  height: 70.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: robotTraySelectionWatch.selectedRobotNew?.numberOfTray ?? 0,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListBounceAnimation(
                        onTap: () {
                          if (robotTraySelectionWatch.selectedRobotNew != null) {
                            robotTraySelectionWatch.updateSelectedTrayNumber(context, index + 1);
                          }
                        },
                        child: Container(
                          width: 0.3125.sw,
                          decoration: BoxDecoration(
                              color: robotTraySelectionWatch.selectedTrayNumber == index + 1
                                  ? AppColors.white
                                  : AppColors.whiteF7F7FC,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          CommonText(
                          title: /*index == 3 ? '' : */'Tray ${index + 1}',
                              textStyle: TextStyles.regular.copyWith(
                                  color: /*robotTraySelectionWatch.selectedTray == trayModel ? AppColors.blue009AF1
                                      :*/ AppColors.grey8D8C8C)).paddingOnly(right: 5.w),
                            ],
                          ).paddingSymmetric(vertical: 15.h),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 12.w)
          ],
        ),
      ],
    );
  }
}