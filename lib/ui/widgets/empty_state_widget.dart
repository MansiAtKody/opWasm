import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class EmptyStateWidget extends StatelessWidget with BaseStatelessWidget {
  // final EmptyState emptyStateFor;
  final Widget? icon;
  final String? title;
  final String? subTitle;
  final int? titleMaxLines;
  final Color? titleColor;
  final Color? subTitleColor;

  const EmptyStateWidget({
    Key? key,
    // required this.emptyStateFor,
    this.icon,
    this.title,
    this.subTitle,
    this.titleColor,
    this.subTitleColor, this.titleMaxLines,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideUpTransition(
              delay: 300,
              child: icon ??
                  CommonSVG(
                    strIcon: AppAssets.svgNoServices,
                    width: 228.h,
                    height: 228.h,
                  ).paddingOnly(
                    bottom: 25.h,
                  ),
            ),
            SizedBox(height: 10.h),
            CommonText(
              title: title ?? LocalizationStrings.keyNoDataFound.localized,
              textAlign: TextAlign.center,
              maxLines: titleMaxLines,
              textStyle: TextStyles.regular.copyWith(
                fontSize: 18.sp,
                color: titleColor ?? AppColors.black171717,
              ),
            ),
            SizedBox(height: 10.h),
            CommonText(
              title: subTitle ?? '',
              maxLines: 3,
              softWrap: true,
              textAlign: TextAlign.center,
              textStyle: TextStyles.regular.copyWith(
                color: subTitleColor ?? AppColors.grey7E7E7E,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// enum EmptyState { noInternet, somethingWentWrong, noData, noNotification }

/**/
