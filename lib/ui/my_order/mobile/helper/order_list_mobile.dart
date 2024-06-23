

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_model_widget.dart';
import 'package:kody_operator/ui/order_history/web/helper/common_status_button.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class OrdersListMobile extends ConsumerWidget with BaseConsumerWidget {
  const OrdersListMobile({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final myOrderWatch = ref.watch(myOrderController);
    return myOrderWatch.myOrderList?.isNotEmpty??false
        ? Column(
          children:[ Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                controller: myOrderWatch.myOrderListScrollController,
                itemCount: myOrderWatch.myOrderList?.length ?? 0,
                itemBuilder: (context, index) {
                  OrderListResponseData? model = myOrderWatch.myOrderList?[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteF7F7FC,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        OrderModelWidget(
                          orderModel: model,
                          index: index,
                        ),
                        _orderCardBottom(model),
                      ],
                    ).paddingAll(20.h),
                  ).paddingOnly(bottom: 20.h, left: 20.w, right: 20.w);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20.h);
                },
              ),
          ),
            Visibility(
                visible: myOrderWatch.orderListState.isLoadMore,
                child:Center(child: const  CircularProgressIndicator(color: AppColors.black,).paddingOnly(top:22.h))),
          ]
        )
        : EmptyStateWidget(
            title: LocalizationStrings.keyNoOrders.localized,
            subTitle: LocalizationStrings.keyYouHaveNotOrderedAnything.localized,
          ).paddingOnly(top: 100.h);
  }

  Widget _orderCardBottom(OrderListResponseData? model) {
    return Consumer(
      builder: (context, ref, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                ref.read(navigationStackProvider).push(NavigationStackItem.orderFlowStatus(orderId: model?.uuid));
              },
              child: Row(
                children: [
                  CommonText(
                    title: LocalizationStrings.keyViewDetails.localized,
                    fontSize: 14.sp,
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
            CommonStatusButton(status:model?.status ??'',isFilled:true)
          ],
        );
      },
    );
  }
}
