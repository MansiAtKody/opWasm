import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';


final deskCleaningController = ChangeNotifierProvider(
      (ref) => getIt<DeskCleaningController>(),
);

@injectable
class DeskCleaningController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    buttonText = '';

    if (isNotify) {
      notifyListeners();
    }
  }



  String? selectedTask = '';

  List<String> taskList = [
    LocalizationStrings.keyIamHereToTidyUp.localized,
    LocalizationStrings.keyCreateNewTask.localized,
  ];

  ///Update Task
  void updateTask({required String list}) {
    selectedTask = list;
    notifyListeners();
  }

  ///Clear Selected Task
  void clearSelectedTask({String? value}) {
    selectedTask = null;
    notifyListeners();
  }

  String buttonText = '';

  ///update button text
  void updateButtonText({required String text}){
    buttonText = text;
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
