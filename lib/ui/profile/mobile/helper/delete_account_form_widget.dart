import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/controller/profile/delete_account_controller.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_form_field_dropdown.dart';

class DeleteAccountFormWidget extends StatelessWidget with BaseStatelessWidget {

  const DeleteAccountFormWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final deleteAccountWatch = ref.watch(deleteAccountController);
        return Form(
          key: deleteAccountWatch.formKey,
          child: Column(
            children: [
              /// Select Reason DropDown
              SlideLeftTransition(
                delay: 100,
                child: CommonDropdownInputFormField<String>(
                  menuItems: deleteAccountWatch.reasonList,
                  hintText: LocalizationStrings.keySelectReason.localized,
                  onChanged: (value) {
                    deleteAccountWatch.updateReasonDropDownValue(value);
                    deleteAccountWatch.checkIfAllFieldsValid();
                  },
                  onMenuStateChange: (bool? value){
                    deleteAccountWatch.updateDropDownState(value ?? false);
                  },
                  menuStateValue: deleteAccountWatch.dropDownState,
                  validator: (value) {
                    return validateDropDown(value, LocalizationStrings.keyPleaseSelectReason.localized);
                  },
                ).paddingOnly(bottom: 30.h),
              ),

              /// Description Field
              SlideLeftTransition(
                delay: 150,
                child: CommonInputFormField(
                  textEditingController: deleteAccountWatch.descriptionController,
                  textInputType: TextInputType.multiline,
                  hintText: LocalizationStrings.keyDescription.localized,
                  labelText: LocalizationStrings.keyDescription.localized,
                  textInputAction: TextInputAction.newline,
                  maxLines: 20,
                  validator: (value) {
                    return validateText(value, LocalizationStrings.keyDescriptionIsRequired.localized);
                  },
                  onChanged: (description) {
                    deleteAccountWatch.checkIfAllFieldsValid();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
