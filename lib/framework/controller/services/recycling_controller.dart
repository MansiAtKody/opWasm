import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/repository/service/department_model.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';

final recyclingController = ChangeNotifierProvider(
  (ref) => getIt<RecyclingController>(),
);

@injectable
class RecyclingController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  /// Recycling Select Location
  TextEditingController departmentNameController = TextEditingController();

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    departmentNameController.text = departmentList[0].name;
    isDepartmentListVisible = false;
    selectedDepartmentIndex = 0;
    resetFormKey();
    if (isNotify) {
      notifyListeners();
    }
  }

  /// Reset Form Key
  void resetFormKey() {
    Future.delayed(const Duration(milliseconds: 100), () {
      formKey.currentState?.reset();
    });
  }

  bool isSuffixUp = false;

  void updateSuffix() {
    isSuffixUp = !isSuffixUp;
    notifyListeners();
  }

  /// Selected Department Index
  int selectedDepartmentIndex = 0;

  List<DepartmentModel> departmentList = [
    // DepartmentModel(icon: AppAssets.svgAll, name: 'All'),
    DepartmentModel(icon: AppAssets.svgUiUx, name: 'UI/UX Team'),
    DepartmentModel(icon: AppAssets.svgPhp, name: 'PHP Team'),
    DepartmentModel(icon: AppAssets.svgMobile, name: 'Mobile Team'),
    DepartmentModel(icon: AppAssets.svgBd, name: 'Business Development Team'),
    DepartmentModel(icon: AppAssets.svgJava, name: 'Java Team'),
    DepartmentModel(icon: AppAssets.svgRobotics, name: 'Robotics Team'),
    DepartmentModel(icon: AppAssets.svgMarketing, name: 'Marketing Team'),
  ];

  /// call on continue button
  void updateSelectedDepartment(int index) {
    selectedDepartmentIndex = index;
    departmentNameController.text = departmentList[index].name;
    notifyListeners();
  }

  /// TO Show/ Hide Department List
  bool isDepartmentListVisible = false;

  /// Show / Hide Department List Widget
  void showAndHideDepartmentList() {
    if (isDepartmentListVisible == false) {
      isDepartmentListVisible = true;
    } else {
      isDepartmentListVisible = false;
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
