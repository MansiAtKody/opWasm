

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/common_title_value_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class OrderDetailsPopUpWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  final OrderModel? orderModel;

  const OrderDetailsPopUpWidgetWeb({super.key, required this.orderModel});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonTitleValueWidget(
              title: LocalizationStrings.keyOrderNo.localized,
              value: '${orderModel?.orderId ?? 0}',
              titleFontSize: 16.sp,
              valueFontSize: 16.sp,
            ),
            CommonTitleValueWidget(
              title: LocalizationStrings.keyOrderStatus.localized,
              value: (orderModel?.status?.name ?? '').capsFirstLetterOfSentence,
              valueColor: ref.watch(myOrderController).getOrderStatusTextColor(orderModel?.status.toString()).buttonTextColor,
              titleFontSize: 16.sp,
              valueFontSize: 16.sp,
            ),
            CommonTitleValueWidget(
              title: LocalizationStrings.keyDepartment.localized,
              value: 'UI/UX Designer',
              titleFontSize: 16.sp,
              valueFontSize: 16.sp,
            ),
            CommonTitleValueWidget(
              title: LocalizationStrings.keyDateTime.localized,
              value: '06 Aug 2023 at 1:45PM',
              titleFontSize: 16.sp,
              valueFontSize: 16.sp,
            ),
            CommonTitleValueWidget(
              title: LocalizationStrings.keyQty.localized,
              value: '01',
              bottomPadding: 0.h,
              titleFontSize: 16.sp,
              valueFontSize: 16.sp,
            ),
          ],
        );
      },
    );
  }
}
