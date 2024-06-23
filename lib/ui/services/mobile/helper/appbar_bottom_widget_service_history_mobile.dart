import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class AppbarBottomWidgetServiceHistoryMobile extends StatelessWidget
    with BaseStatelessWidget {
  final ProfileModel profileModel;

  const AppbarBottomWidgetServiceHistoryMobile(
      {super.key, required this.profileModel});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.white.withOpacity(0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CacheImage(
            imageURL: profileModel.imageUrl,
            height: 67.h,
            width: 67.h,
            bottomRightRadius: 65.r,
            bottomLeftRadius: 65.r,
            topLeftRadius: 65.r,
            topRightRadius: 65.r,
          ).paddingOnly(right: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonText(
                title: profileModel.name,
                textStyle: TextStyles.regular
                    .copyWith(fontSize: 18.sp, color: AppColors.white),
              ).paddingOnly(bottom: 10.h),
              CommonText(
                title: profileModel.department,
                textStyle: TextStyles.regular
                    .copyWith(fontSize: 14.sp, color: AppColors.white),
              ),
            ],
          ),
        ],
      ).paddingAll(20.h),
    ).paddingSymmetric(vertical: 20.h);
  }
}
