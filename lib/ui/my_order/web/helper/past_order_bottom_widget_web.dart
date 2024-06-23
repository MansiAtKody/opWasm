

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_details_pop_up_widget_web.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class PastOrderBottomWidgetWeb extends ConsumerWidget with BaseConsumerWidget {
  final OrderModel? orderModel;

  const PastOrderBottomWidgetWeb({super.key, required this.orderModel});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            showAnimatedDialog(
              context,
              //padding: EdgeInsets.symmetric(horizontal: context.width * 0.015, vertical: context.height * 0.02),
              child: OrderDetailsPopUpWidgetWeb(orderModel: orderModel),
              heightPercentage: 40,
              widthPercentage: 40,
              onCloseTap: () {
                Navigator.pop(context);
              },
              title: '${ref.watch(myOrderController).selectedOrderTypeFilter?.name} ${LocalizationStrings.keyDetails.localized}',
            );
          },
          child: Row(
            children: [
              CommonText(
                title: '${ref.watch(myOrderController).selectedOrderTypeFilter?.name} ${LocalizationStrings.keyDetails.localized}',
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
        orderModel?.orderType == OrderType.order ? CommonButton(
          buttonText: LocalizationStrings.keyReorder.localized,
          buttonEnabledColor: AppColors.primary,
          buttonTextColor: AppColors.white,
          height: 40.h,
          width: 116.w,
          buttonTextStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.white),
          onTap: () {
            /// Navigate to tray
            final drawerWatch = ref.watch(drawerController);
            drawerWatch.updateSelectedScreen(ScreenName.tray);
            ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.myTray());
          },
        ) : const Offstage(),
      ],
    ).alignAtCenterRight();
  }
}
