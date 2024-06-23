import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/ui/splash/web/helper/rive_avtar.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';


final splashController = ChangeNotifierProvider(
      (ref) => getIt<SplashController>(),
);

@injectable
class SplashController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;

    if (isNotify) {
      notifyListeners();
    }
  }

  RiveAvatar? avatar;
  Timer? timer;
  double leftToRightPosition = 400.0;
  double rightToLeftPosition = 600.0;
  double topToBottomPosition = 450.h;

  initRive() async {
    avatar = await loadAnimation(AppAssets.rivSplashRobot);
    animateMyArtBoard();
    notifyListeners();
  }

  updateTopToBottomPosition(double topToBottomPosition) {
    this.topToBottomPosition = topToBottomPosition;
    notifyListeners();
  }

  animateMyArtBoard() async {
    bool isLeftToRight = false;
    timer?.cancel();
    Offset currentPosition = Offset(leftToRightPosition, 500);
    timer = Timer.periodic(const Duration(milliseconds: 6), (timer) {
      if (currentPosition.dx == leftToRightPosition) {
        isLeftToRight = true;
      }
      if (currentPosition.dx == rightToLeftPosition) {
        isLeftToRight = false;
      }
      if (isLeftToRight) {
        currentPosition = Offset((currentPosition.dx + 1), currentPosition.dy);
      } else {
        currentPosition = Offset((currentPosition.dx - 1), currentPosition.dy);
      }
      avatar?.move(currentPosition);
    });
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
