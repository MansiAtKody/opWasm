import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kody_operator/framework/controller/cms/cms_controller.dart';
import 'package:kody_operator/framework/controller/faq/faq_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

///FAQ Screen

class Faq extends ConsumerStatefulWidget {
  const Faq({super.key});

  @override
  ConsumerState<Faq> createState() => _FaqState();
}

class _FaqState extends ConsumerState<Faq> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final faqWatch = ref.read(faqController);
      faqWatch.disposeController(isNotify: true);
      await getCmsAPI(CMSType.faq);
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    final cmsWatch = ref.watch(cmsController);
    return (cmsWatch.cmsState.success?.status != ApiEndPoints.apiStatus_200)
        ? Container(
            decoration: BoxDecoration(
              color: AppColors.lightPinkF7F7FC,
              borderRadius: BorderRadius.circular(20.r),
              shape: BoxShape.rectangle,
            ),
          child: EmptyStateWidget(
             title: cmsWatch.messageDisplayed.trim() == '' ? LocalizationStrings.keyNoDataFound : cmsWatch.messageDisplayed,
             icon: SizedBox(
             height: context.height * 0.3,
               width: context.height * 0.3,
               child: const CommonSVG(
                 strIcon: AppAssets.svgNoData,
               ),
             ),
    ),
        )
        : FadeBoxTransition(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: AppColors.lightPinkF7F7FC,
                    borderRadius: BorderRadius.circular(20.r),
                    shape: BoxShape.rectangle,
                  ),
                  child: HtmlWidget(cmsWatch.cmsState.success?.data?.fieldValue.toString() ?? '').paddingOnly(top: 45.h, bottom: 40.h),
                ),
              );
  }

  /// Function for calling the API
  Future<void> getCmsAPI(CMSType cmsType) async {
    final cmsWatch = ref.watch(cmsController);
    await cmsWatch.getCMS(context, CMSType.faq);
  }
}
