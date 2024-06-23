import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/notification/notification_screen_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/notification/web/helper/notification_header_tile_list_web.dart';
import 'package:kody_operator/ui/order_management/web/helper/order_detail_widget.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/hover_animation.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderStatusTopWidget extends ConsumerStatefulWidget {
  const OrderStatusTopWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderStatusTopWidget> createState() => _OrderHistoryListState();
}

class _OrderHistoryListState extends ConsumerState<OrderStatusTopWidget> with BaseConsumerStatefulWidget{
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final orderController = ref.watch(orderStatusController);
    });
  }


  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final profileWatch = ref.watch(profileController);

    return Column(
      children: [
        ///App bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                ref.read(navigationStackProvider).push(const NavigationStackItem.profile());
              },
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(57.r),
                      child: CachedNetworkImage(
                        imageUrl: profileWatch.profileDetailState.success?.data?.profileImage ?? 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
                        height: 57.w,
                        width: 57.w,
                      )).paddingOnly(right: 24.w),
                  CommonText(
                    title: profileWatch.profileDetailState.success?.data?.name ?? '',
                    textStyle: TextStyles.regular.copyWith(fontSize: 22.sp, color: AppColors.black),
                  ).paddingOnly(right: 6.w),
                  const CommonSVG(strIcon: AppAssets.svgRightArrow)
                ],
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    ref.read(navigationStackProvider).push(const NavigationStackItem.setting());
                  },
                  child: Container(
                    height: 57.h,
                    width: 57.h,
                    // padding: EdgeInsets.all(12.h),
                    decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                    child: const CommonSVG(
                      strIcon: AppAssets.svgOrderSetting,
                      boxFit: BoxFit.scaleDown,
                      svgColor: AppColors.black, /*height: 18.h,width: 18.h,*/
                    ),
                  ).paddingOnly(right: 20.w),
                ),
                HoverAnimation(
                  transformSize: 1.05,
                  child: PopupMenuButton<SampleItem>(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints.expand(width: context.width * 0.25, height: context.height * 0.5),
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    offset: Offset(-5 .w, context.height * 0.08),
                    // iconSize: 44.w,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    color: AppColors.white,
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                      PopupMenuItem<SampleItem>(
                        padding: EdgeInsets.zero,
                        value: SampleItem.itemOne,
                        child: Container(
                            color: AppColors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  title: LocalizationStrings.keyNotifications.localized,
                                  textStyle: TextStyles.medium.copyWith(fontSize: 22.sp, color: AppColors.black),
                                ).paddingSymmetric(vertical: 20.h),
                                Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                  final notificationScreenWatch = ref.watch(notificationScreenController);
                                  return ListView.builder(
                                    itemCount: notificationScreenWatch.notificationList.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var model = notificationScreenWatch.notificationList[index];
                                      return NotificationHeaderTileListWeb(
                                        model: model,
                                      ).paddingOnly(bottom: 25.h);
                                    },
                                  );
                                }),
                              ],
                            ).paddingSymmetric(horizontal: 20.w)),
                      ),
                    ],
                    child: Container(
                      height: 57.h,
                      width: 57.w,
                      padding: EdgeInsets.all(12.h),
                      decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                      child: const CommonSVG(
                        strIcon: AppAssets.svgNotification,
                        boxFit: BoxFit.scaleDown,
                        svgColor: AppColors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 57.h,
                  width: 57.w,
                  padding: EdgeInsets.all(12.h),
                  decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                  child: const CommonSVG(
                    strIcon: AppAssets.svgNotification,
                    boxFit: BoxFit.scaleDown,
                    svgColor: AppColors.black,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 30.h,
        ),

        Row(
          children: [
            Expanded(
              child: FadeBoxTransition(
                delay: 30,
                child: OrderDetailWidget(orderTitle: LocalizationStrings.keyNewOrders.localized, orderNumber: '100', imageName: AppAssets.svgNewOrder),
              ),
            ),
            SizedBox(
              width: 35.w,
            ),
            Expanded(
              child: FadeBoxTransition(
                delay: 60,
                child: OrderDetailWidget(orderTitle: LocalizationStrings.keyTotalOrders.localized, orderNumber: '10', imageName: AppAssets.svgTotalOrder),
              ),
            ),
            SizedBox(
              width: 35.w,
            ),
            Expanded(
              child: FadeBoxTransition(
                delay: 90,
                child: OrderDetailWidget(orderTitle: LocalizationStrings.keyTotalServices.localized, orderNumber: '10', imageName: AppAssets.svgPastOrder),
              ),
            )
          ],
        )
      ],
    ).paddingSymmetric(horizontal: 32.w, vertical: 22.h);
  }

  // ///notification dropdown widget
  // Widget _notificationDropDown() {
  //   return ;
  // }

}
