import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonPersonListTile extends StatelessWidget with BaseStatelessWidget {
  final ProfileModel profile;
  final bool isSuffixVisible;
  final Widget? suffix;
  final double? height;
  final double? borderRadius;
  final Color? backgroundColor;

  const CommonPersonListTile({
    Key? key,
    this.isSuffixVisible = true,
    required this.profile,
    this.suffix, this.height,this.borderRadius, this.backgroundColor})
      : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius?? 20.r),
        color: backgroundColor ?? AppColors.whiteF7F7FC,
      ),
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CacheImage(
            imageURL: profile.imageUrl,
            height: 67.h,
            width: 67.h,
            bottomRightRadius: 65.r,
            bottomLeftRadius: 65.r,
            topLeftRadius: 65.r,
            topRightRadius: 65.r,
          ).paddingOnly(right: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                title: profile.name,
                textStyle: TextStyles.regular.copyWith(fontSize: 16.sp),
              ).paddingOnly(bottom: height ?? 10.h),
              CommonText(
                title: profile.department,
                textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.grey7E7E7E),
              )
            ],
          ),
          const Spacer(flex: 1,),
          isSuffixVisible
              ? suffix ??
                  const CommonSVG(
                    strIcon: AppAssets.svgRightArrow,
                  )
              : const Offstage(),
        ],
      ).paddingAll(15.w),
    );
  }
}
