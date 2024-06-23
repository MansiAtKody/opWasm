import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';



final serviceHistoryController = ChangeNotifierProvider(
      (ref) => getIt<ServiceHistoryController>(),
);

@injectable
class ServiceHistoryController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = true;

    if (isNotify) {
      notifyListeners();
    }
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