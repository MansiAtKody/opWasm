import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class AppbarBottomWidgetSendServiceDetailsMobile extends StatelessWidget with BaseStatelessWidget {
  final ProfileModel profileModel;
  const AppbarBottomWidgetSendServiceDetailsMobile({super.key, required this.profileModel});

  @override
  Widget buildPage(BuildContext context) {
    return SlideLeftTransition(
      delay: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.white.withOpacity(0.08),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CacheImage(
                  imageURL: profileModel.imageUrl,
                  height: 67.h,
                  width: 67.h,
                  bottomRightRadius: 65.r,
                  bottomLeftRadius: 65.r,
                  topLeftRadius: 65.r,
                  topRightRadius: 65.r,
                ).paddingSymmetric(horizontal: 20.w, vertical: 25.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      title: profileModel.name,
                      textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.white),
                    ).paddingOnly(bottom: 4.h),
                    CommonText(
                      title: profileModel.department,
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ).paddingOnly(top: 20.h, bottom: 10.h),
    );
  }
}
