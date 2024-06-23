import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/profile/mobile/helper/common_profile_info_tile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ProfileInfoCenterWidget extends ConsumerWidget {
  const ProfileInfoCenterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final profileWatch = ref.watch(profileController);
    return Column(
      children: [
        CommonProfileInfo(
          icon: AppAssets.svgProfileUser,
          title: LocalizationStrings.keyOperatorName.localized,
          subTitle: profileWatch.profileDetailState.success?.data?.name ?? '',
          height: 27.h,
          width: 27.w,
        ).paddingOnly(bottom: 30.h),
        CommonProfileInfo(
          icon: AppAssets.svgEmailId,
          title: LocalizationStrings.keyEmailId.localized,
          subTitle: profileWatch.profileDetailState.success?.data?.email ?? '',
          maxLine: 1,
          height: 27.h,
          width: 27.w,
        ).paddingOnly(bottom: 15.h),

        /// Change Email Id
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: (){
              ref.read(navigationStackProvider).push(const NavigationStackItem.changeEmail());
            },
            child: CommonText(
              title: LocalizationStrings.keyChangeEmail.localized,
              textStyle: TextStyles.regular.copyWith(
                color: Colors.blue,
                fontSize: 16.sp,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Divider(
          color: AppColors.grey7E7E7E.withOpacity(0.2),
        ).paddingOnly(top: 18.h,bottom: 8.h),
        CommonProfileInfo(
          icon: AppAssets.svgMobileNumber,
          title: LocalizationStrings.keyMobileNumber.localized,
          subTitle: profileWatch.profileDetailState.success?.data?.contactNumber ?? '',
          height: 27.h,
          width: 27.w,
        ).paddingOnly(bottom: 15.h),

        /// Change mobile number
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: (){
              ref.read(navigationStackProvider).push(const NavigationStackItem.changeMobile());
            },
            child: CommonText(
              title: LocalizationStrings.keyChangeMobile.localized,
              textStyle: TextStyles.regular.copyWith(
                color: Colors.blue,
                fontSize: 16.sp,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
