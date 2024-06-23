import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/setting/setting_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/setting/web/helper/setting_center_widget.dart';
import 'package:kody_operator/ui/setting/web/shimmer/shimmer_setting_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_top_back_widget.dart';

class SettingWeb extends ConsumerStatefulWidget {
  const SettingWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingWeb> createState() => _SettingWebState();
}

class _SettingWebState extends ConsumerState<SettingWeb>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final settingWatch = ref.read(settingController);
      settingWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(seconds: 3), () {
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
    return settingWatch.isLoading ? const ShimmerSettingWeb() : _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Column(
      children: [
        ///Top Back and title widget
        CommonBackTopWidget(
          title: LocalizationStrings.keyDasherSetting.localized,
          onTap: () {
            ref.read(navigationStackProvider).pop();
          },
        ).paddingOnly(bottom: 30.h),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.white),
            child: const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Center Widget
                  SettingCenterWidget(),
                ],
              ),
            ),
          ).paddingOnly(bottom: 38.h),
        ),
      ],
    ).paddingOnly(top: 38.h, left: 38.w, right: 38.w);
  }
}
