import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class CommonBubbleWidget extends StatelessWidget with BaseStatelessWidget {
  final bool isBubbleFromLeft;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? positionFromLeft;
  final double? positionFromRight;
  final double? positionFromTop;
  final Color? bubbleColor;
  final Widget child;

  const CommonBubbleWidget({super.key, required this.isBubbleFromLeft, this.height, required this.child, this.positionFromLeft, this.positionFromRight, this.width, this.borderRadius, this.positionFromTop, this.bubbleColor});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: height != null ? ((height ?? 0) + 0.02.sh) : null,
      width: width,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: positionFromTop ?? 0.02.sh,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color:bubbleColor ?? AppColors.white,
                borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
              ),
              child: child,
            ),
          ),
          isBubbleFromLeft
              ? Positioned(
                  left: positionFromLeft ?? 50.w,
                  child: const CommonSVG(
                    strIcon: AppAssets.svgLeftTriangle,
                  ),
                )
              : Positioned(
                  right: positionFromRight ?? 50.w,
                  child: const CommonSVG(
                    strIcon: AppAssets.svgRightTriangle,
                  ),
                )
        ],
      ),
    );
  }
}
