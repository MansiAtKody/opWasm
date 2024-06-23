import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';

final languageController = ChangeNotifierProvider(
  (ref) => getIt<LanguageController>(),
);

@injectable
class LanguageController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = true;
    if (isNotify) {
      notifyListeners();
    }
  }

  updateInitLanguage(BuildContext context) {
    String locale = Session.getAppLanguage();
    selectedLanguage = languages.firstWhere((element) => element.locale == locale);
    context.setLocale(Locale(locale));
    notifyListeners();
  }

  LanguageModel? selectedLanguage;
  final List<LanguageModel> languages = [
    LanguageModel(localName: 'English', name: 'English', locale: 'en'),
    // LanguageModel(localName: 'हिंदी', name: 'Hindi', locale: 'hi'),
    // LanguageModel(localName: 'Français', name: 'French', locale: 'fr'),
    // LanguageModel(localName: 'عربي', name: 'Arabic', locale: 'ar'),
  ];

  void changeLanguage(BuildContext context, int index) {
    if (selectedLanguage != languages[index]) {
      showConfirmationDialogWeb(
        dialogWidth: context.width * 0.4,
        context: context,
        title: LocalizationStrings.keyChangeLanguage.localized,
        message: LocalizationStrings.keyAppRestartMessage.localized,
        didTakeAction: (isPositive) {
          if (isPositive) {
            selectedLanguage = languages[index];
            globalRef?.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.splash());
            Session.saveLocalData(keyAppLanguage, selectedLanguage?.locale);
          }
        },
      );
    }
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

class LanguageModel {
  String localName;
  String name;
  String locale;

  LanguageModel({required this.localName, required this.name, required this.locale});
}
