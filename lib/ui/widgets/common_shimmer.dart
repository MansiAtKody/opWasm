import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

/// Common Shimmer Widget
class CommonShimmer extends StatelessWidget with BaseStatelessWidget {
  const CommonShimmer(
      {super.key,
      required this.height,
      required this.width,
      this.borderRadius,
      this.decoration});

  final double height;
  final double width;
  final BorderRadiusGeometry? borderRadius;
  final Decoration? decoration;

  @override
  Widget buildPage(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.white,
      child: Container(
        height: height,
        width: width,
        decoration: decoration ??
            BoxDecoration(
              borderRadius: borderRadius,
              color: AppColors.black,
            ),
      ),
    );
  }
}
