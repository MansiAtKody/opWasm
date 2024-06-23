import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonProfileInfo extends StatelessWidget with BaseStatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final double? height;
  final double? width;
  final int? maxLine;

  const CommonProfileInfo({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.height,
    this.width,
    this.maxLine,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      children: [
        CommonSVG(
          strIcon: icon,
          height: height ?? 24.h,
          width: width ?? 24.h,
        ).paddingOnly(right: 12.w),
        CommonText(
          title: title,
          textStyle: TextStyles.regular.copyWith(
            fontSize: 16.sp,
            color: AppColors.grey8F8F8F,
          ),
        ),

        Expanded(
          flex: 2,
          child: CommonText(
            title: subTitle,
            textAlign: TextAlign.right,
            textStyle: TextStyles.medium.copyWith(
              fontSize: 16.sp,
              color: AppColors.black272727,
            ),
            maxLines: maxLine ?? 3,
          ),
        ),
      ],
    );
  }
}
