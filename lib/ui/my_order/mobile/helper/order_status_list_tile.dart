import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/controller/my_order/order_status_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/dashedline_vertical_painter.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:lottie/lottie.dart';

class OrderStatusListTile extends ConsumerWidget with BaseConsumerWidget {
  final OrderStatusModel orderStatusModel;

  const OrderStatusListTile({super.key, required this.orderStatusModel});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final myOrderWatch = ref.watch(myOrderController);
    String lottieName = '';
    OrderStatusEnum? orderStatus = orderStatusEnumValues.map[myOrderWatch.orderDetailsState.success?.data?.status];
    switch (orderStatus) {
      case OrderStatusEnum.PENDING:
        lottieName = AppAssets.animOrderPending;
      case OrderStatusEnum.ACCEPTED:
        lottieName = AppAssets.animOrderAccept;
    // case OrderStatusEnum.PREPARED:
    //   lottieName = AppAssets.animOrderPreparing;
    // case OrderStatusEnum.DISPATCH:
    //   lottieName = AppAssets.animOrderDispatch;
      case OrderStatusEnum.PARTIALLY_DELIVERED:
        lottieName = AppAssets.animOrderPartiallyDelivered;
      case OrderStatusEnum.DELIVERED:
        lottieName = AppAssets.animOrderDelivered;
      case OrderStatusEnum.REJECTED:
      case OrderStatusEnum.CANCELED:
      default:
    }
    return SizedBox(
      height: context.height * 0.098,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Indicator and dashed line widget
          Column(
            children: [
              /// indicator
              SizedBox(
                height: context.height * 0.05,
                width: context.height * 0.05,
                child: orderStatusModel.status == orderStatus
                    ? Lottie.asset(lottieName)
                    : Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary2.withOpacity(0.1)),
                ).paddingAll(context.height * 0.012),
              ),

              /// dash
              orderStatusModel.status != OrderStatusEnum.DELIVERED
                  ? Expanded(
                child: CustomPaint(painter: DashedLineVerticalPainter()),
              )
                  : const Offstage()
            ],
          ),

          SizedBox(width: 12.w),

          /// status name, desc
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  title: orderStatusModel.status.name,
                  clrfont: orderStatusModel.status == orderStatus ? AppColors.blue009AF1 : AppColors.black171717,
                ),
                SizedBox(height: 5.h),
                CommonText(
                  title: orderStatusModel.description,
                  clrfont: AppColors.grey7E7E7E,
                  fontSize: 12.sp,
                  maxLines: 3,
                ),
                SizedBox(height: context.height * 0.006),
              ],
            ).paddingOnly(bottom: orderStatusModel.status == OrderStatusEnum.DELIVERED ? context.height * 0.03 : 0),
          )
        ],
      ),
    );
  }
}
