
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/controller/my_order/order_status_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_status_order_item_list_tile.dart';
import 'package:kody_operator/ui/my_order/web/helper/cancel_order_button_web.dart';
import 'package:kody_operator/ui/my_order/web/helper/change_location_point_widget_web.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_details_card_widget_web.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_status_progress_widget.dart';
import 'package:kody_operator/ui/my_order/web/helper/reorder_button_widget_web.dart';
import 'package:kody_operator/ui/order_history/web/helper/common_status_button.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';

class OrderStatusWeb extends ConsumerStatefulWidget {
  final String? orderUuid;
  const OrderStatusWeb({Key? key, required this.orderUuid}) : super(key: key);

  @override
  ConsumerState<OrderStatusWeb> createState() => _OrderStatusWebState();
}

class _OrderStatusWebState extends ConsumerState<OrderStatusWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final orderStatusWatch = ref.read(orderStatusController);
      final myOrderWatch = ref.watch(myOrderController);
      orderStatusWatch.disposeController(isNotify: true);
      await myOrderWatch.orderDetailsApi(context, widget.orderUuid ?? '');
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final myOrderWatch = ref.watch(myOrderController);
    return myOrderWatch.orderDetailsState.isLoading ? DialogProgressBar(
        isLoading: myOrderWatch.orderDetailsState.isLoading) : Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: context.height * 0.05),

              /// Back button
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        ref.read(navigationStackProvider).pop();
                      },
                      child: const CommonSVG(
                        strIcon: AppAssets.svgBackArrow,
                      ),
                    ),

                    /// Status
                    CommonStatusButton(
                        status: myOrderWatch.orderDetailsState.success?.data
                            ?.status ?? '').paddingOnly(top: 25.h, bottom: 30.h)
                  ]),

              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myOrderWatch.orderDetailsState.success?.data?.status ==
                        OrderStatusEnum.CANCELED.name ||
                        myOrderWatch.orderDetailsState.success?.data?.status ==
                            OrderStatusEnum.REJECTED.name
                        ? const Offstage()
                        : Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Order Status Dashed line widget
                            const OrderStatusProgressWidgetWeb().paddingOnly(
                                bottom: 20.h),
                          ],
                        ),
                      ),
                    ),

                    /// Items List Widget
                    myOrderWatch.orderDetailsState.success?.data?.status ==
                        OrderStatusEnum.CANCELED.name ||
                        myOrderWatch.orderDetailsState.success?.data?.status ==
                            OrderStatusEnum.REJECTED.name
                        ? const Offstage()
                        : SizedBox(width: context.width * 0.01),
                    Expanded(
                      flex: 8,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ///Order Items List widget
                            CommonCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CommonText(
                                    title: LocalizationStrings.keyOrderItems
                                        .localized,
                                    textStyle: TextStyles.medium.copyWith(
                                        fontSize: 18.sp),
                                  ),
                                  SizedBox(height: context.height * 0.02),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: myOrderWatch.orderDetailsState.success?.data?.ordersItems?.length ?? 0,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      return OrderStatusOrderItemListTile(
                                        item: myOrderWatch.orderDetailsState.success?.data?.ordersItems?[index],
                                        orderUuid: myOrderWatch.orderDetailsState.success?.data?.uuid,
                                        index: index,
                                      );
                                    },
                                    separatorBuilder: (BuildContext context,
                                        int index) {
                                      return SizedBox(
                                          height: context.height * 0.01);
                                    },
                                  ),
                                ],
                              ).paddingAll(20.h),
                            ).paddingOnly(bottom: 20.h),

                            /// Details Widget
                            const OrderDetailsCardWidgetWeb().paddingOnly(bottom: 20.h),

                            /// Change Location Widget
                            ChangeLocationWidgetWeb(orderUuid: widget.orderUuid ?? ''),

                            /// Reorder Button
                            const ReorderButtonWidgetWeb(),

                            /// Cancel Order button
                            CancelOrderButtonWeb(orderUuid: widget.orderUuid ?? '').paddingOnly(top: 20.h)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: context.width * 0.02),
        )
      ],
    );
  }
}
