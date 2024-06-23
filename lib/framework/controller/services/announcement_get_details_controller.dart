import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';

import 'package:kody_operator/framework/dependency_injection/inject.dart';

final announcementGetDetailsController = ChangeNotifierProvider(
  (ref) => getIt<AnnouncementGetDetailsController>(),
);

@injectable
class AnnouncementGetDetailsController extends ChangeNotifier {
  /// form key
  final formKey = GlobalKey<FormState>();

  /// department name controller
  final TextEditingController departmentNameController = TextEditingController();

  /// name controller
  final TextEditingController nameController = TextEditingController();

  ///description controller
  final TextEditingController descriptionController = TextEditingController();

  ///title controller
  final TextEditingController titleController = TextEditingController();

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    isAllFieldsValid = false;
    personName = '';
    visibleList = false;
    selectedDepartment ??= departmentList[0];
    selectedTitle ??= titleList[0];
    nameController.clear();
    descriptionController.clear();
    departmentNameController.clear();
    titleController.clear();
    addOrRemoveProfiles();
    updateSelectedDepartment();
    if (isNotify) {
      notifyListeners();
    }
  }

  DepartmentModel? selectedDepartment;

  TitleModel? selectedTitle;

  bool isSuffixUp = false;

  void updateSuffix(){
    isSuffixUp = !isSuffixUp;
    notifyListeners();
  }

  /// To store the Announcement image
  Uint8List? selectedAnnouncementImage;

  ///Add Image
  updateSelectedFile({Uint8List? selectedAnnouncementImageItem}) {
    selectedAnnouncementImage = selectedAnnouncementImageItem;
    notifyListeners();
  }

  // int selectedDepartmentTempIndex = 0;

  // List<LocationModel> departmentListWeb = [
  //   LocationModel(icon: AppAssets.svgAllLogo, name: 'All'),
  //   LocationModel(icon: AppAssets.svgUiUx, name: 'UI/UX Team', isDefault: true),
  //   LocationModel(icon: AppAssets.svgBd, name: 'Business Development Team'),
  //   LocationModel(icon: AppAssets.svgMobile, name: 'Mobile Team'),
  //   LocationModel(icon: AppAssets.svgJavaLogo, name: 'Java Team'),
  //   LocationModel(icon: AppAssets.svgPhp, name: 'PHP Team'),
  //   LocationModel(icon: AppAssets.svgRoboticsTeam, name: 'Robotics Team'),
  // ];

  List<DepartmentModel> departmentList = [
    DepartmentModel(icon: AppAssets.svgAllLogo, name: 'All'),
    DepartmentModel(icon: AppAssets.svgUiUx, name: 'UI/UX Team', isDefault: true),
    DepartmentModel(icon: AppAssets.svgBd, name: 'Business Development Team'),
    DepartmentModel(icon: AppAssets.svgMobile, name: 'Mobile Team'),
    DepartmentModel(icon: AppAssets.svgJavaLogo, name: 'Java Team'),
    DepartmentModel(icon: AppAssets.svgPhp, name: 'PHP Team'),
    DepartmentModel(icon: AppAssets.svgRoboticsTeam, name: 'Robotics Team'),
  ];

  List<TitleModel> titleList = [
    TitleModel(name: 'General', icon: AppAssets.svgGeneral),
    TitleModel(name: 'Birthday Celebration', icon: AppAssets.svgBirthdayCelebration),
    TitleModel(name: 'Work Anniversary', icon: AppAssets.svgWorkAnniversary),
  ];

  /// call on continue button
  void updateSelectedLocation(int index) {
    // selectedDepartmentIndex = index;
    // selectedDepartmentTempIndex = index;
    notifyListeners();
  }

  void clearControllers() {
    nameController.clear();
    descriptionController.clear();
    departmentNameController.clear();
    updateSelectedDepartment();
    Future.delayed(const Duration(milliseconds: 1), () {
      formKey.currentState?.reset();
    });
    notifyListeners();
  }

  bool checkValidity(int index) {
    if (index == 0) {
      return (departmentNameController.text.isNotEmpty && descriptionController.text.length > 3);
    } else {
      return (departmentNameController.text.isNotEmpty && isAllFieldsValid);
    }
  }

  /// call on continue button
  void updateSelectedDepartment({DepartmentModel? selectedDepartment}) {
    selectedDepartment ??= departmentList[0];
    this.selectedDepartment = selectedDepartment;
    departmentNameController.text = this.selectedDepartment?.name ?? '';
    notifyListeners();
  }

  /// update Selected Title
  void updateSelectedTitle({TitleModel? selectedTitle}) {
    selectedTitle ??= titleList[0];
    this.selectedTitle = selectedTitle;
    titleController.text = this.selectedTitle?.name ?? '';
    notifyListeners();
  }

  /// call on radio click, close button bottomSheet
  // void updateSelectedTempDepartment(int index) {
  //   selectedDepartmentTempIndex = index;
  //   notifyListeners();
  // }

  ///update department name
  void updateDepartment({required int index}) {
    departmentNameController.text = departmentList[index].name;
    notifyListeners();
  }

  ///Check Validity of all fields
  bool isAllFieldsValid = false;

  ///Update the value of if all fields valid
  void checkIfAllFieldsValidOrNot() {
    isAllFieldsValid = (validateText(nameController.text, LocalizationStrings.keyNameRequired.localized) == null) && (validateText(descriptionController.text, LocalizationStrings.keyPleaseEnterDescription.localized) == null);
    notifyListeners();
  }

  ///Update the value of if all fields valid
  void checkIfAllFieldsValid({bool? checkName}) {
    isAllFieldsValid = ((checkName ?? true) ? (validateName() == null) : true) &&
        (validateText(descriptionController.text, LocalizationStrings.keyPleaseEnterDescription.localized) == null) &&
        ((validateText(departmentNameController.text, LocalizationStrings.keyDepartmentIsRequired.localized) == null)) &&
        ((validateText(titleController.text, LocalizationStrings.keyTitleIsRequired.localized) == null));
    notifyListeners();
  }

  ///Check Validity of description field
  bool isDescriptionFieldValid = false;

  ///Update the value of if all fields valid
  void checkIfDescriptionFieldValid() {
    isDescriptionFieldValid = (validateText(descriptionController.text, LocalizationStrings.keyPleaseEnterDescription.localized) == null);
    notifyListeners();
  }

  void onSearch() {
    if (nameController.text.isEmpty) {
      hasProfiles = true;
      addOrRemoveProfiles();
      notifyListeners();
    } else {
      hasProfiles = false;
      addOrRemoveProfiles();
      profiles.retainWhere((element) {
        return (element.name.toLowerCase().contains(nameController.text.toLowerCase()));
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

  void addOrRemoveProfiles() {
    hasProfile();
    if (hasProfiles == true) {
      for (int i = 0; i < 10; i++) {
        profiles.add(
          ProfileModel(
            name: i % 2 == 0 ? 'John' : 'Andrew',
            department: i % 2 == 0 ? 'Ui/Ux Designer' : 'Jr. Mobile Consultant',
            id: i + 1,
          ),
        );
        hasProfiles = !hasProfiles;
        notifyListeners();
      }
    } else {
      profiles.clear();
      hasProfiles = !hasProfiles;
      notifyListeners();
    }
  }

  /// Name Field Validate
  String? validateNameField(String? value) {
    if (nameController.text.length < 3) {
      return validateText(value, LocalizationStrings.keyNameRequired.localized);
    } else if (personName.isEmpty || personName != nameController.text) {
      return LocalizationStrings.keyNoPersonFoundWithTheGivenName.localized;
    } else {
      return null;
    }
  }

  String personName = '';

  /// update Name
  void updateName(String name) {
    personName = name;
    nameController.text = name;
    notifyListeners();
  }

  /// Visible List
  bool visibleList = false;

  /// update Visible List to True
  void updateListVisibilityTrue() {
    visibleList = true;
    notifyListeners();
  }

  /// update Visible List to False
  void updateListVisibilityFalse() {
    visibleList = false;
    notifyListeners();
  }

  /// Function to Dispose Form Key
  void disposeFormKey() {
    formKey.currentState?.reset();
    notifyListeners();
  }

  String? validateName() {
    if (nameController.text.isEmpty) {
      return LocalizationStrings.keyNameRequired.localized;
    } else {
      Iterable<ProfileModel> profileList = profiles.where((element) => element.name.toLowerCase().contains(nameController.text.toLowerCase()));
      if (profileList.isNotEmpty && profiles.contains(profileList.first)) {
        return null;
      } else {
        return LocalizationStrings.keyNoPersonFoundWithTheGivenName.localized;
      }
    }
  }

  int selectedLocationIndex = 0;
  int selectedLocationTempIndex = 0;
  int selectedTitleTempIndex = 0;

  List<LocationModel> locationList = [
    LocationModel(icon: AppAssets.svgUiUx, name: 'UI/UX Team', isDefault: true),
    LocationModel(icon: AppAssets.svgPhp, name: 'PHP Team', isDefault: false),
    LocationModel(icon: AppAssets.svgMobile, name: 'Mobile Team', isDefault: false),
    LocationModel(icon: AppAssets.svgBd, name: 'Business Development Team', isDefault: false),
  ];

  // /// call on continue button
  // void updateSelectedLocation(int index){
  //   selectedLocationIndex = index;
  //   notifyListeners();
  // }

  /// call on radio click, close button bottomSheet
  void updateSelectedTempLocation(int index) {
    selectedLocationTempIndex = index;
    notifyListeners();
  }

  /// call on radio click, close button bottomSheet
  void updateSelectedTempTitle(int index) {
    selectedTitleTempIndex = index;
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

class DepartmentModel {
  String icon;
  String name;
  bool isDefault;

  DepartmentModel({required this.icon, required this.name, this.isDefault = false});
}

class LocationModel {
  String icon;
  String name;
  bool isDefault;

  LocationModel({required this.icon, required this.name, this.isDefault = false});
}

class TitleModel {
  String icon;
  String name;
  bool isDefault;

  TitleModel({required this.icon, required this.name, this.isDefault = false});
}