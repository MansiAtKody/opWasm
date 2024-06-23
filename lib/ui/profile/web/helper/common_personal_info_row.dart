import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';


///Common Personal Information Tile
class CommonPersonalInfoRow extends StatelessWidget with BaseStatelessWidget{
  const CommonPersonalInfoRow({
    super.key,
    required this.svgAsset,
    required this.label,
    required this.value,
  });

  final String svgAsset;
  final String label;
  final String value;

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CommonSVG(strIcon: svgAsset),
            SizedBox(
              width: 10.w,
            ),
            Text(
              label,
              style: TextStyles.regular.copyWith(
                color: AppColors.grey8F8F8F,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyles.medium.copyWith(
            color: AppColors.black272727,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}