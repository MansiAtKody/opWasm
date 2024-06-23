import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerTopWidget extends StatelessWidget with BaseStatelessWidget {
  const ShimmerTopWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonShimmer(
          height: 16.h,
          width: context.width * 0.1,
        ),

        ///Search bar
        Row(
          children: [
            CommonShimmer(
              height: 57.h,
              width: context.width * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(57.r),
                  color: AppColors.black),
            ).paddingSymmetric(horizontal: 20.w),

            ///Filter popUp
            CommonShimmer(
              height: 57.h,
              width: 57.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(57.r),
                color: AppColors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
