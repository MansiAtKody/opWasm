import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/contract/authentication_repository.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/forgot_password_request_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/reset_password_request_model.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';


final forgotResetPasswordController = ChangeNotifierProvider(
      (ref) => getIt<ForgotResetPasswordController>(),
);

@injectable
class ForgotResetPasswordController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    emailController.clear();
    newPasswordCtr.clear();
    confirmPasswordCtr.clear();
    isAllFieldsValid = false;
    isShowNewPassword = false;
    isShowConfirmPassword = false;
    Future.delayed(const Duration(milliseconds: 100), () {
      disposeFormKey();
    });
    if (isNotify) {
      notifyListeners();
    }
  }

  /// FormKey for form validation
  final formKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();

  /// TextEditing controller for the email
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  String email = '';

  ///Check Validity of all fields
  bool isAllFieldsValid = false;

  ///Function for setting the email
  void setEmail()
  {
    email = emailController.text;
  }
  ///Update the value of is all fields valid
  checkIfAllFieldsValid() {
    isAllFieldsValid = (validateEmail(emailController.text) == null);
    notifyListeners();
  }

  /// Function to form key
  void disposeFormKey(){
    formKey.currentState?.reset();
  }

  /// TextEditing Controller for the New password
  TextEditingController newPasswordCtr = TextEditingController();
  FocusNode newPasswordFocus = FocusNode();

  /// TextEditing controller for the confirm Password
  TextEditingController confirmPasswordCtr = TextEditingController();
  FocusNode confirmPasswordFocus = FocusNode();

  /// for storing the visibility of the new password
  bool isShowNewPassword = false;
  /// for storing the visibility of the old password
  bool isShowConfirmPassword = false;

  /// Visibility for the reset password
  void changeNewPasswordVisibility() {
    isShowNewPassword = !isShowNewPassword;
    notifyListeners();
  }
  void changeConfirmPasswordVisibility() {
    isShowConfirmPassword = !isShowConfirmPassword;
    notifyListeners();
  }

  ///Update the value of is all fields valid
  checkIfPasswordFieldsValid() {
    isAllFieldsValid = (validatePassword(newPasswordCtr.text) == null && validateConfirmPassword(confirmPasswordCtr.text,newPasswordCtr.text) == null);
    notifyListeners();
  }
  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  AuthenticationRepository authenticationRepository;
  ForgotResetPasswordController(this.authenticationRepository);

  var forgotPasswordState = UIState<CommonResponseModel>();
  var resetPasswordState = UIState<CommonResponseModel>();

  /// forgot Password API
  Future<void> forgotPasswordApi(BuildContext context) async {
    forgotPasswordState.isLoading = true;
    forgotPasswordState.success = null;
    notifyListeners();

    ForgotPasswordRequestModel requestModel = ForgotPasswordRequestModel(email: emailController.text, userType: 'OPERATOR', type: 'EMAIL', sendingType: 'OTP');
    String request = forgotPasswordRequestModelToJson(requestModel);

    final result = await authenticationRepository.forgotPasswordApi(request);

    result.when(success: (data) async {
      forgotPasswordState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
           showCommonErrorDialog(context: context, message: errorMsg);

        });

    forgotPasswordState.isLoading = false;
    notifyListeners();
  }


  /// resetPassword API
  Future<void> resetPasswordApi(BuildContext context, String otp) async {
    resetPasswordState.isLoading = true;
    resetPasswordState.success = null;
    notifyListeners();

    ResetPasswordRequestModel requestModel = ResetPasswordRequestModel(email: emailController.text, userType: 'OPERATOR', type: 'EMAIL', otp: otp, password: confirmPasswordCtr.text.trim());
    String request = resetPasswordRequestModelToJson(requestModel);

    final result = await authenticationRepository.resetPasswordApi(request);

    result.when(success: (data) async {
      resetPasswordState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
           showCommonErrorDialog(context: context, message: errorMsg);

        });

    resetPasswordState.isLoading = false;
    notifyListeners();
  }


}
