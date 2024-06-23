import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/contract/authentication_repository.dart';
import 'package:kody_operator/framework/repository/authentication/model/login_request_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/login_response_model.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final loginController = ChangeNotifierProvider(
      (ref) => getIt<LoginController>(),
);

@injectable
class LoginController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isAllFieldsValid = false;
    termsAndConditionsSelected = false;
    emailController.text='';
    passwordController.text='';
    disposeFormKey();
    if (isNotify) {
      notifyListeners();
    }
  }

  final formKey = GlobalKey<FormState>();

  /// TextEditing controller for the email
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  /// TextEditing controller for the password
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  /// For setting the visibility
  bool isShowPassword = false;



  /// Function to form key
  void disposeFormKey(){
    formKey.currentState?.reset();
  }

  void clearLoginForm(){
    emailController.clear();
    passwordController.clear();
    notifyListeners();
    Future.delayed(const Duration(seconds: 1),(){
      formKey.currentState?.reset();
    });
    notifyListeners();
  }

  /// to change password visibility
  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  ///Is Terms and Conditions selected
  bool termsAndConditionsSelected = false;

  void updateTermsAndConditionsSelected(bool termsAndConditionsSelected) {
    this.termsAndConditionsSelected = termsAndConditionsSelected;
    checkIfAllFieldsValid();
    notifyListeners();
  }

    ///Check Validity of all fields
  bool isAllFieldsValid = false;

  ///Update the value of is all fields valid
  void checkIfAllFieldsValid() {
    isAllFieldsValid = (validateEmail(emailController.text) == null) && (validatePassword(passwordController.text) == null);
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  AuthenticationRepository authenticationRepository;
  LoginController(this.authenticationRepository);

  var loginState = UIState<LoginResponseModel>();

  /// Login API
  Future<void> loginApi(BuildContext context) async {
    loginState.isLoading = true;
    loginState.success = null;
    notifyListeners();

    LoginRequestModel requestModel = LoginRequestModel(email: emailController.text, password: passwordController.text.trim());
    String request = loginRequestModelToJson(requestModel);

    final result = await authenticationRepository.loginApi(request);

    result.when(success: (data) async {
      loginState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
           showCommonErrorDialog(context: context, message: errorMsg);
        });

    loginState.isLoading = false;
    notifyListeners();
  }

}
