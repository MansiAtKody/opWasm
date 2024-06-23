
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/cancel_order_button_mobile.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/change_location_point_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_details_card_widget_mobile.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_status_list_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_status_order_item_list_tile.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/reorder_widget_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
class OrderStatusMobile extends ConsumerStatefulWidget {
  final String? orderId;

  const OrderStatusMobile({Key? key, required this.orderId}) : super(key: key);

  @override
  ConsumerState<OrderStatusMobile> createState() => _OrderStatusMobileState();
}

class _OrderStatusMobileState extends ConsumerState<OrderStatusMobile> with BaseConsumerStatefulWidget{
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final myOrderWatch = ref.read(myOrderController);
      await myOrderWatch.orderDetailsApi(context, widget.orderId ?? '');
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final myOrderWatch = ref.watch(myOrderController);
    return Material(
      color: AppColors.transparent,
      child: Stack(
        children: [
          CommonWhiteBackground(
            appBar:CommonAppBar(
            title: LocalizationStrings.keyOrderStatus.localized,
            isLeadingEnable: true,

           ),
            child: Column(
                children:[
                  Expanded(
                      child: _bodyWidget()
                  ),
                  _bottomWidget()
                ],
            ),
          ),
          DialogProgressBar(isLoading: myOrderWatch.orderDetailsState.isLoading),
          ]
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final myOrderWatch = ref.watch(myOrderController);
    return RefreshIndicator(
      backgroundColor: AppColors.black,
      color: AppColors.white,
      onRefresh: () async {
        myOrderWatch.orderDetailsApi(context, widget.orderId ?? '');
      },
      child:
     SingleChildScrollView(
        child: Column(
          children: [
            /// order status
            const OrderStatusListWidgetMobile(),

            SizedBox(height: 20.h),

            ///Order Items
            CommonCard(
              color: AppColors.whiteF7F7FC,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    title: LocalizationStrings.keyOrderItems.localized,
                    textStyle: TextStyles.medium.copyWith(fontSize: 14.sp),
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
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: context.height * 0.01);
                    },
                  ),
                ],
              ).paddingAll(20.h),
            ).paddingOnly(bottom: 20.h),

            /// order details
            const OrderDetailsCardWidgetMobile().paddingOnly(bottom: 20.h),


            ///Change location widget
            ChangeLocationPointWidgetMobile(orderId: widget.orderId??'')
          ],
        ).paddingAll(10.h),
      )
    );
  }

  /// Bottom Widget
  Widget _bottomWidget(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CancelOrderButtonWidgetMobile(orderId: widget.orderId??''),
        const ReorderWidgetMobile().paddingSymmetric(horizontal: 20.w)
      ],
    );
  }
}
