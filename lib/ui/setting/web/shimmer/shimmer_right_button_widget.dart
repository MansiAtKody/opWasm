import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerRightButtonsWidget extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerRightButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///Speed
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonShimmer(
              height: 15.h,
              width: 50.w,
            ),
            // const Spacer(),
            Expanded(
              child: CommonShimmer(
                height: 55.h,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38.r),
                  color: AppColors.black
                ),
              ).paddingOnly(left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
            ),
          ],
        ).paddingOnly(bottom: 40.h),

        ///Light
        Row(
          children: [
            CommonShimmer(
              height: 15.h,
              width: 50.w,
            ),
            const Spacer(),
            CommonShimmer(
              height: 43.h,
              width: 72.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.r),
                  color: AppColors.black
              ),
            ),
          ],
        ).paddingOnly(bottom: 40.h),

        ///Obstacle sound
        Row(
          children: [
            CommonShimmer(
              height: 15.h,
              width: 50.w,
            ),
            const Spacer(),
            CommonShimmer(
              height: 43.h,
              width: 72.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.r),
                color: AppColors.black
              ),
            ),
          ],
        ).paddingOnly(bottom: 40.h),

        ///Sound
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [            CommonShimmer(
            height: 15.h,
            width: 50.w,
          ),
            // const Spacer(),
            Expanded(
              child: CommonShimmer(
                height: 55.h,
                width: context.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.r),
                    color: AppColors.black
                ),
              ).paddingOnly(left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
            ),
          ],
        ),
      ],
    );
  }
}
