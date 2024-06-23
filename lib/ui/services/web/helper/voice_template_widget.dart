import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/services/desk_cleaning_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/radio_button/common_radio_button.dart';

class VoiceTemplateWidget extends ConsumerWidget with BaseConsumerWidget{
  const VoiceTemplateWidget({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final deskCleaningWatch = ref.watch(deskCleaningController);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 21.w, right: 21.w, top: 35.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r), color: AppColors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                title: LocalizationStrings.keyVoiceTemplates.localized,
                textStyle: TextStyles.regular
                    .copyWith(fontSize: 40.sp, color: AppColors.black),
              ),
              CommonButton(
                onTap: () {
                  deskCleaningWatch.clearSelectedTask(value: deskCleaningWatch.selectedTask);
                },
                height: 58.h,
                width: 151.w,
                buttonText: LocalizationStrings.keyClearAll.localized,
                buttonTextStyle: TextStyles.regular
                    .copyWith(fontSize: 18.sp, color: AppColors.white),
                backgroundColor: AppColors.black,
              )
            ],
          ).paddingOnly(bottom: 40.h),
          Expanded(
            child: ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 763.w,
                    height: 110.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.whiteFFF9F9F9),
                    child: CommonRadioButton(
                      value: deskCleaningWatch.taskList[index],
                      groupValue: deskCleaningWatch.selectedTask,
                      onTap: () {
                        deskCleaningWatch.updateTask(
                          list: deskCleaningWatch.taskList[index],
                        );
                      },
                    ).paddingSymmetric(horizontal: 40.w),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox().paddingOnly(bottom: 20.h),
                itemCount: deskCleaningWatch.taskList.length),
          ),

          /// Bottom Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Go Button
              CommonButton(
                onTap: () {
                  ref.read(navigationStackProvider).pop();
                },
                buttonText: LocalizationStrings.keyGo.localized,
                buttonTextStyle: TextStyles.regular
                    .copyWith(fontSize: 25.sp, color: AppColors.white),
                backgroundColor: AppColors.greenFF14861F,
              ),

              ///Close Button
              CommonButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                buttonText: LocalizationStrings.keyClose.localized,
                buttonTextStyle: TextStyles.regular
                    .copyWith(fontSize: 25.sp, color: AppColors.black.withOpacity(0.5)),
                backgroundColor: AppColors.greyFFE9E9E9,
              ),
            ],
          ).paddingSymmetric(horizontal: 60.w, vertical: 40.h,)
        ],
      ).paddingOnly(left: 20.w, right: 20.w),
    );
  }
}
