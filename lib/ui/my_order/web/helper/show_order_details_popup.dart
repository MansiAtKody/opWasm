
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_history_details_popup.dart';
import 'package:kody_operator/ui/my_order/web/helper/status_button_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

showOrderDetailsPopup(BuildContext context, MyOrderController myOrderWatch,){
  showAnimatedDialogForOrder(
    context,
    title: '',
    titleWidget: Row(
      children: [
        Container(
          decoration: BoxDecoration(color: AppColors.yellowFFEDBF, borderRadius: BorderRadius.all(Radius.circular(24.r))),
          child: CommonText(
            title: myOrderWatch.orderDetailsState.success?.data?.uuid ?? '',
            textStyle: TextStyles.regular.copyWith(
              fontSize: 22.sp,
              color: AppColors.black,
            ),
          ).paddingSymmetric(horizontal: 18.w, vertical: 8.h),
        ).paddingOnly(right: 15.w),
        StatusButtonWidget(status: myOrderWatch.orderDetailsState.success?.data?.status ?? ''),
      ],
    ),
    heightPercentage: 64,
    widthPercentage: 70,
    onPopCall: (animationController) {
      myOrderWatch.updateAnimationController(animationController);
    },
    onCloseTap: () {
      myOrderWatch.animationController?.reverse(from: 0.3);
      Navigator.pop(context);
    },
    child: Container(
      height: context.height * 0.64,
      width: context.width * 0.7,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: const OrderHistoryDetailsPopup(),
    ),
  );
}