import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';

class BottomWidgetAnnouncementGetDetails extends StatelessWidget with BaseStatelessWidget {
  final AnnouncementsTypeEnum appBarTitle;

  const BottomWidgetAnnouncementGetDetails({super.key, required this.appBarTitle});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final announcementGetDetailsWatch = ref.watch(announcementGetDetailsController);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Send Request Button
            appBarTitle != AnnouncementsTypeEnum.general
                ?

                /// Birthday celebration & Work anniversary button
                CommonButtonMobile(
                    withBackground: true,
                    onTap: () {
                      hideKeyboard(context);
                      if (announcementGetDetailsWatch.formKey.currentState?.validate() ?? false) {
                        showCommonSuccessDialogMobile(
                            context: context,
                            onButtonTap: () {
                              ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.services());
                            });
                      }
                    },
                    buttonTextStyle: TextStyles.regular.copyWith(
                        fontSize: 18.sp,
                        color: announcementGetDetailsWatch.isAllFieldsValid && announcementGetDetailsWatch.personName.isNotEmpty && announcementGetDetailsWatch.personName == announcementGetDetailsWatch.nameController.text
                            ? AppColors.white
                            : AppColors.textFieldLabelColor),
                    buttonText: LocalizationStrings.keySendRequest.localized,
                    rightIcon: Icon(
                      Icons.arrow_forward,
                      color: announcementGetDetailsWatch.isAllFieldsValid && announcementGetDetailsWatch.personName.isNotEmpty && announcementGetDetailsWatch.personName == announcementGetDetailsWatch.nameController.text
                          ? AppColors.white
                          : AppColors.textFieldLabelColor,
                    ),
                    isButtonEnabled: announcementGetDetailsWatch.isAllFieldsValid && announcementGetDetailsWatch.personName.isNotEmpty && announcementGetDetailsWatch.personName == announcementGetDetailsWatch.nameController.text,
                  )
                :

                /// General Button
                CommonButtonMobile(
                    withBackground: true,
                    onValidateTap: () {
                      hideKeyboard(context);
                      announcementGetDetailsWatch.formKey.currentState?.validate();
                    },
                    onTap: () {
                      hideKeyboard(context);
                      if (announcementGetDetailsWatch.formKey.currentState?.validate() ?? false) {
                        showCommonSuccessDialogMobile(
                            context: context,
                            onButtonTap: () {
                              ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.services());
                            });
                      }
                    },
                    buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: announcementGetDetailsWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
                    buttonText: LocalizationStrings.keySendRequest.localized,
                    rightIcon: Icon(Icons.arrow_forward, color: announcementGetDetailsWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
                    isButtonEnabled: announcementGetDetailsWatch.isAllFieldsValid,
                  )
          ],
        );
      },
    );
  }
}
