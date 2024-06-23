import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kody_operator/framework/controller/cms/cms_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/datetime_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class CommonCMSDialog extends ConsumerStatefulWidget {
  const CommonCMSDialog({
    super.key,
    required this.title,
    this.lastUpdated,
  });

  final String title;
  final DateTime? lastUpdated;

  @override
  ConsumerState<CommonCMSDialog> createState() =>
      _CommonPrivacyPolicyDialogState();
}

class _CommonPrivacyPolicyDialogState extends ConsumerState<CommonCMSDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cmsWatch = ref.watch(cmsController);
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30.r),
          color: AppColors.white,
        ),
        width: context.width * 0.6,
        height: context.height * 0.7,
        child: cmsWatch.cmsState.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : cmsWatch.cmsState.success?.data == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            title: widget.title,
                            textStyle: TextStyles.regular.copyWith(
                              fontSize: 24.sp,
                              color: AppColors.black171717,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const CommonSVG(strIcon: AppAssets.svgCrossWithBg).paddingAll(5.r),
                          ).paddingOnly(right: 10.w, top: 10.h),
                        ],
                      ),
                      Expanded(
                        child: EmptyStateWidget(
                          title: cmsWatch.messageDisplayed.trim() == ''
                              ? LocalizationStrings.keyNoDataFound
                              : cmsWatch.messageDisplayed.replaceUnderscoresWithSpaces,
                          icon: SizedBox(
                            height: context.height * 0.3,
                            width: context.height * 0.3,
                            child: const CommonSVG(
                              strIcon: AppAssets.svgNoData,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 30.h, horizontal: 30.w)
                : Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyles.regular.copyWith(
                                      fontSize: 24.sp,
                                      color: AppColors.black171717,
                                    ),
                                  ),
                                  Text(
                                    (widget.lastUpdated?.dateOnly == null) ? ''
                                        : '${LocalizationStrings.keyLastUpdated.localized}${widget.lastUpdated?.dateOnly}',
                                    style: TextStyles.regular.copyWith(
                                      color: AppColors.blue009AF1,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5.w),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CommonSVG(strIcon: AppAssets.svgCrossWithBg).paddingAll(5.r),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        flex: 7,
                        child: HtmlWidget(
                          cmsWatch.cmsState.success?.status == ApiEndPoints.apiStatus_200
                              ? cmsWatch.cmsState.success?.data?.fieldValue.toString() ?? ''
                              : cmsWatch.cmsState.success?.data?.fieldValue.toString().replaceUnderscoresWithSpaces ?? '',
                        ),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 30.h, horizontal: 30.w),
      ),
    );
  }
}
