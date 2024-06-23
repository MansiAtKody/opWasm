// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/flutter_svg.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CommonSVG extends StatelessWidget with BaseStatelessWidget{
  final String strIcon;
  final ColorFilter? colorFilter;
  final Color? svgColor;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const CommonSVG(
      {Key? key,
      required this.strIcon,
      this.svgColor,
      this.height,
      this.width,
      this.boxFit,
      this.colorFilter})
      : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return SvgPicture.asset(
      strIcon,
      colorFilter: colorFilter,
      color: svgColor,
      height: height,
      width: width,
      fit: boxFit ?? BoxFit.contain,
    );
  }
}
