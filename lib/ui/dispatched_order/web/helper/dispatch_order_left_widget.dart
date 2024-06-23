import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/dispatched_order/dispatched_order_controller.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/response_model/robot_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
import 'package:shimmer/shimmer.dart';


class DispatchOrderLeftWidget extends ConsumerStatefulWidget {
  const DispatchOrderLeftWidget({super.key});

  @override
  ConsumerState<DispatchOrderLeftWidget> createState() => _DispatchOrderLeftWidgetState();
}

class _DispatchOrderLeftWidgetState extends ConsumerState<DispatchOrderLeftWidget> with BaseConsumerStatefulWidget {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final robotTraySelectionModuleWatch = ref.watch(robotTraySelectionController);
      /// for pagination
      scrollController.addListener(() async {
        if (robotTraySelectionModuleWatch.robotListState.success?.hasNextPage ??
            false) {
          if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
            if (!robotTraySelectionModuleWatch.robotListState.isLoadMore) {
              await robotTraySelectionModuleWatch.robotListApi(context);
            }
          }
        }
      });
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        final dispatchedOrderWatch = ref.watch(dispatchedOrderController);

        return robotTraySelectionWatch.robotListState.isLoading ? _shimmerRobotTrayLeftWidget() : ListView.separated(
          controller: scrollController,
          shrinkWrap: true,
          itemCount: robotTraySelectionWatch.robotListForOrder.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if(index != robotTraySelectionWatch.robotListForOrder.length) {
              RobotListResponseData? robotModel = robotTraySelectionWatch
                  .robotListForOrder[index];
              String robotImage = '';
              switch (robotTrayStatusValues.map[robotModel.state]) {
                case null:robotImage = AppAssets.robotUnavailable;
                case RobotTrayStatusEnum.AVAILABLE:
                  if (robotModel == robotTraySelectionWatch.selectedRobotNew) {
                    robotImage = AppAssets.robotAvailableSelected;
                  } else {
                    robotImage = AppAssets.robotAvailableUnselected;
                  }
                case RobotTrayStatusEnum.UNAVAILABLE:
                  if (robotModel == robotTraySelectionWatch.selectedRobotNew) {
                    robotImage = AppAssets.robotUnavailable;
                  } else {
                    robotImage = AppAssets.robotUnavailable;
                  }

                case RobotTrayStatusEnum.SERVING:
                  if (robotModel == robotTraySelectionWatch.selectedRobotNew) {
                    robotImage = AppAssets.robotServingSelected;
                  } else {
                    robotImage = AppAssets.robotServingUnselected;
                  }

                default:
                  if (robotModel == robotTraySelectionWatch.selectedRobotNew) {
                    robotImage = AppAssets.robotUnavailable;
                  } else {
                    robotImage = AppAssets.robotUnavailable;
                  }

              }

              return FadeBoxTransition(
                delay: 250,
                child: Column(
                  children: [

                    /// Robot Image
                    ListBounceAnimation(
                      animate: true,
                      onTap: () async {
                          robotTraySelectionWatch.updateSelectedRobotForDispatchOrder(
                              context, selectedRobot: robotModel);
                          await dispatchedOrderWatch.getDispatchedOrderListApi(context: context,robotUuid: robotModel.uuid ?? '');
                          robotTraySelectionWatch.trayBoxAnimationController
                              ?.forward(from: 0);
                      },
                      child: Image.asset(
                        robotImage,
                        height: 80.h,
                        width: 80.h,
                      ),
                    ),

                    /// Robot Name
                    CommonText(
                      title: robotModel.name ?? '',
                      textStyle: TextStyles.medium.copyWith(
                        fontSize: 12.sp,
                        color: robotModel ==
                            robotTraySelectionWatch.selectedRobotNew ? AppColors
                            .blue0083FC : AppColors.black,
                      ),
                    ).paddingOnly(top: 12.h),
                  ],
                ).paddingOnly(left: 25.w, right: 22.w, top: 22.h),
              );
            }
            else{
              return DialogProgressBar(isLoading: robotTraySelectionWatch.robotListState.isLoadMore, forPagination: true,).paddingOnly(right: 20.w);
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20.h);
          },
        );
      },
    );
  }

  /// shimmer
  Widget _shimmerRobotTrayLeftWidget(){
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.white,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.white,
              ).paddingOnly(bottom: 10.h),
              Container(
                height: 10.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ],
          ).paddingOnly(bottom: 40.h);
        },
      ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
    );
  }
}
