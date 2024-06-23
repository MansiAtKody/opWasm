import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonSettingBodyContainer extends StatelessWidget with BaseStatelessWidget {
  final Widget? child;
  final String text;
  final GestureTapCallback? onTap;

  const CommonSettingBodyContainer(
      {super.key,
        this.child,
        this.onTap, required this.text, });

  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: AppColors.lightPink),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(title:text, textStyle: TextStyles.regular),
           const  CommonSVG(strIcon: AppAssets.svgArrowForward)
          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
      ),
    );
  }
}
