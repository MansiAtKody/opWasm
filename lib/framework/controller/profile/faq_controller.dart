// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:injectable/injectable.dart';
// import 'package:kody_operator/framework/repository/profile/model/faq_model.dart';
//
// import 'package:kody_operator/framework/dependency_injection/inject.dart';
//
// final faqController = ChangeNotifierProvider(
//   (ref) => getIt<FaqController>(),
// );
//
// @injectable
// class FaqController extends ChangeNotifier {
//   ///Dispose Controller
//   void disposeController({bool isNotify = false}) {
//     isLoading = true;
//     if (isNotify) {
//       notifyListeners();
//     }
//   }
//
//   final List<FaqModel> faqModelList = [
//     FaqModel(
//         title: 'What is the purpose of the food delivery robot in our office?',
//         description:
//             'The purpose of a food delivery robot in an office setting can vary based on the specific needs and goals of the office environment.'),
//     FaqModel(
//         title: 'What is the purpose of the food delivery robot in our office?',
//         description:
//             'The purpose of a food delivery robot in an office setting can vary based on the specific needs and goals of the office environment.'),
//     FaqModel(
//         title: 'What is the purpose of the food delivery robot in our office?',
//         description:
//             'The purpose of a food delivery robot in an office setting can vary based on the specific needs and goals of the office environment.'),
//     FaqModel(
//         title: 'What is the purpose of the food delivery robot in our office?',
//         description:
//             'The purpose of a food delivery robot in an office setting can vary based on the specific needs and goals of the office environment.'),
//   ];
//
//   void isFaqExpanded(int index) {
//     faqModelList[index].isExpanded = !faqModelList[index].isExpanded;
//     notifyListeners();
//   }
//
//   /*
//   /// ---------------------------- Api Integration ---------------------------------///
//    */
//
//   ///Progress Indicator
//   bool isLoading = false;
//
//   void updateLoadingStatus(bool value) {
//     isLoading = value;
//     notifyListeners();
//   }
// }
