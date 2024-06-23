import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/additional_note_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/common_title_value_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderDetailsCardWidgetMobile extends ConsumerWidget with BaseConsumerWidget{
  const OrderDetailsCardWidgetMobile({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final myOrderWatch = ref.watch(myOrderController);
    return  CommonCard(
      color: AppColors.whiteF7F7FC,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            title: LocalizationStrings.keyOrderDetails.localized,
            textStyle: TextStyles.medium.copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 20.h,
          ),
          _commonTitleValueWidget(title: LocalizationStrings.keyOrderId.localized, value: myOrderWatch.orderDetailsState.success?.data?.uuid ?? ' '),
          _commonTitleValueWidget(title: LocalizationStrings.keyLocation.localized, value: myOrderWatch.orderDetailsState.success?.data?.locationPointsName ?? ' '),
          AdditionalNoteWidget(
            additionalNote: myOrderWatch.orderDetailsState.success?.data?.additionalNote ?? '',
          )
        ],
      ).paddingAll(20.h),
    );
  }

  ///Common title tile widget
  _commonTitleValueWidget({required String title, required String value, double? bottomPadding}) {
    return CommonTitleValueWidget(
      title: title,
      value: value,
      bottomPadding: bottomPadding,
      titleFontSize: 12.sp,
      valueFontSize: 12.sp,
    );
  }
}
