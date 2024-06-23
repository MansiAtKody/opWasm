import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';


final otpVerificationProfileModuleController = ChangeNotifierProvider(
      (ref) => getIt<OtpVerificationProfileModuleController>(),
);

@injectable
class OtpVerificationProfileModuleController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({
    bool isNotify = false,
  }) {
    otpController.clear();
    focusNode.requestFocus();
    Future.delayed(const Duration(milliseconds: 10), () {
      formKey.currentState?.reset();
    });
    counter?.cancel();
    startCounter();
    if (isNotify) {
      notifyListeners();
    }
  }

  ///Form Key
  final formKey = GlobalKey<FormState>();

  String emailAddress = '';

  TextEditingController otpController = TextEditingController();

  /// Focus node
  FocusNode focusNode = FocusNode();

  ///Check Validity of all fields
  bool isAllFieldsValid = false;

  ///Update the value of is all fields valid
  checkIfAllFieldsValid() {
    isAllFieldsValid = (validateOtp(otpController.text) == null);
    notifyListeners();
  }

  ///For Counter
  int counterSeconds = 30;
  Timer? counter;

  ///Start Counter
  void startCounter() {
    counterSeconds = 30;
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

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
