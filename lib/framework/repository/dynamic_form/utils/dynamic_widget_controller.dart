import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

final dynamicWidgetController = ChangeNotifierProvider(
  (ref) => getIt<DynamicWidgetController>(),
);

@injectable
class DynamicWidgetController extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
