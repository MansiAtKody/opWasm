import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonPersonListTileWeb extends StatelessWidget with BaseStatelessWidget {
  final ProfileModel? profile;
  final bool isSuffixVisible;
  final bool hasSpacer;
  final Widget? suffix;
  final double? height;
  final double? borderRadius;
  final Color? bgColor;

  const CommonPersonListTileWeb({
    Key? key,
    this.isSuffixVisible = true,
    required this.profile,
    this.suffix,
    this.height,
    this.borderRadius,
    this.hasSpacer = true,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
        color: bgColor ?? AppColors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: CacheImage(
              height: context.width * 0.03,
              width: context.width * 0.03,
              imageURL: profile?.imageUrl ?? '',
            ),
          ),
          SizedBox(width: context.width * 0.01),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                title: profile?.name ?? '',
                textStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.clr171717),
              ).paddingOnly(bottom: height ?? 10.h),
              CommonText(
                title: profile?.department ?? '',
                textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.clr171717),
              )
            ],
          ),
          hasSpacer ? const Spacer() : const Offstage(),
          isSuffixVisible
              ? suffix ??
                  const CommonSVG(
                    strIcon: AppAssets.svgRightArrow,
                  )
              : const Offstage(),
        ],
      ),
    );
  }
}
