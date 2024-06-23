import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/profile/mobile/helper/common_profile_base_tile.dart';
import 'package:kody_operator/ui/profile/mobile/helper/profile_app_bar_widget.dart';
import 'package:kody_operator/ui/profile/mobile/helper/shimmer_profile_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_sliver_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class ProfileMobile extends ConsumerStatefulWidget {
  const ProfileMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileMobile> createState() => _ProfileMobileState();
}

class _ProfileMobileState extends ConsumerState<ProfileMobile>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final profileWatch = ref.watch(profileController);
      profileWatch.disposeController(isNotify: true);
      profileWatch.getProfileDetail(context);
      //final loginWatch = ref.watch(loginController);
      //profileWatch.getProfileDetail(context, loginWatch.loginState.success?.data?.uuid ?? '');
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final profileWatch = ref.watch(profileController);
    return CommonSliverAppBar(
      title: LocalizationStrings.keyMyAccount.localized,
      isDrawerEnable: true,
      appBarWidget: profileWatch.profileDetailState.isLoading
          ? const ShimmerProfileAppBarWidget().paddingOnly(top: 70.h)
          : const ProfileAppBarWidget().paddingOnly(top: 70.h),
      expandedHeight: 294.h,
      isBorderRadiusEnable: false,
      bodyWidget: CommonWhiteBackground(
        child: profileWatch.profileDetailState.isLoading
            ? const ShimmerProfileCenterWidget()
            : _centerWidget(),
        // child:  _centerWidget(),
      ),
    );
  }

  ///Center Widget
  Widget _centerWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final profileWatch = ref.watch(profileController);
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileWatch.profileInfoTitleList.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.greyBEBEBE.withOpacity(0.3),
                      );
                    },
                    itemBuilder: (context, index) {
                      return SlideLeftTransition(
                        delay: 100,
                        child: InkWell(
                          onTap: () {
                            ref.read(navigationStackProvider).push(profileWatch.profileInfoTitleList[index].stackItem ?? const NavigationStackItem.error());
                          },
                          child: CommonProfileBase(
                            icon: profileWatch.profileInfoTitleList[index].svgAsset,
                            title: profileWatch.profileInfoTitleList[index].tileTitle,
                          ).paddingOnly(top: 20.h, bottom: 13.h),
                        ),
                      );
                    },
                  ).paddingSymmetric(horizontal: 20.w);
                },
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ).paddingOnly(left: 20.w, right: 20.w, bottom: 40.h),
        ],
      ),
    );
  }
}
