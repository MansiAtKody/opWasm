import 'package:kody_operator/framework/controller/profile/personal_info_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/show_down_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileAppBarWidget extends ConsumerWidget with BaseConsumerWidget {
  const ProfileAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    final profileWatch = ref.watch(personalInfoController);
    final operatorDetailWatch = ref.watch(profileController);

    return Column(
      children: [
          ShowDownTransition(
            delay: 100,
            child: SizedBox(
              child: profileWatch.profileImageRemoved
                  ? SizedBox.fromSize(
                size: Size.fromRadius(25.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: CommonSVG(
                    strIcon: AppAssets.svgProfile,
                    height: 20.h,
                    width: 20.h,
                  ),
                ),
              ).paddingOnly(bottom: 30.h, top: 40.h)
                  : profileWatch.profileImage == null
                  ? CacheImage(
                imageURL: operatorDetailWatch.profileDetailState.success?.data?.profileImage ?? '',
                height: 95.h,
                width: 95.h,
                bottomRightRadius: 93.r,
                bottomLeftRadius: 93.r,
                topLeftRadius: 93.r,
                topRightRadius: 93.r,
              ).paddingOnly(bottom: 30.h)
                  : SizedBox.fromSize(
                size: Size.fromRadius(51.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(51.r),
                  child: Image.memory(
                    profileWatch.profileImage!,
                    fit: BoxFit.fill,
                    width: 95.w,
                    height: 95.h,
                  ),
                ),
              ).paddingOnly(bottom: 30.h),
            ),
          ),

        SizedBox(height: 10.h),
            SlideLeftTransition(
              delay: 100,
              child: CommonText(
              title: operatorDetailWatch.profileDetailState.success?.data?.name ?? '',
              textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.white),
          ).paddingOnly(bottom: 5.h),
            ),

         SlideLeftTransition(
           delay: 100,
           child: CommonText(
              title: operatorDetailWatch.profileDetailState.success?.data?.email ?? '',
              textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.white.withOpacity(0.7)),
            ),
         ),
      ],
    ).paddingOnly(bottom: 30.h);
  }
}
