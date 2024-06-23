import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';


final changeEmailController = ChangeNotifierProvider(
      (ref) => getIt<ChangeEmailController>(),
);

@injectable
class ChangeEmailController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
      if (isNotify) {
      notifyListeners();
    }
  }

  /*bool isAllFieldsValid =false;

  /// Text Editing Controller
  TextEditingController newEmailCtr = TextEditingController();

  /// Form Key
  final formKey = GlobalKey<FormState>();

  resetFormKey(){
    formKey.currentState?.reset();
    notifyListeners();
  }

  validateAllFields(String? value){
    isAllFieldsValid = validateEmail(value) != null? false:true;
    notifyListeners();
  }*/
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
