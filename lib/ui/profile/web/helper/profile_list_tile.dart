import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';


///Common Profile Tile
class ProfileListTile extends StatelessWidget with BaseStatelessWidget {
  const ProfileListTile({
    super.key,
    required this.svgAsset,
    required this.tileTitle,
    this.hasSuffix = true,
    this.isSelected = false,
  });

  final String svgAsset;
  final String tileTitle;
  final bool hasSuffix;
  final bool isSelected;

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      height: 76.h,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isSelected ? AppColors.black171717 : AppColors.lightPinkF7F7FC,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ///Prefix Icon
              CommonSVG(
                strIcon: svgAsset,
                width: 50.w,
                height: 50.w,
              ).paddingSymmetric(horizontal: 17.w, vertical: 13.h),
              ///Title
              Text(
                tileTitle,
                style: TextStyles.regular.copyWith(
                  fontSize: 16.sp,
                  color: isSelected ? Colors.white : AppColors.black171717,
                ),
              ),
            ],
          ),
          ///Suffix Icon
          CommonSVG(
            strIcon: AppAssets.svgArrowForward,
            svgColor: isSelected ? AppColors.white : AppColors.black171717,
          ).paddingOnly(
            top: 26.h,
            bottom: 26.h,
            right: 20.w,
          )
        ],
      ),
    );
  }
}
