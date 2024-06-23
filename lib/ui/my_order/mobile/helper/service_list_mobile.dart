

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/service_model_widget.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class ServiceList extends ConsumerWidget with BaseConsumerWidget {
  const ServiceList({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final orderListWatch = ref.watch(myOrderController);
    return orderListWatch.displayOrderList.isNotEmpty
        ? ListView.separated(
            shrinkWrap: true,
            itemCount: orderListWatch.displayOrderList.length,
            itemBuilder: (context, index) {
              OrderModel model = orderListWatch.displayOrderList[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    ServiceModelWidget(
                      order: model,
                      onFavIconTap: () {
                        orderListWatch.updateOrderToFavorite(model.orderId);
                      },
                    ),
                    _orderCardBottom(model),
                  ],
                ).paddingAll(20.h),
              ).paddingOnly(bottom: 20.h, left: 20.w, right: 20.w);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 20.h);
            },
          )
        : EmptyStateWidget(
            title: LocalizationStrings.keyNoOrders.localized,
            subTitle: LocalizationStrings.keyYouHaveNotOrderedAnything.localized,
          ).paddingOnly(top: 100.h);
  }

  Widget _orderCardBottom(OrderModel model) {
    return Consumer(
      builder: (context, ref, child) {
        final orderListWatch = ref.watch(myOrderController);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            orderListWatch.selectedOrderFilter?.type == OrderType.current
                ? InkWell(
                    onTap: () {
                      ref.read(navigationStackProvider).push(NavigationStackItem.orderFlowStatus(orderId: model.orderId.toString()));
                    },
                    child: Row(
                      children: [
                        CommonText(
                          title: '${LocalizationStrings.keyTrack.localized} ${orderListWatch.selectedOrderTypeFilter?.name}',
                          fontSize: 12.sp,
                          clrfont: AppColors.primary2,
                          textDecoration: TextDecoration.underline,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: AppColors.primary2,
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      ref.read(navigationStackProvider).push(NavigationStackItem.orderDetails(orderId: model.orderId.toString()));
                    },
                    child: Row(
                      children: [
                        CommonText(
                          title: '${ref.watch(myOrderController).selectedOrderTypeFilter?.name} ${LocalizationStrings.keyDetails.localized}',
                          fontSize: 12.sp,
                          clrfont: AppColors.primary2,
                          textDecoration: TextDecoration.underline,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: AppColors.primary2,
                        ),
                      ],
                    ),
                  ),
            Container(
              height: 40.h,
              width: 116.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: orderListWatch.getOrderStatusTextColor(model.status.toString()).buttonBgColor,
              ),
              child: Center(
                child: CommonText(
                  title: orderListWatch.getOrderStatusTextColor(model.status.toString()).orderStatus,
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 16.sp,
                    color: orderListWatch.getOrderStatusTextColor(model.status.toString()).buttonTextColor,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
