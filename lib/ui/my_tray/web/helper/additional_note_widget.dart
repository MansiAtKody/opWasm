import 'package:kody_operator/framework/controller/my_tray/additional_note_controller.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdditionalNoteWidget extends ConsumerWidget with BaseConsumerWidget {
  const AdditionalNoteWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    final additionalNoteWatch = ref.read(additionalNoteController);
    return Form(
      key: additionalNoteWatch.formKey,
      child: Column(
        children: [
          CommonInputFormField(
            hintText: LocalizationStrings.keyNote.localized,
            textEditingController: additionalNoteWatch.additionalNoteCtr,
            textInputType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 10,
          ),
        ],
      ),
    );
  }
}
