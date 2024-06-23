import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_controller.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonTitleDialogue extends StatelessWidget with BaseStatelessWidget {
  final void Function()? onLocationSelected;
  final void Function()? onContinueButtonPressed;

  const CommonTitleDialogue({super.key, this.onLocationSelected, this.onContinueButtonPressed});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final announcementGetDetailsWatch = ref.watch(announcementGetDetailsController);
        final announcementWatch = ref.watch(announcementController);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              title: LocalizationStrings.keySelectTitle.localized,
              textStyle: TextStyles.medium.copyWith(fontSize: 20.sp, color: AppColors.primary2),
            ).paddingOnly(top: 25.h),
            SizedBox(
              height: 25.h,
            ),

            /// location list
            Container(
              height: context.height * 0.42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.white,
              ),
              alignment: Alignment.center,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: announcementGetDetailsWatch.titleList.length,
                itemBuilder: (context, index) {
                  TitleModel model = announcementGetDetailsWatch.titleList[index];
                  return _locationTileWidget(
                    index,
                    model,
                  ).paddingOnly(top: index == 0 ? 30.h : 0.h);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15.h,
                  );
                },
              ).paddingOnly(left: 30.w, right: 30.w),
            ),

            /// location button
            CommonButton(
              buttonText: LocalizationStrings.keySubmit.localized,
              height: context.height * 0.07,
              isButtonEnabled: true,
              // rightIcon: const Icon(Icons.arrow_forward, color: AppColors.white),
              onTap: () {
                announcementGetDetailsWatch.checkIfAllFieldsValid();

                /// To Update Main Index
                // announcementWatch.updateSelectedLocation();
                announcementWatch.reverseAnim();
                Navigator.pop(context);
              },
            ).paddingOnly(top: 30.h),
          ],
        ).paddingSymmetric(horizontal: 25.w);
      },
    );
  }

  Widget _locationTileWidget(
      int index,
      TitleModel titleModel,
      ) {
    return SizedBox(
      height: 50.h,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final announcementWatch = ref.watch(announcementGetDetailsController);
          return InkWell(
            onTap: () {
              announcementWatch.updateSelectedTempTitle(index);
              announcementWatch.updateSelectedTitle(selectedTitle: titleModel);
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Department Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 46.h,
                        width: 46.h,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.clrF7F7FC),
                        alignment: Alignment.center,
                        child: CommonSVG(
                          strIcon: titleModel.icon,
                        ),
                      ),

                      SizedBox(
                        width: 10.w,
                      ),

                      /// Department name
                      CommonText(
                        title: titleModel.name,
                        clrfont: AppColors.clr171717,
                      ),
                      titleModel.isDefault
                          ? CommonText(
                        title: ' (${LocalizationStrings.keyDefaultLocation.localized})',
                        clrfont: AppColors.greyBEBEBE,
                      )
                          : const Offstage(),
                    ],
                  ),

                  /// Radio Button
                  SizedBox(
                    width: 30.h,
                    height: 30.h,
                    child: Icon(
                      announcementWatch.selectedTitleTempIndex == index ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: announcementWatch.selectedTitleTempIndex == index ? AppColors.primary2 : AppColors.clr171717,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
