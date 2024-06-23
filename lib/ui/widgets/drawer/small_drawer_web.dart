import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/login_controller.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/repository/home/home_menu_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/hover_animation.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/swipe_detector.dart';

class SmallDrawerWeb extends StatelessWidget with BaseStatelessWidget {
  const SmallDrawerWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final drawerWatch = ref.watch(drawerController);
        final loginWatch = ref.watch(loginController);
        return SwipeDetector(
          onSwipeDetected: (swipeDirection) {
            if (swipeDirection == SwipeDetectedDirection.right) {
              drawerWatch.hideSideMenu();
            }
          },
          child: Column(
            children: [
              const CommonSVG(strIcon: AppAssets.svgDasherLatter),
              SizedBox(height: 40.h),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: drawerWatch.homeMenuList.length,
                  itemBuilder: (BuildContext context, int menuIndex) {
                    HomeMenuOperator screen = drawerWatch.homeMenuList[menuIndex];
                    return HoverAnimation(
                      transformSize: (drawerWatch.selectedScreen?.parentScreen == screen.parentScreen) ? 1.00 : 1.1,
                      child: Transform.scale(
                        scale: (drawerWatch.selectedScreen?.parentScreen == screen.parentScreen) ? 1.1 : 1.00,
                        child: InkWell(
                          onDoubleTap: (){
                            drawerWatch.hideSideMenu();
                          },
                          onTap: () {
                            drawerWatch.updateSelectedScreen(screen.screenName ?? ScreenName.dashboard);
                            drawerWatch.expandingList(menuIndex);
                            ref.read(navigationStackProvider).pushRemove(screen.item);
                          },
                          child: CommonSVG(
                            strIcon: screen.strIcon ?? '',
                            svgColor: (drawerWatch.selectedScreen?.parentScreen == screen.parentScreen) ? AppColors.blue009AF1 : AppColors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 20.h,
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
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
                child: const CommonSVG(
                  strIcon: AppAssets.svgLogout,
                  svgColor: AppColors.white,
                ).paddingOnly(left: 23.w, right: 10.w),
              ),
              SizedBox(height: context.height * 0.1),
            ],
          ).paddingOnly(left: 15.w, top: 40.h),
        );
      },
    );
  }
}
