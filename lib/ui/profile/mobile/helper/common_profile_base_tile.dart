import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonProfileBase extends StatelessWidget with BaseStatelessWidget {
  final String icon;
  final String title;

  const CommonProfileBase({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      children: [
        CommonSVG(
          strIcon: icon,
          height: 44.h,
          width: 44.w,
        ).paddingOnly(right: 16.w),
        CommonText(
          title: title,
          textStyle: TextStyles.regular.copyWith(
            fontSize: 14.sp,
            color: AppColors.black171717,
          ),
        ),
        const Spacer(),
       const CommonSVG(
          strIcon: AppAssets.svgRightArrow,
        ),
      ],
    );
  }
}
