import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/common_title_value_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderDetailsCardWidgetWeb extends ConsumerWidget  with BaseConsumerWidget{
  const OrderDetailsCardWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final myOrderWatch = ref.watch(myOrderController);
    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonText(
            title: LocalizationStrings.keyOrderDetails.localized,
            textStyle: TextStyles.medium.copyWith(fontSize: 20.sp),
          ).paddingOnly(top: 10.h, bottom: 30.h),
          _commonTitleValueWidget(title: LocalizationStrings.keyOrderId.localized, value: myOrderWatch.orderDetailsState.success?.data?.uuid ?? ''),
          _commonTitleValueWidget(title: LocalizationStrings.keyLocation.localized, value: myOrderWatch.orderDetailsState.success?.data?.locationPointsName ?? ''),
          _commonTitleValueWidget(
            title: LocalizationStrings.keyQty.localized,
            value: myOrderWatch.orderDetailsState.success?.data?.totalQty.toString() ?? '',
            bottomPadding: 0,
          ),
        ],
      ).paddingAll(30.h),
    );
  }
  ///Common title tile widget
  _commonTitleValueWidget({required String title, required String value, double? bottomPadding}) {
    return CommonTitleValueWidget(
      title: title,
      value: value,
      bottomPadding: 20.h,
      titleFontSize: 16.sp,
      valueFontSize: 16.sp,
    );
  }
}
