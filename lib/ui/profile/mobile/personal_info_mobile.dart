import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/profile/mobile/helper/profile_info_center_widget.dart';
import 'package:kody_operator/ui/profile/mobile/helper/profile_info_top_widget.dart';
import 'package:kody_operator/ui/profile/mobile/helper/shimmer_personal_info_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/framework/controller/profile/personal_info_controller.dart';

class PersonalInfoMobile extends ConsumerStatefulWidget {
  const PersonalInfoMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<PersonalInfoMobile> createState() => _PersonalInfoMobileState();
}

class _PersonalInfoMobileState extends ConsumerState<PersonalInfoMobile>
    with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final personalInfoWatch = ref.read(personalInfoController);
      personalInfoWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(seconds: 3), () {
        personalInfoWatch.updateLoadingStatus(false);
      });
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final personalInfoWatch = ref.watch(personalInfoController);
    return Scaffold(
      appBar: CommonAppBar(
        isLeadingEnable: true,
        title: LocalizationStrings.keyPersonalInformation.localized,
      ),
      body: CommonWhiteBackground(
        child: personalInfoWatch.isLoading
            ? const ShimmerPersonalInformationWidget()
            : _bodyWidget(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          children: [
            Column(
              children: [
                const SlideLeftTransition(
                    delay: 100, child: ProfileInfoTopWidget()),
                Divider(
                  color: AppColors.grey7E7E7E.withOpacity(0.2),
                ).paddingOnly(top: 20.h, bottom: 10.h),
                const ProfileInfoCenterWidget(),
              ],
            ).paddingOnly(left: 28.w, right: 28.w, top: 35.h),
            const Spacer(),
            SlideUpTransition(
              delay: 200,
              child: CommonButtonMobile(
                onTap: () {
                  ref
                      .read(navigationStackProvider)
                      .push(const NavigationStackItem.changePassword());
                },
                rightIcon:
                    const Icon(Icons.arrow_forward, color: AppColors.white),
                buttonText: LocalizationStrings.keyChangePassword.localized,
              ).paddingOnly(
                  left: 10.w, right: 10.w, bottom: buttonBottomPadding),
            ),
          ],
        )).paddingAll(12.r);
  }
}
