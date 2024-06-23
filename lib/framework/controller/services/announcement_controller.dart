import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';

final announcementController = ChangeNotifierProvider(
  (ref) => getIt<AnnouncementController>(),
);

@injectable
class AnnouncementController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    selectedIndex = 0;
    if (isNotify) {
      notifyListeners();
    }
  }

  ///Animation Controller for dialog
  AnimationController? animationController;

  updateAnimationController(AnimationController animationController) {
    this.animationController = animationController;
    notifyListeners();
  }

  reverseAnim() {
    animationController?.reverse(from: 0.3);

  }

  ///Announcement Types
  List<AnnouncementTypesModel> announcementTypesList = [
    AnnouncementTypesModel(announcementTitle: LocalizationStrings.keyGeneral.localized, announcementSvg: AppAssets.svgGeneral),
    AnnouncementTypesModel(announcementTitle: LocalizationStrings.keyBirthdayCelebration.localized, announcementSvg: AppAssets.svgBirthdayCelebration),
    AnnouncementTypesModel(announcementTitle: LocalizationStrings.keyWorkAnniversary.localized, announcementSvg: AppAssets.svgWorkAnniversary),
  ];

  int selectedIndex = 0;

  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  String getAnnouncementTypeTitle() {
    return announcementTypesList[selectedIndex].announcementTitle;
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

/// Model for the announcement
class AnnouncementTypesModel {
  final String announcementTitle;
  final String announcementSvg;

  AnnouncementTypesModel({required this.announcementTitle, required this.announcementSvg});
}
