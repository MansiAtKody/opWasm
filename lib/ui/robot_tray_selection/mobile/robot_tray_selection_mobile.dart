import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/helper/bottom_buttons_robot_tray_selection_mobile.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/helper/orders_robot_tray_tab_widget_robot_tray_selection.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/helper/robot_tray_details_data_widget_mobile.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/helper/robot_tray_top_widget.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/helper/shimmer_robot_tray_selection_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class RobotTraySelectionMobile extends ConsumerStatefulWidget {
  const RobotTraySelectionMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<RobotTraySelectionMobile> createState() =>
      _RobotTraySelectionModuleMobileState();
}

class _RobotTraySelectionModuleMobileState
    extends ConsumerState<RobotTraySelectionMobile>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final robotTraySelectionModuleWatch = ref.read(robotTraySelectionController);
      robotTraySelectionModuleWatch.disposeController(isNotify: true);
      await robotTraySelectionModuleWatch.robotListApi(context);
      // robotTraySelectionModuleWatch.initSelectedRobotTray();
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final robotTraySelectionModuleWatch =
        ref.watch(robotTraySelectionController);
    return CommonWhiteBackground(
      appBar: CommonAppBar(
        title: LocalizationStrings.keyRobotAndTraySelection.localized,
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
      child:  robotTraySelectionModuleWatch.robotListState.isLoading
        ? const ShimmerRobotTraySelectionMobile()
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
                        child: const RobotTrayTopWidgetMobile().paddingAll(8.h),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    robotTraySelectionWatch.selectedRobotNew != null?CommonText(
                      title: LocalizationStrings.keyOrders.localized,
                      textStyle: TextStyles.regular
                          .copyWith(color: AppColors.black, fontSize: 18.sp),
                    ).paddingSymmetric(vertical: 20.h, horizontal: 20.w): const Offstage(),

                    /// Orders Tab Widget
                    robotTraySelectionWatch.selectedRobotNew != null? const OrdersRobotTrayTabWidgetRobotTraySelection(): const Offstage(),

                    robotTraySelectionWatch.selectedRobotNew != null?Container(
                      color: AppColors.transparent,
                      child: const RobotTrayDetailsDataWidgetMobile(),
                    ): const Offstage(),


                    robotTraySelectionWatch.selectedRobotNew == null?EmptyStateWidget(title:LocalizationStrings.keyNoRobots.localized,subTitle: LocalizationStrings.keyNoRobotsMsg.localized,):const Offstage(),
                  ],
                ),
              ),
            ),
          ),
        ),
        robotTraySelectionWatch.selectedRobotNew != null? const BottomButtonsRobotTraySelectionMobile(): const Offstage(),
      ],
    );
  }
}
