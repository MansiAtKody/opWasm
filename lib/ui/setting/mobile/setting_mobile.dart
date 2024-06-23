import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/setting/mobile/helper/bottom_buttons_widget.dart';
import 'package:kody_operator/ui/setting/mobile/helper/center_emergency_button.dart';
import 'package:kody_operator/ui/setting/mobile/helper/shimmer_setting_mobile.dart';
import 'package:kody_operator/ui/setting/mobile/helper/top_buttons_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/framework/controller/setting/setting_controller.dart';

class SettingMobile extends ConsumerStatefulWidget {
  const SettingMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingMobile> createState() => _SettingMobileState();
}

class _SettingMobileState extends ConsumerState<SettingMobile>  with BaseConsumerStatefulWidget{

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final settingWatch = ref.read(settingController);
      settingWatch.disposeController(isNotify : true);
      Future.delayed(const Duration(seconds: 3),(){
        settingWatch.updateLoadingStatus(false);
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
    final settingWatch = ref.watch(settingController);
    return Scaffold(
      body: settingWatch.isLoading ? const ShimmerSettingMobile() : _bodyWidget(),
      appBar: CommonAppBar(
        title: LocalizationStrings.keyDasherSetting.localized,
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return CommonWhiteBackground(
      height: context.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ///top Buttons
             const TopButtonsWidget().paddingOnly(bottom: 40.h,top: 15.h),

              /// Center Emergency buttons
              const CenterEmergencyButton().paddingOnly(bottom: 40.h),

              ///Bottom Buttons
              const BottomButtonsWidget()
            ],
          ).paddingOnly(left: 20.w,right: 20.w,top: 10.h),
        )
    );
  }


}
