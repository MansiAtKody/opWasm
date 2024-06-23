import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';


final deleteAccountController = ChangeNotifierProvider(
      (ref) => getIt<DeleteAccountController>(),
);

@injectable
class DeleteAccountController extends ChangeNotifier {


  final formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    descriptionController.clear();
    isAllFieldsValid = false;
    selectedReason =null;
    dropDownState =false;
    if (isNotify) {
      notifyListeners();
    }
  }

  void disposeFormKey() {
    Future.delayed(const Duration(milliseconds: 100), () {
      formKey.currentState?.reset();
    });
  }

  List<String> reasonList = const ['Reason 1', 'Reason 2', 'Reason 3', 'Reason 4', 'Reason 5'];

  String? selectedReason;

  void updateReasonDropDownValue(String? selectedReason) {
    this.selectedReason = selectedReason;
    notifyListeners();
  }

  bool dropDownState =false;

  void updateDropDownState(bool value){
    dropDownState =value;
    notifyListeners();
  }
  ///Check Validity of all fields
  bool isAllFieldsValid = false;

  ///Form Validation
  checkIfAllFieldsValid() {

    isAllFieldsValid = (selectedReason != null ) && (validateText(descriptionController.text, LocalizationStrings.keyDescriptionIsRequired.localized) == null);
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
