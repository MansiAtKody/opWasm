import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderTabWidget extends ConsumerStatefulWidget {
  const OrderTabWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderTabWidget> createState() => _OrderTabWidgetState();
}

class _OrderTabWidgetState extends ConsumerState<OrderTabWidget> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final orderController = ref.watch(orderStatusController);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final orderWatch = ref.watch(orderStatusController);
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  color: AppColors.white,
                  height: 35.h,
                  width: double.maxFinite,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: orderWatch.selectedTabIndex == 2 ? AppColors.white : AppColors.whiteF7F7FC, borderRadius: orderWatch.selectedTabIndex == 1 ? BorderRadius.all(Radius.circular(15.r)) : const BorderRadius.all(Radius.circular(0))),
                        height: 35.h,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: orderWatch.selectedTabIndex == 1 ? BorderRadius.all(Radius.circular(15.r)) : const BorderRadius.all(Radius.circular(0)),
                          color: orderWatch.selectedTabIndex == 0 ? AppColors.white : AppColors.whiteF7F7FC,
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
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      //OrderModel model = orderListWatch.orderList[index];
                      return ListBounceAnimation(
                        onTap: () {
                          orderWatch.updateTabIndex(index);
                        },
                        child: Container(
                          width: 0.3125.sw,
                          decoration: BoxDecoration(color: orderWatch.selectedTabIndex == index ? AppColors.whiteF7F7FC : AppColors.white, borderRadius: BorderRadius.all(Radius.circular(15.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonText(title: orderWatch.orderTitle[index], textStyle: TextStyles.regular.copyWith(color: orderWatch.selectedTabIndex == index ? AppColors.blue009AF1 : AppColors.grey8D8C8C)).paddingOnly(right: 5.w),
                              (index == 0 && orderWatch.upcomingSocketOrders.isNotEmpty)
                                  ? Container(
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: orderWatch.selectedTabIndex == index ? AppColors.blue009AF1 : AppColors.grey8D8C8C),
                                      child: CommonText(
                                        title: index == 0
                                            ? orderWatch.upcomingSocketOrders.length.toString()
                                            : index == 1
                                                ? orderWatch.ongoingSocketOrders.length.toString()
                                                : orderWatch.pastSocketOrders.length.toString(),
                                        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.white),
                                      ).paddingAll(8.w),
                                    )
                                  : (index == 1 && orderWatch.ongoingSocketOrders.isNotEmpty)
                                      ? Container(
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: orderWatch.selectedTabIndex == index ? AppColors.blue009AF1 : AppColors.grey8D8C8C),
                                          child: CommonText(
                                            title: index == 0
                                                ? orderWatch.upcomingSocketOrders.length.toString()
                                                : index == 1
                                                    ? orderWatch.ongoingSocketOrders.length.toString()
                                                    : orderWatch.pastSocketOrders.length.toString(),
                                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.white),
                                          ).paddingAll(8.w),
                                        )
                                      : (index == 2 && orderWatch.pastSocketOrders.isNotEmpty)
                                          ? Container(
                                              decoration: BoxDecoration(shape: BoxShape.circle, color: orderWatch.selectedTabIndex == index ? AppColors.blue009AF1 : AppColors.grey8D8C8C),
                                              child: CommonText(
                                                title: index == 0
                                                    ? orderWatch.upcomingSocketOrders.length.toString()
                                                    : index == 1
                                                        ? orderWatch.ongoingSocketOrders.length.toString()
                                                        : orderWatch.pastSocketOrders.length.toString(),
                                                textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.white),
                                              ).paddingAll(8.w),
                                            )
                                          : Container()
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
