
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';

class CommonCheckBox extends StatelessWidget with BaseStatelessWidget {
  const CommonCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.shape,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final OutlinedBorder? shape;

  @override
  Widget buildPage(BuildContext context) {
    return Checkbox(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.r),
          ),
      activeColor: activeColor ?? AppColors.transparent,
      checkColor: checkColor ?? AppColors.black171717,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: MaterialStateBorderSide.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return BorderSide(color: AppColors.blue009AF1, width: 0.5.w);
          } else {
            return BorderSide(color: AppColors.black, width: 0.5.w);
          }
        },
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
