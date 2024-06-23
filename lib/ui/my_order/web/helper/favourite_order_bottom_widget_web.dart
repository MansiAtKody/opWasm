

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_details_pop_up_widget_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class FavouriteOrderBottomWidgetWeb extends ConsumerWidget with BaseConsumerWidget {
  final OrderModel? orderModel;

  const FavouriteOrderBottomWidgetWeb({super.key, required this.orderModel});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            showAnimatedDialog(
              context,
              child: OrderDetailsPopUpWidgetWeb(orderModel: orderModel),
              heightPercentage: 40,
              widthPercentage: 40,
              onCloseTap: () {
                Navigator.pop(context);
              },
              title: LocalizationStrings.keyOrderDetails.localized,
            );
          },
          child: Row(
            children: [
              CommonText(
                title: LocalizationStrings.keyOrderDetails.localized,
                fontSize: 16.sp,
                clrfont: AppColors.primary2,
                textDecoration: TextDecoration.underline,
              ),
              SizedBox(
                width: 15.w,
              ),
            ],
          ),
        ),
        CommonButton(
          buttonText: LocalizationStrings.keyQuickOrder.localized,
          buttonEnabledColor: AppColors.primary,
          buttonTextColor: AppColors.white,
          height: 40.h,
          width: 116.w,
          buttonTextStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.white),
          onTap: () {
            /// Navigate to home screen and will show order processing
            showSuccessDialogue(
              context: context,
              animation: AppAssets.animOrderSuccessfulNewLottieWeb,
              successMessage: LocalizationStrings.keyYourOrderIsPlaced.localized,
              successDescription: LocalizationStrings.keyYourOrderIsPreparingMsg.localized,
              buttonText: LocalizationStrings.keyClose.localized,
              onTap: () {
                // final homeWatch = ref.watch(homeController);
                // homeWatch.updateOrderStatus(OrderStatusHomeEnum.orderProcessing);
                // homeWatch.updateIsShowOrderStatusWidget(true);
                // Navigator.pop(context);
                // ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
              },
            );
          },
        ),
      ],
    ).alignAtCenterRight();
  }
}
