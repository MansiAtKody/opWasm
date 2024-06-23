import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class MapMobile extends ConsumerStatefulWidget {
  const MapMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<MapMobile> createState() => _MapMobileState();
}

class _MapMobileState extends ConsumerState<MapMobile> {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final mapWatch = ref.read(mapController);
      //mapWatch.disposeController(isNotify : true);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
      title: LocalizationStrings.keyMap.localized,
      isLeadingEnable: true,
    ),
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return  CommonWhiteBackground(
      height: context.height,
      backgroundColor: AppColors.mapBgColor,
      child:Image.asset(
          AppAssets.icMap
      ).paddingSymmetric(horizontal: 20.w),
    );
  }


}
