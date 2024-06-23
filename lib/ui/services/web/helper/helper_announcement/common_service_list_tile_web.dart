import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/hover_animation.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class CommonServiceListTileWeb extends StatelessWidget with BaseStatelessWidget {
  final String imageAsset;
  final String text;
  final TextStyle? style;
  final bool isSelected;
  final bool isSuffixEnabled;
  final void Function() onTap;

  const CommonServiceListTileWeb({
    super.key,
    required this.imageAsset,
    required this.onTap,
    required this.text,
    this.style,
    this.isSelected = false,
    this.isSuffixEnabled = true,
  });

  @override
  Widget buildPage(BuildContext context) {
    return HoverAnimation(
      transformSize: isSelected ? 1.00 : 1.05,
      child: Transform.scale(
        scale: isSelected ? 1.05 : 1,
        child: ListBounceAnimation(
          transformSize: 1.25,
          onTap: onTap,
          child: Container(
            height: 84.h,
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                      color: AppColors.clr272727,
                      width: 0.5.w,
                    )
                  : null,
              shape: BoxShape.rectangle,
              color: isSelected ? AppColors.black : AppColors.clrF7F7FC,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                CommonSVG(
                  strIcon: imageAsset,
                  width: 44.w,
                  height: 44.h,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: style ?? TextStyles.regular.copyWith(fontSize: 16.sp, color: isSelected ? AppColors.white : AppColors.black),
                  ),
                ),
                if (isSuffixEnabled) ...{
                  CommonSVG(
                    strIcon: AppAssets.svgRightArrow,
                    colorFilter: ColorFilter.mode(isSelected ? AppColors.white : AppColors.black, BlendMode.modulate),
                  ),
                }
              ],
            ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
          ).paddingOnly(left: 20.w),
        ),
      ),
    );
  }
}
