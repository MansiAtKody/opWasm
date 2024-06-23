import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/repository/faq/model/faq_model.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';


final faqController = ChangeNotifierProvider(
      (ref) => getIt<FaqController>(),
);

@injectable
class FaqController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = true;

    if (isNotify) {
      notifyListeners();
    }
  }


  /// Check whether the faq is expanded or not
  bool isExpandable = false;

  /// Faq Model list

  List<FaqModel> faqModel=[
    FaqModel(description: 'the app provides a platform for providing services at the employee desk and allow them to order the required things from the application.you may use the app for personal, non- commercial purposes only. you agree not to use the app for any illegal or unauthorized activities or in a manner that violates any applicable laws or regulations.', title: 'What is the purpose of the food delivery robot in our office?'),
    FaqModel(description: 'the app provides a platform for providing services at the employee desk and allow them to order the required things from the application.you may use the app for personal, non- commercial purposes only. you agree not to use the app for any illegal or unauthorized activities or in a manner that violates any applicable laws or regulations.', title: 'What features are available through the robots application?'),
    FaqModel(description: 'the app provides a platform for providing services at the employee desk and allow them to order the required things from the application.you may use the app for personal, non- commercial purposes only. you agree not to use the app for any illegal or unauthorized activities or in a manner that violates any applicable laws or regulations.', title: 'How accurate is the real-time tracking feature?'),
    FaqModel(description: 'the app provides a platform for providing services at the employee desk and allow them to order the required things from the application.you may use the app for personal, non- commercial purposes only. you agree not to use the app for any illegal or unauthorized activities or in a manner that violates any applicable laws or regulations.', title: 'How frequently is the application updated?'),
    FaqModel(description: 'the app provides a platform for providing services at the employee desk and allow them to order the required things from the application.you may use the app for personal, non- commercial purposes only. you agree not to use the app for any illegal or unauthorized activities or in a manner that violates any applicable laws or regulations.', title: 'What is the purpose of the food delivery robot in our office?'),
    FaqModel(description: 'the app provides a platform for providing services at the employee desk and allow them to order the required things from the application.you may use the app for personal, non- commercial purposes only. you agree not to use the app for any illegal or unauthorized activities or in a manner that violates any applicable laws or regulations.', title: 'What is the purpose of the food delivery robot in our office?'),
    FaqModel(description: 'the app provides a platform for providing services at the employee desk and allow them to order the required things from the application.you may use the app for personal, non- commercial purposes only. you agree not to use the app for any illegal or unauthorized activities or in a manner that violates any applicable laws or regulations.', title: 'How accurate is the real-time tracking feature?'),
  ];

  /// function for the list
  void setExpandable (int index)
  {
    faqModel.elementAt(index).isExpandable=!faqModel.elementAt(index).isExpandable;
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
