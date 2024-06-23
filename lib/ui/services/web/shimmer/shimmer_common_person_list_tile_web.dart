import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCommonPersonListTileWeb extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerCommonPersonListTileWeb({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: CommonShimmer(
              height: context.width * 0.03,
              width: context.width * 0.03,
            ),
          ),
          SizedBox(width: context.width * 0.01),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonShimmer(
                height: 15.h,
                width: context.width * 0.05,
              ).paddingOnly(bottom: 10.h),
              CommonShimmer(
                height: 15.h,
                width: context.width * 0.07,
              )
            ],
          ),
          const Spacer(),
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: const CommonSVG(
              strIcon: AppAssets.svgRightArrow,
            ),
          )
        ],
      ),
    );
  }
}
