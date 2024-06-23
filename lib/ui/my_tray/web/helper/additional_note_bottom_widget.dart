import 'package:kody_operator/framework/controller/my_tray/additional_note_controller.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdditionalNoteBottomWidget extends ConsumerWidget with BaseConsumerWidget {
  const AdditionalNoteBottomWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    final additionalNoteWatch = ref.watch(additionalNoteController);
    final myTrayWatch = ref.watch(myTrayController);
    return CommonButton(
      buttonText: LocalizationStrings.keySubmit.localized,
      isButtonEnabled: true,
      buttonTextColor:AppColors.white  ,
      rightIcon:const Icon(Icons.arrow_forward, color: AppColors.white),
      onTap: () {
        myTrayWatch.updateAdditionalNoteText(additionalNoteWatch.additionalNoteCtr.text.toString());
        Session.saveLocalData(keyAddedAdditionalNote, additionalNoteWatch.additionalNoteCtr.text.toString());
        Navigator.of(context).pop();
      },
    );
  }
}
