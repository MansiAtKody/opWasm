import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/mobile/helper/searched_name_result.dart';
import 'package:kody_operator/ui/services/mobile/helper/select_department_bottom_sheet.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class CenterWidgetAnnouncementGetDetails extends StatelessWidget with BaseStatelessWidget {
  final AnnouncementsTypeEnum appBarTitle;

  const CenterWidgetAnnouncementGetDetails({super.key, required this.appBarTitle});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final announcementGetDetailsWatch = ref.watch(announcementGetDetailsController);
        return Stack(
          children: [
            Form(
              key: announcementGetDetailsWatch.formKey,
              child: Column(
                children: [
                  ///Department Bottom Sheet Field
                  SlideLeftTransition(
                    delay: 100,
                    child: CommonInputFormField(
                      readOnly: true,
                      onTap: () {
                        announcementGetDetailsWatch.updateSuffix();
                        openSelectDepartmentBottomSheet(context: context, ref: ref);
                      },
                      textEditingController: announcementGetDetailsWatch.departmentNameController,
                      hintText: LocalizationStrings.keyDepartment.localized,
                      suffixWidget: IconButton(
                          onPressed: () {
                            openSelectDepartmentBottomSheet(context: context, ref: ref);
                          },
                          icon: announcementGetDetailsWatch.isSuffixUp ? const RotatedBox(quarterTurns: 6, child: CommonSVG(strIcon: AppAssets.svgArrowDown)) : const CommonSVG(strIcon: AppAssets.svgArrowDown)),
                      validator: (value) {
                        return validateText(value, LocalizationStrings.keyDepartmentIsRequired.localized);
                      },
                      onChanged: (val) {
                        announcementGetDetailsWatch.checkIfAllFieldsValid(checkName: appBarTitle != AnnouncementsTypeEnum.general);
                      },
                    ).paddingOnly(top: 40.h),
                  ),

                  /// Name Search Field
                  appBarTitle != AnnouncementsTypeEnum.general
                      ? SlideLeftTransition(
                          delay: 200,
                          child: CommonInputFormField(
                            textEditingController: announcementGetDetailsWatch.nameController,
                            textInputType: TextInputType.text,
                            hintText: LocalizationStrings.keyName.localized,
                            textInputAction: TextInputAction.next,
                            validator: (name) => announcementGetDetailsWatch.validateName(),
                            onChanged: (name) {
                              announcementGetDetailsWatch.updateListVisibilityTrue();
                              announcementGetDetailsWatch.onSearch();
                              announcementGetDetailsWatch.checkIfAllFieldsValid(checkName: appBarTitle != AnnouncementsTypeEnum.general);
                            },
                            onTapOutside: (value) {
                              FocusScope.of(context).unfocus();
                            },
                          ).paddingOnly(top: 20.h),
                        )
                      : const SizedBox().paddingOnly(top: 20.h),

                  /// Description Field
                  SlideLeftTransition(
                    delay: 200,
                    child: CommonInputFormField(
                      textEditingController: announcementGetDetailsWatch.descriptionController,
                      textInputType: TextInputType.multiline,
                      hintText: LocalizationStrings.keyDescription.localized,
                      textInputAction: TextInputAction.newline,
                      maxLines: appBarTitle == AnnouncementsTypeEnum.birthdayCelebration || appBarTitle == AnnouncementsTypeEnum.workAnniversary ? 20 : 23,
                      validator: (value) {
                        return validateText(value, LocalizationStrings.keyPleaseEnterDescription.localized);
                      },
                      onChanged: (desc) {
                        announcementGetDetailsWatch.checkIfAllFieldsValid(checkName: appBarTitle != AnnouncementsTypeEnum.general);
                      },
                    ).paddingOnly(top: 20.h),
                  ),
                ],
              ),
            ),

            /// Searched Result List Dropdown
            announcementGetDetailsWatch.profiles.isNotEmpty
                ? Positioned(
                    top: 0.2.sh,
                    child: Visibility(
                      visible: announcementGetDetailsWatch.visibleList,
                      child: SizedBox(
                        height: 0.5.sh,
                        child: const SearchedNameResult(),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
