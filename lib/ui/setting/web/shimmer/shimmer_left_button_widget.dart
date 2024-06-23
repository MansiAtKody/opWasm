import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerLeftButtonsWidget extends ConsumerWidget with BaseConsumerWidget {
  const ShimmerLeftButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///Pause and return
        CommonShimmer(
          height: 75.h,
          width: context.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.r),
              color: AppColors.black
          ),
        ).paddingOnly(bottom: 30.h, top: 70.h),

        ///Go to charging pile
        CommonShimmer(
          height: 75.h,
          width: context.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.r),
              color: AppColors.black
          ),
        ).paddingOnly(bottom: 30.h),

        ///Intermission
        CommonShimmer(
          height: 75.h,
          width: context.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.r),
              color: AppColors.black
          ),
        ).paddingOnly(bottom: 30.h),

        ///Map
        CommonShimmer(
          height: 75.h,
          width: context.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.r),
              color: AppColors.black
          ),
        ).paddingOnly(bottom: 40.h)
      ],
    );
  }
}
