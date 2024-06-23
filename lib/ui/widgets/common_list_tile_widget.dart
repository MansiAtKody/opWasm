import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class CommonListTile extends StatelessWidget with BaseStatelessWidget {
  const CommonListTile({
    super.key,
    required this.svgAsset,
    required this.tileTitle,
    this.hasSuffix = true,
    this.isSelected = false,
    this.tileColor,
    this.selectedTileColor, this.tileTextColor, this.selectedTileTextColor, this.suffix,
  });

  final String svgAsset;
  final String tileTitle;
  final Color? tileColor;
  final Color? selectedTileColor;
  final Color? tileTextColor;
  final Color? selectedTileTextColor;
  final Widget? suffix;
  final bool hasSuffix;
  final bool isSelected;

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      height: 76.h,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isSelected ? selectedTileColor ?? AppColors.black171717 : tileColor ?? AppColors.lightPinkF7F7FC,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CommonSVG(
                strIcon: svgAsset,
                width: 50.w,
                height: 50.w,
              ).paddingSymmetric(horizontal: 17.w, vertical: 13.h),
              Text(
                tileTitle,
                style: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: isSelected ? selectedTileTextColor ?? Colors.white : tileTextColor ?? AppColors.black171717,
                ),
              ),
            ],
          ),
          hasSuffix
              ? suffix ?? CommonSVG(
                  strIcon: AppAssets.svgArrowForward,
                  svgColor:
                      isSelected ? AppColors.white : AppColors.black171717,
                ).paddingOnly(
                  top: 26.h,
                  bottom: 26.h,
                  right: 20.w,
                )
              : const Offstage(),
        ],
      ),
    );
  }
}
