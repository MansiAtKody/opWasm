import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';



final changePasswordController = ChangeNotifierProvider(
      (ref) => getIt<ChangePasswordController>(),
);

@injectable
class ChangePasswordController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;

    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    isAllFieldsValid = false;
    isShowCurrentPassword = false;
    isShowNewPassword = false;
    isShowConfirmPassword = false;
    notifyListeners();
    if (isNotify) {
      notifyListeners();
    }
  }

  ///Dispose Form key
  void disposeFormKey() {
    Future.delayed(const Duration(milliseconds: 100), () {
      formKey.currentState?.reset();
    });
  }

  bool isShowCurrentPassword = false;
  bool isShowNewPassword = false;
  bool isShowConfirmPassword = false;

  /// to change current password visibility
  void changeCurrentPasswordVisibility() {
    isShowCurrentPassword = !isShowCurrentPassword;
    notifyListeners();
  }
  /// to change new password visibility
  void changeNewPasswordVisibility() {
    isShowNewPassword = !isShowNewPassword;
    notifyListeners();
  }
  /// to change confirm password visibility
  void changeConfirmPasswordVisibility() {
    isShowConfirmPassword = !isShowConfirmPassword;
    notifyListeners();
  }
  ///Check Validity of all fields
  bool isAllFieldsValid = false;

  ///Update the value of is all fields valid
  checkIfAllFieldsValid() {
    isAllFieldsValid = (validatePassword(currentPasswordController.text) == null) && (validatePassword(newPasswordController.text) == null && (validatePassword(confirmPasswordController.text) == null)&&(newPasswordController.text == confirmPasswordController.text) && (currentPasswordController.text != newPasswordController.text)) && (currentPasswordController.text != newPasswordController.text);
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
