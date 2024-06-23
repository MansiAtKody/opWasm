import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';

class CommonCupertinoSwitch extends StatelessWidget with BaseStatelessWidget {
  const CommonCupertinoSwitch({super.key, required this.switchValue,required this.onChanged, this.height, this.width });

  /// Switch Value
  final bool switchValue;
  /// On changed switch value
  final ValueChanged<bool> onChanged;

  final double? height;
  final double? width;

  @override
  Widget buildPage(BuildContext context) {
    return SizedBox(
      height:height?? 22.h,
      width: width??40.w,
      child: FittedBox(
        fit: BoxFit.contain,
        child: CupertinoSwitch(
            value: switchValue,
            activeColor: AppColors.green35C658,
          trackColor: AppColors.black333333,
            onChanged: onChanged,
        ),
      ),
    );
  }
}
