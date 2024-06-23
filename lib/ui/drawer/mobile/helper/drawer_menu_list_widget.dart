import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/repository/home/home_menu_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class DrawerMenuListWidget extends ConsumerWidget {
  const DrawerMenuListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final drawerWatch = ref.watch(drawerController);
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: drawerWatch.homeMenuList.length,
        itemBuilder: (context, menuIndex) {
          HomeMenuOperator screen = drawerWatch.homeMenuList[menuIndex];
          return InkWell(
            onTap: () {
              ///Update selected drawer
              drawerWatch.updateSelectedScreen(screen.screenName ?? ScreenName.dashboard);
              drawerWatch.expandingList(menuIndex);
              ref.read(navigationStackProvider).pushAndRemoveAll(screen.item);
              drawerWatch.key.currentState?.closeDrawer();
            },
            child: Container(
              decoration: BoxDecoration(
                color: drawerWatch.selectedScreen == screen ? AppColors.whiteF7F7FC : AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CommonSVG(
                        strIcon: drawerWatch.homeMenuList[menuIndex].strIcon ?? AppAssets.svgDashboard,
                        svgColor: drawerWatch.selectedScreen == screen ? AppColors.blue009AF1 : AppColors.black,
                        height: 25.h,
                        width: 25.h,
                        boxFit: BoxFit.scaleDown,
                      ).paddingOnly(right: 10.w),
                      CommonText(
                        title: drawerWatch.homeMenuList[menuIndex].menuName,
                        textStyle: TextStyle(fontSize: 12.sp, color: drawerWatch.selectedScreen == screen ? AppColors.blue009AF1 : AppColors.black, fontWeight: drawerWatch.selectedScreen == screen ? TextStyles.fwMedium : TextStyles.fwRegular),
                      ),
                      const Spacer(),
                      (drawerWatch.homeMenuList[menuIndex].dropDownList != null)
                          ? InkWell(
                              onTap: () {
                                drawerWatch.expandingList(menuIndex);
                              },
                              child: CommonSVG(
                                strIcon: drawerWatch.homeMenuList[menuIndex].isExpanded ? AppAssets.svgArrowUp : AppAssets.svgDownArrow,
                                height: 25.h,
                                width: 25.w,
                                svgColor: AppColors.black,
                              ).paddingOnly(right: 13.w),
                            )
                          : Container()
                    ],
                  ),

                  ///dropdown list for servicce
                  drawerWatch.homeMenuList[menuIndex].isExpanded
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: drawerWatch.homeMenuList[menuIndex].dropDownList?.length ?? 0,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 25.h,
                            );
                          },
                          itemBuilder: (context, dropDownIndex) {
                            return InkWell(
                              onTap: () {
                                drawerWatch.updateSelectedScreen(screen.screenName ?? ScreenName.dashboard);
                                ref.read(navigationStackProvider).pushAndRemoveAll(screen.item);
                                ref.read(navigationStackProvider).push(drawerWatch.homeMenuList[dropDownIndex].dropDownList?[menuIndex].item ?? const NavigationStackItem.error());
                              },
                              child: CommonText(
                                title: drawerWatch.homeMenuList[menuIndex].dropDownList?[dropDownIndex].title ?? '',
                                textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.black171717.withOpacity(0.6)),
                              ).paddingOnly(left: 27.w),
                            );
                          }).paddingOnly(top: 25.h, bottom: 5.h)
                      : Container()
                ],
              ).paddingOnly(left: 18.w, top: 20.h, bottom: 20.h),
            ),
          );
        });
  }
}
