import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/create_ticket_controller.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_form_field_dropdown.dart';

class CreateTicketForm extends ConsumerWidget with BaseConsumerWidget {
  const CreateTicketForm({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final createTicketWatch = ref.watch(createTicketController);
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    return Form(
      key: createTicketWatch.createTicketFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlideLeftTransition(
            delay: 100,
            child: CommonDropdownInputFormField<String>(
              menuItems: helpAndSupportWatch.reasons.map((e) => e.reason).toList(),
              hintText: LocalizationStrings.keySelectReason.localized,
              validator: (value) {
                return validateDropDown(value, LocalizationStrings.keyTicketReasonRequiredValidation.localized);
              },
              onChanged: (selectedReason) {
                createTicketWatch.updateReasonDropDownValue(selectedReason);
                createTicketWatch.validateCreateTicketForm();
              },
            ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
          ),
          SlideLeftTransition(
            delay: 200,
            child: CommonInputFormField(
              textEditingController: createTicketWatch.createTicketDescriptionController,
              backgroundColor: AppColors.transparent,
              validator: (value) {
                return validateText(value, LocalizationStrings.keyDescriptionIsRequired.localized);
              },
              onChanged: (value) {
                createTicketWatch.validateCreateTicketForm();
              },
              maxLines: 20,
              hintText: LocalizationStrings.keyDescription.localized,
            ).paddingLTRB(20.w, 0.h, 20.w, 20.h),
          ),
        ],
      ),
    );
  }
}
