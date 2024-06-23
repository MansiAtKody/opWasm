import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_management_controller.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/order_tab_widget.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/shimmer_order_management_mobile.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/staticstics_widget.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class OrderManagementMobile extends ConsumerStatefulWidget {
  const OrderManagementMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderManagementMobile> createState() => _OrderManagementMobileState();
}

class _OrderManagementMobileState extends ConsumerState<OrderManagementMobile> with BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ScrollController gridScrollController = ScrollController();

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final orderManagementWatch = ref.read(orderManagementController);
      final orderStatusWatch = ref.read(orderStatusController);
      orderManagementWatch.disposeController(isNotify: true);
      orderStatusWatch.disposeController(isNotify: true);
      ref.watch(orderStatusController).socketManager.startSocket(ref);
      final profileWatch = ref.watch(profileController);
      /// Device token registration
      if(Session.getOldFCMToken().isEmpty){
        await orderManagementWatch.registerDeviceFcmToken(context);
        await Session.saveLocalData(keyOldFCMToken, Session.getNewFCMToken());
      }else if(Session.getNewFCMToken() != Session.getOldFCMToken()){
        await orderManagementWatch.registerDeviceFcmToken(context);
        await Session.saveLocalData(keyOldFCMToken, Session.getNewFCMToken());
      }

      await profileWatch.getProfileDetail(context);
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodySliver();
  }

  ///silver scrolling
  Widget _bodySliver() {
    final orderListWatch = ref.watch(orderStatusController);
    final profileWatch = ref.watch(profileController);
    return CommonWhiteBackground(
      appBar: CommonAppBar(
        backgroundColor: AppColors.black,
        customTitleWidget: const CommonSVG(strIcon: AppAssets.svgDasher),
        isDrawerEnable: true,
        actions: [
          ///Appbar actions
          InkWell(
              onTap: () {
                  ref.read(navigationStackProvider).push(const NavigationStackItem.setting());
              },
              child: const CommonSVG(strIcon: AppAssets.svgSettingMobile).paddingOnly(right: 10.w)),
          ///Do not remove this code
          InkWell(
              onTap: () {
                ref.read(navigationStackProvider).push(const NavigationStackItem.notification());
              },
              child: const CommonSVG(strIcon: AppAssets.svgNotificationMobile).paddingOnly(right: 12.w))
        ],
      ),
      child: profileWatch.profileDetailState.isLoading
          ? const ShimmerOrderManagementMobile()
          : NestedScrollView(
              controller: gridScrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    elevation: 0,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(10.h),
                      child: SizedBox(
                        height: 10.h,
                      ),
                    ),
                    leading: const SizedBox(),
                    backgroundColor: AppColors.white,
                    //pinned: true,
                    floating: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),
                        topLeft: Radius.circular(20.r),
                      ),
                    ),
                    expandedHeight: context.height * 0.27,
                    flexibleSpace: const FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: StatisticsWidget(),
                    ),
                    //actions: _appBarActions(),
                  ),

                  //const HomeAppBarSliverDelegateHelperWidget(),
                ];
              },
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText(
                    title: LocalizationStrings.keyOrders.localized,
                    textStyle: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 18.sp),
                  ).paddingSymmetric(vertical: 20.h, horizontal: 20.w),
                  const OrderTabWidget(),
                  Expanded(
                    child: Container(child: orderListWatch.orderListWidgets[orderListWatch.selectedTabIndex]),
                  )
                  //UpcomingOrderListMobile()
                  //
                ],
              ),
            ),
    );
  }
}
