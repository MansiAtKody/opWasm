import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMyOrderWeb extends StatelessWidget with BaseStatelessWidget {
  const ShimmerMyOrderWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              color: AppColors.white),
          child: Table(
            textDirection: TextDirection.ltr,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              /// order id
              0: FlexColumnWidth(4.w),

              /// department
              1: FlexColumnWidth(3.w),

              /// order time
              2: FlexColumnWidth(4.w),

              /// total quantity
              3: FlexColumnWidth(3.w),

              /// status
              4: FlexColumnWidth(4.w),
            },
            children: [
              TableRow(children: [
                _tableChildWidget(),
                _tableChildWidget(),
                _tableChildWidget(),
                _tableChildWidget(),
                _statusButtonWidget(),
              ]),
            ],
          ).paddingOnly(left: 20.w, right: 10.w, top: 13.h, bottom: 13.h),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 22.h,
        );
      },
    );
  }


  /// Shimmer Table Child Widget
  Widget _tableChildWidget() {
    return Center(
      child: CommonShimmer(
        height: 20.h,
        width: 80.w,
      ),
    );
  }

  /// Shimmer Status Bottom Widget
  Widget _statusButtonWidget() {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: CommonButton(height: 42.h, width: 0.18.sh));
  }
}

/// Shimmer Table Header Widget (Order List Web Header Widget Shimmer)
class ShimmerOrderListTableHeaderWidget extends StatelessWidget {
  const ShimmerOrderListTableHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      textDirection: TextDirection.ltr,
      columnWidths: {
        /// order id
        0: FlexColumnWidth(4.w),

        /// department
        1: FlexColumnWidth(3.w),

        /// order time
        2: FlexColumnWidth(4.w),

        /// total quantity
        3: FlexColumnWidth(3.w),

        /// status
        4: FlexColumnWidth(4.w),

      },
      children: [
        TableRow(children: [
          _widgetTableHeader(),
          _widgetTableHeader(),
          _widgetTableHeader(),
          _widgetTableHeader(),
          _widgetTableHeader(),
        ]),
      ],
    ).paddingOnly(
      left: 20.w,
      right: 10.w,
    );
  }

  /// Widget Table Header
  Widget _widgetTableHeader() {
    return Center(
      child: CommonShimmer(
        height: 20.h,
        width: 80.w,
      ),
    );
  }
}
