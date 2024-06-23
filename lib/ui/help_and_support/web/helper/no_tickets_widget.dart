import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';


/// Empty State Widget for Help and Support
class NoTicketsAvailable extends StatelessWidget with BaseStatelessWidget{
  const NoTicketsAvailable({
    super.key,
  });


  @override
  Widget buildPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: context.height * 0.5,
          child: const CommonSVG(
            strIcon: AppAssets.svgHelpAndSupportBg,
            boxFit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        Text(
          LocalizationStrings.keyNoDataFound.localized,
          style: TextStyles.regular.copyWith(
            fontSize: 18.sp,
            color: AppColors.grey7E7E7E,
          ),
        ).paddingOnly(bottom: 16.h),
        Text(
          LocalizationStrings.keyYouDontHaveAnyTicketsAvailable.localized,
          style: TextStyles.regular.copyWith(
            fontSize: 16.sp,
            color: AppColors.grey7E7E7E,
          ),
        ),
      ],
    );
  }
}
