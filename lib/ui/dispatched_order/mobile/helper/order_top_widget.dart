import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/dispatched_order/dispatched_order_controller.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/response_model/robot_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';

class OrderTopWidgetMobile extends ConsumerStatefulWidget  {
  const OrderTopWidgetMobile({super.key});

  @override
  ConsumerState<OrderTopWidgetMobile> createState() => _OrderTrayTopWidgetMobileState();
}

class _OrderTrayTopWidgetMobileState extends ConsumerState<OrderTopWidgetMobile> with BaseConsumerStatefulWidget{
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final robotTraySelectionModuleWatch = ref.read(robotTraySelectionController);
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

        return Container(
          width: context.width,
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Text
              CommonText(
                title: LocalizationStrings.keyRobot.localized,
                textStyle: TextStyles.medium,
              ).paddingOnly(left: 30.w, top: 20.h, bottom: 20.h),

              /// Robot Icons List
              SizedBox(
                height: context.height * 0.16,
                child: ListView.separated(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: (robotTraySelectionWatch.robotListForOrder.length) + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if(index != robotTraySelectionWatch.robotListForOrder.length) {
                      RobotListResponseData? robotModel = robotTraySelectionWatch
                          .robotListForOrder[index];
                      String robotImage = '';
                      switch (robotTrayStatusValues.map[robotModel.state]) {
                        case null:
                          robotImage = AppAssets.robotUnavailable;
                        case RobotTrayStatusEnum.AVAILABLE:
                          if (robotModel ==
                              robotTraySelectionWatch.selectedRobotNew) {
                            robotImage = AppAssets.robotAvailableSelected;
                          } else {
                            robotImage = AppAssets.robotAvailableUnselected;
                          }
                        case RobotTrayStatusEnum.UNAVAILABLE:
                          if (robotModel ==
                              robotTraySelectionWatch.selectedRobotNew) {
                            robotImage = AppAssets.robotUnavailable;
                          } else {
                            robotImage = AppAssets.robotUnavailable;
                          }
                        case RobotTrayStatusEnum.SERVING:
                          if (robotModel ==
                              robotTraySelectionWatch.selectedRobotNew) {
                            robotImage = AppAssets.robotServingSelected;
                          } else {
                            robotImage = AppAssets.robotServingUnselected;
                          }
                        default:
                          if (robotModel ==
                              robotTraySelectionWatch.selectedRobotNew) {
                            robotImage = AppAssets.robotUnavailable;
                          } else {
                            robotImage = AppAssets.robotUnavailable;
                          }
                      }

                      return Column(
                        children: [

                          /// Robot Image
                          ListBounceAnimation(
                            onTap: () async {
                                robotTraySelectionWatch.updateSelectedRobotNew(
                                    context, selectedRobot: robotModel);
                                await dispatchedOrderWatch.getDispatchedOrderListApi(context: context,robotUuid: robotModel.uuid ?? '');

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
                              color: /*robotModel == robotTraySelectionWatch.selectedRobotNew ? AppColors.blue0083FC : */ AppColors
                                  .black,
                            ),
                          ).paddingOnly(top: 12.h),
                        ],
                      );
                    }
                    else{
                      return DialogProgressBar(isLoading: robotTraySelectionWatch.robotListState.isLoadMore, forPagination: true,).paddingOnly(right: 20.w);
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 20.h);
                  },
                ),
              ).paddingSymmetric(horizontal: 20.w),
            ],
          ),
        );
      },
    );
  }
}
