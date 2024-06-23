import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/login_controller.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/drawer/mobile/helper/drawer_menu_list_widget.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class DrawerMenuMobile extends ConsumerStatefulWidget {
  const DrawerMenuMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<DrawerMenuMobile> createState() => _DrawerMenuMobileState();
}

class _DrawerMenuMobileState extends ConsumerState<DrawerMenuMobile> {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final drawerMenuWatch = ref.read(drawerController);
    });
  }

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _bodyWidget(),
      bottomNavigationBar: _logoutWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final profileWatch = ref.watch(profileController);
    return ListView(
      children: [
        const CommonSVG(strIcon: AppAssets.svgAppNameBlack).paddingOnly(bottom: 30.h, top: context.height * 0.06).alignAtCenterLeft(),
        InkWell(
          onTap: () {
            final drawerWatch = ref.watch(drawerController);
            drawerWatch.updateSelectedScreen(ScreenName.profile);
            ref
                .read(navigationStackProvider)
                .pushAndRemoveAll(const NavigationStackItem.profile());
            drawerWatch.key.currentState?.closeDrawer();
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                CacheImage(
                  imageURL: profileWatch
                      .profileDetailState.success?.data?.profileImage ??
                      '',
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
                      title:
                      profileWatch.profileDetailState.success?.data?.name ?? '',
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    ).paddingOnly(bottom: 10.h),
                    CommonText(
                      title: profileWatch.profileDetailState.success?.data?.email ??
                          '',
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.grey8D8C8C,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                const CommonSVG(
                  strIcon: AppAssets.svgRightArrow,
                  svgColor: AppColors.white,
                ),
              ],
            ).paddingAll(18.h),
          ),
        ).paddingOnly(bottom: 30.h),
        const DrawerMenuListWidget(),
      ],
    ).paddingSymmetric(horizontal: 18.w);
  }



  ///Logout widget
  Widget _logoutWidget() {
    final loginWatch = ref.watch(loginController);
    return InkWell(
      onTap: () {
        showConfirmationDialog(
          context,
          LocalizationStrings.keyNo.localized,
          LocalizationStrings.keyYes.localized,
          (isPositive) {
            if (isPositive) {
              Session.sessionLogout(ref);
              loginWatch.emailController.text='';
              loginWatch.passwordController.text='';
            }
          },
          title: LocalizationStrings.keyAreYouSure.localized,
          message: LocalizationStrings.keyLogoutConfirmationMessage.localized,
          icon: AppAssets.svgLogout,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonSVG(
            strIcon: AppAssets.svgLogoutTransparent,
            svgColor: AppColors.black,
            height: 25.h,
            width: 25.h,
            boxFit: BoxFit.scaleDown,
          ).paddingOnly(right: 10.w),
          CommonText(
            title: LocalizationStrings.keyLogout.localized,
            textStyle: TextStyle(
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: TextStyles.fwRegular),
          ),
        ],
      ).paddingOnly(left: 36.w, bottom: 30.h),
    );
  }
}
