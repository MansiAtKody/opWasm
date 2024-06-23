import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';

import 'package:kody_operator/ui/utils/theme/theme.dart';


final additionalNoteController = ChangeNotifierProvider(
      (ref) => getIt<AdditionalNoteController>(),
);

@injectable
class AdditionalNoteController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    additionalNoteCtr.clear();
    formKey.currentState?.reset();
    isAllFieldsValid = false;
    if (isNotify) {
      notifyListeners();
    }
  }

  ///TextEditing Controller
  TextEditingController additionalNoteCtr = TextEditingController();

  ///Form key
  final formKey = GlobalKey<FormState>();

  ///For enabling and disabling button
  bool isAllFieldsValid = false;

  void validateAdditionalNoteField(String value ){
    if(validateText(value, LocalizationStrings.keyAdditionalNoteMsg.localized) !=null){
      isAllFieldsValid = false;
    }else{
      isAllFieldsValid = true;
    }
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
