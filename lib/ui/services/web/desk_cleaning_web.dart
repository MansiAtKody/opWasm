import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/services/desk_cleaning_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/web/helper/desk_cleaning_center_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';


class DeskCleaningWeb extends ConsumerStatefulWidget {
  const DeskCleaningWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<DeskCleaningWeb> createState() => _DeskCleaningWebState();
}

class _DeskCleaningWebState extends ConsumerState<DeskCleaningWeb> with BaseConsumerStatefulWidget{

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final deskCleaningWatch = ref.watch(deskCleaningController);
      deskCleaningWatch.disposeController(isNotify : true);
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
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _topWidget().paddingOnly(bottom: 70.h),

          ///Center Widget
          const DeskCleaningCenterWidget()
        ],
      ).paddingOnly(left: 63.h,right: 63.w,bottom: 90.h,top: 90.h,),
    );
  }

  ///Top Widget
  Widget _topWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          title: LocalizationStrings.keyDeskCleaning.localized,
          textStyle: TextStyles.regular.copyWith(
            fontSize: 40.sp,
            color: AppColors.white,
          ),
        ),
        InkWell(
          onTap: (){
            ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
          },
          child: CommonSVG(
            strIcon: AppAssets.svgHome,
            height: 94.h,
            width: 94.h,
          ),
        )
      ],
    );
  }

}
