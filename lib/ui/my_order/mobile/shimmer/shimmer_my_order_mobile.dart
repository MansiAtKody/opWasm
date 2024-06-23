import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMyOrderMobile extends StatelessWidget with BaseStatelessWidget {
  const ShimmerMyOrderMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.whiteF7F7FC,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              Column(
                children: [
                  ///Display all the items of orders
                  _commonTextWidget(context),
                  _commonTextWidget(context),
                  _commonTextWidget(context),
                  _commonTextWidget(context),
                  Divider(
                    height: 40.h,
                  ),
                ],
              ),
              _orderCardBottom(context),
            ],
          ).paddingAll(20.h),
        ).paddingOnly(bottom: 20.h, left: 20.w, right: 20.w);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 20.h);
      },
    );
  }

  /// Shimmer Order Card Bottom Widget
  Widget _orderCardBottom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CommonShimmer(height: 20.h, width: context.width * 0.1),
            SizedBox(
              width: 5.w,
            ),
            Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.white,
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 10,
                color: AppColors.primary2,
              ),
            ),
          ],
        ),
        Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: CommonButton(
            height: 40.h,
            width: context.width * 0.3,
          ),
        )
      ],
    );
  }

  /// Shimmer Common Text Widget
  Widget _commonTextWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonShimmer(height: 20.h, width: context.width * 0.2),
        CommonShimmer(height: 20.h, width: context.width * 0.45),
      ],
    ).paddingOnly(bottom: 15.h);
  }
}
