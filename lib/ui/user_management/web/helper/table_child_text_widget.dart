

import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class TableChildTextWidget extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final TextStyle? textStyle;
  final TextDecoration? textDecoration;
  const TableChildTextWidget({super.key, required this.text,this.textAlign, this.textColor,this.textStyle, this.textDecoration});

  @override
  Widget build(BuildContext context) {
    return CommonText(
      title: text,
      textAlign: textAlign ?? TextAlign.left,
      textStyle: textStyle ?? TextStyles.regular.copyWith(
        fontSize: 12.sp,
        color: textColor ?? AppColors.black,
        decoration: textDecoration
      ),
    );
  }
}
