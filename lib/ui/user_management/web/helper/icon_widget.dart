

import 'package:flutter/material.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class IconWidget extends StatelessWidget {
  final String icon;
  final Function() onTap;
  final Alignment? alignment;
  const IconWidget({super.key,required this.icon, required this.onTap, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(alignment: alignment ?? Alignment.centerRight,
        child: InkWell(
            onTap: onTap,
            child: CommonSVG(strIcon: icon,)));
  }
}
