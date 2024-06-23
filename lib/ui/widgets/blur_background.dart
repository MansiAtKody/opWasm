import 'dart:ui';

import 'package:kody_operator/ui/utils/theme/theme.dart';

import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class BlurBackground extends StatelessWidget with BaseStatelessWidget {
  final bool blurBackground;
  final Widget child;
  final GestureTapCallback? onTapOutside;
  final Color? blurColor;

  const BlurBackground({super.key, required this.blurBackground, required this.child, this.blurColor, this.onTapOutside});

  @override
  Widget buildPage(BuildContext context) {
    return Material(
      color: blurBackground ? blurColor?.withOpacity(0.5) ?? AppColors.grey7E7E7E.withOpacity(0.2) : AppColors.transparent,
      child: InkWell(
        onTap: onTapOutside,
        child: AbsorbPointer(
          absorbing: blurBackground,
          child: ImageFiltered(
            imageFilter: blurBackground ? ImageFilter.blur(sigmaX: 10, sigmaY: 10, tileMode: TileMode.mirror) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: child,
          ),
        ),
      ),
    );
  }
}
