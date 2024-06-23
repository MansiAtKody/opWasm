

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class PastOrderBottomWidgetMobile extends ConsumerWidget with BaseConsumerWidget {
  final OrderModel? orderModel;

  const PastOrderBottomWidgetMobile({super.key, required this.orderModel});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            ref.read(navigationStackProvider).push(NavigationStackItem.orderDetails(orderId: orderModel?.orderId.toString()));
          },
          child: Row(
            children: [
              CommonText(
                title: LocalizationStrings.keyOrderDetails.localized,
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

        ///Reorder Button
        CommonButton(
          buttonText: LocalizationStrings.keyQuickOrder.localized,
          buttonEnabledColor: AppColors.primary,
          buttonTextColor: AppColors.white,
          height: 40.h,
          width: 116.w,
          onTap: () {
            ref.read(navigationStackProvider).push(const NavigationStackItem.orderSuccessful(fromScreen: FromScreen.myOrder));
          },
        ),
      ],
    ).alignAtCenterRight();
  }
}
