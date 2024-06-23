import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';


final internetController = ChangeNotifierProvider((ref) => getIt<InternetController>());

@injectable
class InternetController extends ChangeNotifier {
  bool isCheckingInternet = false;

  Future<bool> checkInternetConnection() async {
    try {
      isCheckingInternet = true;
      notifyListeners();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isCheckingInternet = false;
        notifyListeners();
        return true;
      } else {
        isCheckingInternet = false;
        notifyListeners();
        return false;
      }
    } on SocketException catch (_) {
      isCheckingInternet = false;
      notifyListeners();
      return false;
    }
  }
}
