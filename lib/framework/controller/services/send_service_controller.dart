import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';

final sendServiceController = ChangeNotifierProvider(
  (ref) => getIt<SendServiceController>(),
);

@injectable
class SendServiceController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = true;
    profiles.clear();
    searchCtr.clear();
    profiles = [];
    if (isNotify) {
      notifyListeners();
    }
  }

  TextEditingController searchCtr = TextEditingController();

  void onSearch() {
    if (searchCtr.text.isEmpty) {
      hasProfiles = true;
      addOrRemoveProfiles();
      notifyListeners();
    } else {
      hasProfiles = false;
      addOrRemoveProfiles();
      profiles.retainWhere((element) {
        return (element.name.toLowerCase().contains(searchCtr.text.toLowerCase()));
      });
      notifyListeners();
    }
  }

  bool hasProfiles = false;

  List<ProfileModel> profiles = [];

  void hasProfile() {
    hasProfiles = !hasProfiles;
    notifyListeners();
  }

  void clearSearch() {
    searchCtr.clear();
    onSearch();
    notifyListeners();
  }

  void addOrRemoveProfiles() {
    hasProfile();
    if (hasProfiles == true) {
      if (profiles.isEmpty) {
        for (int i = 0; i < 5; i++) {
          profiles.add(
            ProfileModel(
              name: i % 5 == 0
                  ? 'Amaan'
                  : i % 4 == 0
                      ? 'Muskan'
                      : i % 3 == 0
                          ? 'Hafiza'
                          : i % 2 == 0
                              ? 'Sagar'
                              : 'Manthan',
              department: i % 2 == 0 ? 'Ui/Ux Designer' : 'Jr. Mobile Consultant',
              id: i + 1,
            ),
          );
          hasProfiles = !hasProfiles;
          notifyListeners();
        }
      }
    } else {
      profiles.clear();
      hasProfiles = !hasProfiles;
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
