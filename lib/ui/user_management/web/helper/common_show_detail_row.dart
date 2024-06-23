

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonShowDetailRow extends StatelessWidget with BaseStatelessWidget{
  final String title;
  final String value;
  final Widget? widget;
  const CommonShowDetailRow({super.key, required this.title, required this.value, this.widget});

  @override
  Widget buildPage(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          title:title,
          textStyle: TextStyles.regular.copyWith(color: AppColors.clr8F8F8F,fontSize: 16.sp),
        ),
        widget!=null?
            widget??const Offstage():
        CommonText(
          title: value,
          textStyle: TextStyles.regular.copyWith(color: AppColors.clr171717,fontSize: 18.sp),
        ),
      ],
    ).paddingOnly(bottom: 15.h);
  }
}
