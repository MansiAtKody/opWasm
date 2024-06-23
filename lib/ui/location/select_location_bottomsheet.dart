import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/location/select_location_dialog_controller.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_bottom_sheet.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

void openSelectLocationPointBottomSheet({
  required BuildContext context,
  String? buttonText,
  void Function()? onButtonPressed,
}) {
  showCommonModalBottomSheet(
    context: context,
    child: Consumer(
      builder: (context, ref, child) {
        final selectLocationWatch = ref.watch(selectLocationDialogController);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonText(
              title: selectLocationWatch.tempSelectedLocation?.name ?? '',
              textStyle: TextStyles.medium.copyWith(
                fontSize: 18.sp,
                color: AppColors.primary2,
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
            /// location list
            Container(
              constraints: BoxConstraints(
                maxHeight: context.height * 0.5,
                minHeight: context.height * 0.2,
              ),
              child: selectLocationWatch.locationPointListState.success?.data?.isNotEmpty ?? false ? ListView(
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(
                      /// Length of List
                      selectLocationWatch.locationPointListState.success?.data?.length ?? 0, (index) {
                        return InkWell(
                          onTap: () {
                            selectLocationWatch.updateTempSelectedLocationPoint(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: (selectLocationWatch.tempSelectedLocationPoint?.locationUuid == selectLocationWatch.tempSelectedLocation?.uuid
                                  && selectLocationWatch.tempSelectedLocationPoint?.uuid == selectLocationWatch.locationPointListState.success?.data?[index].uuid)
                                  ? AppColors.blue009AF1 : AppColors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: CommonText(
                              title: selectLocationWatch.locationPointListState.success?.data?[index].name ?? '01',
                              textStyle: TextStyles.regular.copyWith(
                                color: (selectLocationWatch.tempSelectedLocationPoint?.locationUuid == selectLocationWatch.tempSelectedLocation?.uuid && selectLocationWatch.tempSelectedLocationPoint?.uuid == selectLocationWatch.locationPointListState.success?.data?[index].uuid)
                                    ? AppColors.white : AppColors.black171717.withOpacity(0.8),
                                fontSize: 17.sp,
                              ),
                            ).paddingSymmetric(horizontal: 10.w, vertical: 10.h),
                          ),
                        ).paddingOnly(right: 10.w, bottom: 10.w);
                      },
                    ),
                  ).paddingSymmetric(vertical: 30.h),
                ],
              ) :
              selectLocationWatch.locationPointListState.isLoading ?
              const DialogProgressBar(isLoading: true) :
              EmptyStateWidget(title: LocalizationStrings.keyNoLocationPoints.localized,
                subTitle: LocalizationStrings.keyNoLocationPointsMsg.localized,) ),
            SizedBox(
              height: 10.h,
            ),

            /// Select location button
            Align(
              alignment: Alignment.center,
              child: CommonButton(
                buttonText: buttonText ?? LocalizationStrings.keySave.localized,
                rightIcon:  CommonSVG(
                  strIcon: AppAssets.svgArrowRight,
                  svgColor:  selectLocationWatch.tempSelectedLocation != null && selectLocationWatch.tempSelectedLocationPoint != null?AppColors.white: AppColors.textFieldLabelColor.withOpacity(0.3),
                ),
                buttonEnabledColor: AppColors.blue009AF1,
                buttonDisabledColor: AppColors.textFieldLabelColor.withOpacity(0.3),
                onTap: () {
                  selectLocationWatch.selectLocation();
                  Navigator.pop(context);
                  if (onButtonPressed != null) {
                    onButtonPressed.call();
                  } else {
                    ref.read(navigationStackProvider).pop();
                  }
                },
                buttonTextColor: selectLocationWatch.tempSelectedLocation != null && selectLocationWatch.tempSelectedLocationPoint != null?AppColors.white: AppColors.textFieldLabelColor.withOpacity(0.3),
                isButtonEnabled: selectLocationWatch.tempSelectedLocation != null && selectLocationWatch.tempSelectedLocationPoint != null,
              ),
            )
          ],
        ).paddingAll(20.h);
      },
    ),
  );
}
