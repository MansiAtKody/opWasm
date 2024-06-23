import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/contract/authentication_repository.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/request%20model/send_otp_request_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/response%20model/send_otp_response_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/verify_otp_request_model.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';


final otpVerificationController = ChangeNotifierProvider(
      (ref) => getIt<OtpVerificationController>(),
);

@injectable
class OtpVerificationController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    otpController.clear();
    focusNode.requestFocus();
    resendOtpState.isLoading = false;
    resendOtpState.success = null;

    Future.delayed(const Duration(milliseconds: 100), () {
      formKey.currentState?.reset();
    },);
    if (isNotify) {
      notifyListeners();
    }
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  ///Check Validity of all fields
  bool isAllFieldsValid = false;

  /// Focus node
  FocusNode focusNode = FocusNode();

  ///Update the value of is all fields valid
  checkIfAllFieldsValid() {
    isAllFieldsValid = (validateOtp(otpController.text) == null);
    notifyListeners();
  }

  ///For Counter
  int counterSeconds = 60;
  Timer? counter;

  ///Start Counter
  void startCounter() {
    counterSeconds = 60;
    const oneSec = Duration(seconds: 1);
    counter = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (counterSeconds == 0) {
          timer.cancel();
        } else {
          counterSeconds = counterSeconds - 1;
        }
        notifyListeners();
      },
    );
  }

  ///Set Counter Seconds
  String getCounterSeconds() {
    int minutes = (counterSeconds ~/ 60);
    int seconds = counterSeconds - (minutes * 60);
    if (seconds < 10) {
      return '0$minutes:0$seconds';
    }
    return '0$minutes:$seconds';
  }
  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  AuthenticationRepository authenticationRepository;
  OtpVerificationController(this.authenticationRepository);

  var verifyOtpState = UIState<CommonResponseModel>();

  /// verify otp API
  Future<void> verifyOtpApi(BuildContext context, String email) async {
    verifyOtpState.isLoading = true;
    verifyOtpState.success = null;
    notifyListeners();

    VerifyOtpRequestModel requestModel = VerifyOtpRequestModel(email: email, userType: 'OPERATOR', type: 'EMAIL', sendingType: 'OTP', otp: otpController.text);
    String request = verifyOtpRequestModelToJson(requestModel);

    final result = await authenticationRepository.verifyOtpApi(request);

    result.when(success: (data) async {
      verifyOtpState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
           showCommonErrorDialog(context: context, message: errorMsg);

        });

    verifyOtpState.isLoading = false;
    notifyListeners();
  }



  var resendOtpState = UIState<SendOtpResponseModel>();

  /// resend otp API
  Future<void> resendOtpApi(BuildContext context, {String? email,String? mobileNo}) async {
    resendOtpState.isLoading = true;
    resendOtpState.success = null;
    notifyListeners();
    String type= email!=null ?'EMAIL':'SMS';
    SendOtpRequestModel requestModel =
    SendOtpRequestModel(
        email:email??'',
        contactNumber: mobileNo??'',
        userType:'OPERATOR',
        type:type,
         userUuid:Session.getUserUuid(),
        verifyBeforeGenerate: true);
    String request = sendOtpRequestModelToJson(requestModel);

    final result = await authenticationRepository.resendOtpApi(request);

    result.when(success: (data) async {
      resendOtpState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
           showCommonErrorDialog(context: context, message: errorMsg);
        });

    resendOtpState.isLoading = false;
    notifyListeners();
  }
}
