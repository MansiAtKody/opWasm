import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CommonCard extends StatelessWidget with BaseStatelessWidget {
  final double? elevation;
  final Color? shadowColor;
  final Color? color;
  final Color? borderColor;
  final Widget child;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? margin;
  final double? cornerRadius;

  const CommonCard({super.key, required this.child, this.elevation, this.shadowColor, this.shape, this.margin, this.cornerRadius, this.color, this.borderColor});

  @override
  Widget buildPage(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation ?? 4,
      shadowColor: shadowColor ?? AppColors.cardShadow.withOpacity(.1),
      shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(cornerRadius ?? 20.r), side: BorderSide(color: borderColor ?? AppColors.transparent)),
      margin: margin,
      child: child,
    );
  }
}
