import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';


final sendServiceDetailController = ChangeNotifierProvider(
      (ref) => getIt<SendServiceDetailController>(),
);

@injectable
class SendServiceDetailController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({
    bool isNotify = false,
  }) {
    isLoading = false;
    isAllFieldsValid = false;
    msgCtr.clear();
    titleCtr.clear();
    resetFormKey();
    if (isNotify) {
      notifyListeners();
    }
  }

  resetFormKey() {
    Future.delayed(const Duration(milliseconds: 100), () {
      formKey.currentState?.reset();
    });
  }

  ///Animation Controller for dialog
  AnimationController? animationController;

  updateAnimationController(AnimationController animationController) {
    this.animationController = animationController;
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController msgCtr = TextEditingController();
  TextEditingController titleCtr = TextEditingController();

  bool isAllFieldsValid = false;

  ///Update the value of is all fields valid
  checkIfAllFieldsValid() {
    isAllFieldsValid = (validateText(msgCtr.text, 'Message must be required') == null);
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
