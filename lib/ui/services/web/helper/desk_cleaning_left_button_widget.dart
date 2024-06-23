import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/services/desk_cleaning_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/services/web/helper/voice_template_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';

class DeskCleaningLeftButtonWidget extends ConsumerWidget with BaseConsumerWidget{
  const DeskCleaningLeftButtonWidget({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final deskCleaningWatch = ref.watch(deskCleaningController);
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///Default Path
          CommonButton(
            height: 123.h,
            width: 407.w,
            onTap: () {
              deskCleaningWatch.updateButtonText(text: LocalizationStrings.keyDefaultPath);
            },
            backgroundColor: deskCleaningWatch.buttonText != LocalizationStrings.keyDefaultPath ? AppColors.grey33000000 : AppColors.white,
            buttonText: LocalizationStrings.keyDefaultPath,
            buttonTextStyle: TextStyles.regular.copyWith(
              fontSize: 25.sp,
              color: deskCleaningWatch.buttonText != LocalizationStrings.keyDefaultPath ? AppColors.white : AppColors.grey33000000,
            ),
          ).paddingOnly(bottom: 40.h),

          ///Custom Path Button
          CommonButton(
            height: 123.h,
            width: 407.w,
            onTap: () {
              deskCleaningWatch.updateButtonText(text: LocalizationStrings.keyCustomPath);
              },
            backgroundColor: deskCleaningWatch.buttonText != LocalizationStrings.keyCustomPath ? AppColors.grey33000000 : AppColors.white,
            buttonText: LocalizationStrings.keyCustomPath,
            buttonTextStyle: TextStyles.regular.copyWith(
              fontSize: 25.sp,
              color: deskCleaningWatch.buttonText != LocalizationStrings.keyCustomPath ? AppColors.white : AppColors.grey33000000,
            ),
          ).paddingOnly(bottom: 40.h),

          /// Voice Template Button
          if(deskCleaningWatch.buttonText == LocalizationStrings.keyDefaultPath || deskCleaningWatch.buttonText == LocalizationStrings.keyCustomPath)
            CommonButton(
            height: 123.h,
            width: 407.w,
            onTap: () {
              /// Voice templates Dialogue
              showDialog(
                barrierColor: AppColors.black,
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: AppColors.white,
                    insetPadding: EdgeInsets.all(20.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          height: MediaQuery.sizeOf(context).width * 0.5,
                          child: const VoiceTemplateWidget()),
                    ),
                  );
                },
              );},
            backgroundColor: AppColors.grey33000000,
            buttonText: LocalizationStrings.keyVoiceTemplates,
            buttonTextStyle: TextStyles.regular.copyWith(
              fontSize: 25.sp,
              color: AppColors.white,
            ),
          ).paddingOnly(bottom: 40.h)
        ],
      );
  }
}
