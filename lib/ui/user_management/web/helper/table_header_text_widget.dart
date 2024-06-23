
import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class TableHeaderTextWidget extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  const TableHeaderTextWidget({super.key, required this.text,this.textAlign, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return CommonText(
      title: text,
      textAlign: textAlign ?? TextAlign.left,
      textStyle: textStyle ?? TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.grey8D8C8C),
    );
  }
}
