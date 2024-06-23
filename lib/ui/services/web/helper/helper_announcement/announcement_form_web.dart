import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_controller.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/web/helper/helper_announcement/common_location_dialog_widget.dart';
import 'package:kody_operator/ui/services/web/helper/helper_announcement/common_title_dialog_web.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/image_picker_manager.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class AnnouncementFormWeb extends ConsumerWidget with BaseConsumerWidget {
  const AnnouncementFormWeb({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final announcementWatch = ref.watch(announcementController);
    final announcementGetDetailsWatch = ref.watch(announcementGetDetailsController);
    return CommonCard(
      color: AppColors.clrF7F7FC,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: announcementGetDetailsWatch.formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        /// Title Field
                        CommonInputFormField(
                          readOnly: true,
                          onTap: () {
                            announcementGetDetailsWatch.checkIfAllFieldsValid();
                            showAnimatedDialog(
                              context,
                              heightPercentage: 70,
                              widthPercentage: 50,
                              onPopCall: (animationController) {
                                announcementWatch.updateAnimationController(animationController);
                              },
                              onCloseTap: () {
                                announcementWatch.reverseAnim();
                                Navigator.pop(context);
                              },
                              child: const CommonTitleDialogue(),
                              title: LocalizationStrings.keyTitle.localized,
                              isCloseButtonVisible: false,
                              givePadding: false,
                            );
                          },
                          textEditingController: announcementGetDetailsWatch.titleController,
                          hintText: LocalizationStrings.keyTitle.localized,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value)
                          {
                            FocusScope.of(context).nextFocus();
                          },
                          suffixWidget: const CommonSVG(
                            strIcon: AppAssets.svgArrowDown,
                          ).paddingSymmetric(horizontal: 10.w, vertical: 10.h),
                          validator: (value) {
                            return validateText(value, LocalizationStrings.keyTitleIsRequired.localized);
                          },
                          onChanged: (val) {
                            announcementGetDetailsWatch.checkIfAllFieldsValid();
                          },
                        ).paddingOnly(top: 20.h, bottom: 40.h),

                        /// Description Field
                        CommonInputFormField(
                          textEditingController: announcementGetDetailsWatch.descriptionController,
                          hintText: LocalizationStrings.keyAnnouncementDescription.localized,
                          textInputAction: TextInputAction.done,
                          maxLines: 11,
                          onFieldSubmitted: (value){
                            hideKeyboard(context);
                          },
                          validator: (value) {
                            return validateText(value, LocalizationStrings.keyPleaseEnterDescription.localized);
                          },
                          onChanged: (desc) {
                            announcementGetDetailsWatch.checkIfAllFieldsValid();
                          },
                        ),

                      ],
                    ),
                  ),

                  SizedBox(width: 30.w),

                  Expanded(
                    child: Column(
                      children: [
                        ///Department Dialog Field
                        CommonInputFormField(
                          readOnly: true,
                          onTap: () {
                            announcementGetDetailsWatch.checkIfAllFieldsValid();
                            showAnimatedDialog(
                              context,
                              heightPercentage: 70,
                              widthPercentage: 50,
                              onPopCall: (animationController) {
                                announcementWatch.updateAnimationController(animationController);
                              },
                              onCloseTap: () {
                                announcementWatch.reverseAnim();
                                Navigator.pop(context);
                              },
                              child: const CommonLocationDialogue(),
                              title: LocalizationStrings.keySelectDepartment.localized,
                              isCloseButtonVisible: false,
                              givePadding: false,
                            );
                          },
                          textEditingController: announcementGetDetailsWatch.departmentNameController,
                          hintText: LocalizationStrings.keyDepartment.localized,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value)
                          {
                            FocusScope.of(context).nextFocus();
                          },
                          suffixWidget: const CommonSVG(
                            strIcon: AppAssets.svgArrowDown,
                          ).paddingSymmetric(horizontal: 10.w, vertical: 10.h),
                          validator: (value) {
                            return validateText(value, LocalizationStrings.keyDepartmentIsRequired.localized);
                          },
                          onChanged: (val) {
                            announcementGetDetailsWatch.checkIfAllFieldsValid();
                          },
                        ).paddingOnly(top: 20.h, bottom: 40.h),

                        ///------------------Image-Picker-----------------///
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: context.height * 0.3150,
                              width: context.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r), border: Border.all(color: AppColors.clr8D8D8D)),
                              child:
                              announcementGetDetailsWatch.selectedAnnouncementImage !=null ?
                              Image.memory(
                                announcementGetDetailsWatch.selectedAnnouncementImage!,
                                height: context.height * 0.1,
                                width: context.height * 0.1,
                                fit: BoxFit.cover,
                              ):
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Uint8List? tempImage =
                                      await ImagePickerManager.instance.openPicker(context, /*isDialogShown: false*/);
                                      announcementGetDetailsWatch.updateSelectedFile(selectedAnnouncementImageItem: tempImage);
                                    },
                                    child: CommonSVG(
                                      strIcon: AppAssets.svgSelectImage,
                                      height: context.height * 0.06,
                                      width: context.height * 0.06,
                                    ),
                                  ),
                                  SizedBox(height: context.height * 0.02),
                                  InkWell(
                                    onTap: () async {
                                      Uint8List? tempImage =
                                      await ImagePickerManager.instance.openPicker(context, /*isDialogShown: false*/);
                                      announcementGetDetailsWatch.updateSelectedFile(selectedAnnouncementImageItem: tempImage);
                                    },
                                    child: CommonText(
                                      title: LocalizationStrings.keySelectImage.localized,
                                      textStyle: TextStyles.regular.copyWith(color: AppColors.blue0083FC),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            /*announcementGetDetailsWatch.isCategorySelected &&*/ announcementGetDetailsWatch.selectedAnnouncementImage != null
                                ? CommonText(
                              title: LocalizationStrings.keyImageRequiredValidation.localized,
                              textStyle: TextStyles.regular.copyWith(fontSize: 10.sp,color: AppColors.red),
                            ).paddingOnly(top: 10.h)
                                : const SizedBox()
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ).paddingOnly(bottom: 31.h),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonButton(
                  onTap: () {
                    hideKeyboard(context);
                    if (announcementGetDetailsWatch.checkValidity(announcementWatch.selectedIndex)) {
                      showSuccessDialogue(
                        context: context,
                        animation: AppAssets.animYourRequestSent,
                        successMessage: LocalizationStrings.keyRequestSentSuccessfully.localized,
                        successDescription: LocalizationStrings.keyWaitForYourReceiverToAcceptRequest.localized,
                        buttonText: LocalizationStrings.keyBackToHome.localized,
                        onTap: () {
                          // Navigator.of(context).pop();
                          ref.read(navigationStackProvider).pop();
                          // ref.watch(orderManagementController).updateSelectedScreen(ScreenName.history);
                        },
                      );
                    }
                  },
                  height: context.height * 0.07,
                  buttonTextStyle: TextStyles.regular.copyWith(
                    fontSize: 18.sp,
                    color: announcementGetDetailsWatch.checkValidity(announcementWatch.selectedIndex) ? AppColors.white : AppColors.textFieldLabelColor,
                  ),
                  buttonText: LocalizationStrings.keySubmit.localized,
                  buttonDisabledColor: AppColors.white,
                  isButtonEnabled: announcementGetDetailsWatch.checkValidity(announcementWatch.selectedIndex),
                ),
              ],
            ).paddingOnly(bottom: 30.h,),
          ],
        ).paddingSymmetric(horizontal: 30.w),
      ),
    );
  }
}
