import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import 'package:kody_operator/framework/dependency_injection/inject.dart';

final settingController = ChangeNotifierProvider(
  (ref) => getIt<SettingController>(),
);

@injectable
class SettingController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = true;

    if (isNotify) {
      notifyListeners();
    }
  }

  bool isLightOnn = false;
  bool isObstacleSoundOnn = false;
  int soundValue = 0;
  int speedValue = 0;

  ///Update light status
  void updateLightStatus() {
    isLightOnn = !isLightOnn;
    notifyListeners();
  }

  ///Update light status
  void updateObstacleSoundStatus() {
    isObstacleSoundOnn = !isObstacleSoundOnn;
    notifyListeners();
  }

  bool isSpeedIncreased = true;
  bool isSoundIncreased = true;

  ///Update speed value
  void updateSpeedLevelStatus(bool isIncreased) {
    isSpeedIncreased = isIncreased;
    if (isIncreased) {
      if (speedValue < 10) {
        speedValue++;
      }
    } else {
      if (speedValue > 0) {
        speedValue--;
      }
    }
    notifyListeners();
  }

  ///Update speed value
  void updateSoundLevelStatus(bool isIncreased) {
    isSoundIncreased = isIncreased;
    if (isIncreased) {
      if (soundValue < 10) {
        soundValue++;
      }
    } else {
      if (soundValue > 0) {
        soundValue--;
      }
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
