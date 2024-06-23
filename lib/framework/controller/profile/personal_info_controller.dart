import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';


final personalInfoController = ChangeNotifierProvider(
      (ref) => getIt<PersonalInfoController>(),
);

@injectable
class PersonalInfoController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = true;
    profileImage = null;
    profileImageRemoved=false;
    if (isNotify) {
      notifyListeners();
    }
  }

  Uint8List? profileImage;
  bool profileImageRemoved = false;

  /// update profile image
  updateProfileImage(Uint8List? photoFile) {
    profileImage = photoFile!;
    notifyListeners();
  }
  updateProfileImageRemoveStatus(bool value) {
    profileImageRemoved = value;
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
