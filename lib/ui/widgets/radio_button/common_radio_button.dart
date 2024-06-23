import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class CommonRadioButton extends StatelessWidget with BaseStatelessWidget{
  const CommonRadioButton({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onTap,
    this.textStyle, this.icon, this.iconColor,
  });

  final String? groupValue;
  final String value;
  final TextStyle? textStyle;
  final GestureTapCallback? onTap;
  final String? icon;
  final Color? iconColor;

  @override
  Widget buildPage(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
               CommonSVG(strIcon: icon??AppAssets.svgVoiceMic),
              SizedBox(
                width: 15.w,
              ),
              Text(value, style: TextStyles.regular),
            ],
          ),
          CommonSVG(
            svgColor: iconColor??AppColors.black,
            strIcon: value == groupValue
                ? AppAssets.svgRadioSelected
                : AppAssets.svgRadioUnselected,
          ),
        ],
      ),
    );
  }
}