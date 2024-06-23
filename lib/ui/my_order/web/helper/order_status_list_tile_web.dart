
import 'package:kody_operator/framework/repository/order/model/order_status_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/dashedline_vertical_painter.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderStatusListTileWeb extends StatelessWidget with BaseStatelessWidget {
  final OrderStatusModel orderStatusModel;
  final int index;
  final int orderStatusListLength;
  final double? statusFontSize;
  final double? descFontSize;
  final double? bottomPaddingFromDescWidget;
  final double? leftPaddingFromTimeLineWidget;

  const OrderStatusListTileWeb({super.key, required this.orderStatusModel, required this.index, required this.orderStatusListLength, this.statusFontSize, this.descFontSize, this.bottomPaddingFromDescWidget, this.leftPaddingFromTimeLineWidget});

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// indicator, dash
        _timeLineWidget(),
        const SizedBox().paddingOnly(left: leftPaddingFromTimeLineWidget ?? 12.w),

        /// status name, desc
        _statusDescWidget(),
      ],
    );
  }

  ///Show Widget according to status
  _widgetIndicator() {
    return SizedBox(
      width: 31.h,
      child: index == 0 ? _widgetActiveIndicator() : _widgetUnActiveIndicator(),
    );
  }

  ///Deactive icon widget
  _widgetUnActiveIndicator() {
    return Container(
      height: 13.h,
      width: 13.h,
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary2.withOpacity(0.1)),
    );
  }

  ///Active icon widget
  _widgetActiveIndicator() {
    return Container(
      height: 31.h,
      width: 31.h,
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary2.withOpacity(0.1)),
      alignment: Alignment.center,
      child: Container(
        height: 13.h,
        width: 13.h,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary2),
      ),
    );
  }

  ///Indicator and dashed line widget
  _timeLineWidget() {
    return Column(
      children: [
        /// indicator
        _widgetIndicator(),

        /// dash
        Visibility(
          visible: index < orderStatusListLength - 1,
          child: CustomPaint(painter: DashedLineVerticalPainter()),
        )
      ],
    );
  }

  ///Description widget
  _statusDescWidget() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            title: orderStatusModel.status,
            fontSize: statusFontSize,
            clrfont: index == 0 ? AppColors.primary2 : AppColors.primary,
          ),
          SizedBox(height: 5.h),
          CommonText(
            title: orderStatusModel.description,
            clrfont: AppColors.grey7E7E7E,
            fontSize: descFontSize ?? 12.sp,
            maxLines: 3,
          ).paddingOnly(bottom: bottomPaddingFromDescWidget ?? 0),
          SizedBox(height: 5.h),
        ],
      ).paddingOnly(bottom: index < orderStatusListLength - 1 ? 30.h : 0),
    );
  }
}
