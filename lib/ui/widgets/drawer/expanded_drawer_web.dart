import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/login_controller.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/repository/home/home_menu_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/hover_animation.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/swipe_detector.dart';

class ExpandedDrawerWeb extends StatefulWidget {
  const ExpandedDrawerWeb({super.key});

  @override
  State<ExpandedDrawerWeb> createState() => _ExpandedDrawerWebState();
}

class _ExpandedDrawerWebState extends State<ExpandedDrawerWeb> with BaseStatefulWidget, TickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> _runExpandCheck(bool isExpand) async {
    if (isExpand) {
      await expandController.forward();
    } else {
      await expandController.reverse();
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final drawerWatch = ref.watch(drawerController);
        final loginWatch = ref.watch(loginController);
        return SwipeDetector(
          onSwipeDetected: (swipeDirection) {
            if (swipeDirection == SwipeDetectedDirection.left) {
              drawerWatch.hideSideMenu();
            }
          },
          child: Column(
            children: [
              const CommonSVG(strIcon: AppAssets.svgDasher),
              SizedBox(height: 40.h),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: drawerWatch.homeMenuList.length,
                  itemBuilder: (BuildContext context, int menuIndex) {
                    HomeMenuOperator screen = drawerWatch.homeMenuList[menuIndex];
                    return InkWell(
                      onDoubleTap: () {
                        drawerWatch.hideSideMenu();
                      },
                      onTap: () {
                        drawerWatch.updateSelectedScreen(screen.screenName ?? ScreenName.dashboard);
                        drawerWatch.expandingList(menuIndex);
                        ref.read(navigationStackProvider).pushAndRemoveAll(screen.item);
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: (drawerWatch.selectedScreen?.parentScreen == screen.parentScreen) ? AppColors.black232222 : AppColors.black,
                              borderRadius: BorderRadius.circular(54.r),
                            ),
                            child: HoverAnimation(
                              transformSize: (drawerWatch.selectedScreen?.parentScreen == screen.parentScreen) ? 1.00 : 1.05,
                              child: Transform.scale(
                                scale: (drawerWatch.selectedScreen?.parentScreen == screen.parentScreen) ? 1.05 : 1,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonSVG(
                                      strIcon: drawerWatch.homeMenuList[menuIndex].strIcon ?? '',
                                      svgColor: (drawerWatch.selectedScreen?.parentScreen == screen.parentScreen) ? AppColors.blue009AF1 : AppColors.white,
                                      boxFit: BoxFit.scaleDown,
                                    ).paddingOnly(right: 10.w, left: 23.w),
                                    Expanded(
                                      child: CommonText(
                                        title: drawerWatch.homeMenuList[menuIndex].menuName,
                                        textStyle: TextStyles.regular.copyWith(fontSize: 13.sp, color: (drawerWatch.selectedScreen?.parentScreen == screen.parentScreen) ? AppColors.blue009AF1 : AppColors.white),
                                      ),
                                    ),
                                    if (drawerWatch.homeMenuList[menuIndex].dropDownList != null)
                                      InkWell(
                                        onTap: () {
                                          if (drawerWatch.homeMenuList[menuIndex].isExpanded == false) {
                                            drawerWatch.expandingList(menuIndex);
                                            _runExpandCheck(true);
                                          } else {
                                            _runExpandCheck(false).then(
                                              (value) {
                                                drawerWatch.expandingList(menuIndex);
                                              },
                                            );
                                          }
                                        },
                                        child: CommonSVG(
                                          strIcon: screen.isExpanded ? AppAssets.svgArrowUp : AppAssets.svgDownArrow,
                                          boxFit: BoxFit.scaleDown,
                                          svgColor: (drawerWatch.selectedScreen?.parentScreen == screen.parentScreen) ? AppColors.blue009AF1 : AppColors.white,
                                        ).paddingOnly(right: 13.w),
                                      )
                                    else
                                      Container()
                                  ],
                                ).paddingSymmetric(vertical: 10.h),
                              ),
                            ),
                          ),
                          drawerWatch.homeMenuList[menuIndex].isExpanded
                              ? SizeTransition(
                                  axisAlignment: 1.0,
                                  sizeFactor: animation,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: drawerWatch.homeMenuList[menuIndex].dropDownList?.length ?? 0,
                                    itemBuilder: (BuildContext context, int index) {
                                      return HoverAnimation(
                                        transformSize: 1.05,
                                        child: InkWell(
                                          onTap: () {
                                          drawerWatch.updateSelectedScreen(screen.screenName ?? ScreenName.dashboard);
                                        ref.read(navigationStackProvider).pushAndRemoveAll(drawerWatch.selectedScreen?.dropDownList?[index].item ?? const NavigationStackItem.error());
                                      },child: CommonText(
                                            title: drawerWatch.homeMenuList[menuIndex].dropDownList?[index].title ?? '',
                                            textOverflow: TextOverflow.ellipsis,
                                            textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white.withOpacity(0.6)),
                                          ).paddingOnly(
                                            left: 15.w,
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return SizedBox(height: 20.h);
                                    },
                                  ).paddingOnly(bottom: 20.h))
                              : const Offstage(),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 8.h,
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),

              /// Log Out Button
              InkWell(
                onTap: () {
                  showConfirmationDialogWeb(
                    context: context,
                    title: LocalizationStrings.keyAreYouSure.localized,
                    message: LocalizationStrings.keyLogoutConfirmationMessage.localized,
                    titleFontSize: 20.sp,
                    messageFontSize: 16.sp,
                    dialogWidth: MediaQuery.sizeOf(context).width * 0.35,
                    didTakeAction: (isPositive) {
                      if (isPositive) {
                        Session.sessionLogout(ref);
                        loginWatch.emailController.text='';
                        loginWatch.passwordController.text='';
                      }
                    },
                  );
                },
                child: Row(
                  children: [
                    const CommonSVG(
                      strIcon: AppAssets.svgLogout,
                      svgColor: AppColors.white,
                    ).paddingOnly(left: 23.w, right: 10.w),
                    CommonText(
                      title: LocalizationStrings.keyLogout.localized,
                      textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height * 0.1),
            ],
          ).paddingOnly(left: 15.w, top: 40.h),
        );
      },
    );
  }
}
