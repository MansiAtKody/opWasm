import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';


final changeLanguageController = ChangeNotifierProvider(
      (ref) => getIt<ChangeLanguageController>(),
);

@injectable
class ChangeLanguageController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = true;

    if (isNotify) {
      notifyListeners();
    }
  }

  String? selectLanguage = LocalizationStrings.keyEnglish.localized;

  List<String> languageList = [
    LocalizationStrings.keyEnglish.localized,
    LocalizationStrings.keyHindi.localized,
    LocalizationStrings.keyFrance.localized,
    LocalizationStrings.keyArabic.localized
  ];

  ///Update Language
  void updateLanguage({required String list}) {
    selectLanguage = list;
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
