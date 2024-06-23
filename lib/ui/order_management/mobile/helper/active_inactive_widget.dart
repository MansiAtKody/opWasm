import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class UserActiveInactiveWidgetMobile extends StatelessWidget {
  final Color borderColor;
  final String title;

  const UserActiveInactiveWidgetMobile({super.key, required this.borderColor, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(21.5.r),
        color: AppColors.transparent,
        border: Border.all(color: borderColor, width: 1.w),
      ),
      child: Center(
        child: CommonText(
          title: title,
          textStyle: TextStyles.regular.copyWith(
            fontSize: 12.sp,
            color: borderColor,
          ),
        ),
      ).paddingSymmetric(vertical: 12.h, horizontal: 17.w),
    );
  }
}
