import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/profile_detail_response_model.dart';
import 'package:kody_operator/framework/repository/select_location/contract/select_location_repository.dart';
import 'package:kody_operator/framework/repository/select_location/model/location_list_response_model.dart';
import 'package:kody_operator/framework/repository/select_location/model/location_point_list_response_model.dart';
import 'package:kody_operator/framework/repository/select_location/model/location_point_request_model.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final selectLocationDialogController = ChangeNotifierProvider(
  (ref) => getIt<SelectLocationDialogController>(),
);

@injectable
class SelectLocationDialogController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    searchController.clear();
    searchLocationList.clear();
    clearTempVariables();
    if (isNotify) {
      notifyListeners();
    }
  }

  /// Text Editing Controller for Search location field
  TextEditingController searchController = TextEditingController();

  /// Searched Location List
  List<LocationResponseModel> searchLocationList = [];

  /// Selected Location
  LocationResponseModel? selectedLocation;

  /// Temporary Location
  LocationResponseModel? tempSelectedLocation;

  /// Selected Location Point
  LocationPointResponseModel? selectedLocationPoint;

  /// Temporary Location point
  LocationPointResponseModel? tempSelectedLocationPoint;

  /// Update Temporary Selected location point
  void updateTempSelectedLocation(int index) {
    tempSelectedLocation = locationListState.success?.data?[index];
    notifyListeners();
  }

  void onLocationBottomSheetOpened() {
    tempSelectedLocationPoint = selectedLocationPoint;
    searchController.clear();
    searchLocationList.clear();
    notifyListeners();
  }

  /// If search list is not empty return length of searched location else return location list
  int getLocationListLength() {
    if (searchLocationList.isNotEmpty) {
      return searchLocationList.length;
    } else {
      return locationListState.success?.data?.length ?? 0;
    }
  }

  /// Save Location and Location Point
  void selectLocation() {
    selectedLocationPoint = tempSelectedLocationPoint;
    selectedLocation = locationListState.success?.data?.firstWhere((element) =>
        element.uuid == tempSelectedLocationPoint?.locationUuid);
    tempSelectedLocation = locationListState.success?.data?.firstWhere((element) =>
        element.uuid == tempSelectedLocationPoint?.locationUuid);
    notifyListeners();
  }

  /// Clear Temporary variables once value is saved
  void clearTempVariables() {
    tempSelectedLocation = null;
    tempSelectedLocationPoint = null;
    notifyListeners();
  }

  /// To update Location List on Search
  void onSearch() {
    searchLocationList = locationListState.success?.data?.where((element) => element.name?.trim().toLowerCase().contains(searchController.text.toLowerCase().trim()) ?? false).toList() ?? [];
    notifyListeners();
  }

  /// To clear searched location list
  void clearSearch() {
    searchController.clear();
    searchLocationList.clear();
    notifyListeners();
  }

  /// Update Temporary location point
  void updateTempSelectedLocationPoint(int index) {
    tempSelectedLocationPoint = locationPointListState.success?.data?[index];
    notifyListeners();
  }

  /// Validate Location and Location point before saving
  bool checkLocationValidation() {
    return (tempSelectedLocation != null &&
            tempSelectedLocationPoint != null) ||
        (selectedLocation != null && selectedLocationPoint != null);
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */
  SelectLocationRepository selectLocationRepository;

  SelectLocationDialogController(this.selectLocationRepository);

  UIState<LocationListResponseModel> locationListState =
      UIState<LocationListResponseModel>();
  UIState<LocationPointListResponseModel> locationPointListState =
      UIState<LocationPointListResponseModel>();
  UIState<ProfileDetailResponseModel> profileDetailState =
      UIState<ProfileDetailResponseModel>();

  /// Location List API
  Future<void> getLocationListApi(BuildContext context) async {
    locationListState.isLoading = true;
    locationListState.success = null;
    notifyListeners();

    final result = await selectLocationRepository.getLocationListApi(pageNumber: 1);

    result.when(
      success: (data) async {
        locationListState.success = data;
      },
      failure: (NetworkExceptions error) {
        String errorMsg = NetworkExceptions.getErrorMessage(error);
        showCommonErrorDialog(context:context,  message: errorMsg);
      },
    );

    locationListState.isLoading = false;
    notifyListeners();
  }

  /// Location List API
  Future<void> getLocationPointListApi(BuildContext context,int index) async {
    locationPointListState.isLoading = true;
    locationPointListState.success = null;
    notifyListeners();

    LocationPointRequestModel requestModel = LocationPointRequestModel(locationUuid: locationListState.success?.data?[index].uuid);
    final String request = locationPointRequestModelToJson(requestModel);
    final result = await selectLocationRepository.getLocationPointListApi(pageNumber: 1, request: request);

    result.when(success: (data) async {
      locationPointListState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context:context,message: errorMsg);
    });
    locationPointListState.isLoading = false;
    notifyListeners();
  }

  ///get profile detail api
  Future<void> getProfileDetail(BuildContext context) async {
    profileDetailState.isLoading = true;
    profileDetailState.success = null;
    notifyListeners();

    final result = await selectLocationRepository.getProfileDetail();
    result.when(
      success: (data) async {
        profileDetailState.success = data;
      },
      failure: (NetworkExceptions error) {
        String errorMsg = NetworkExceptions.getErrorMessage(error);
        showCommonErrorDialog(context:context,message: errorMsg);
      },
    );
    profileDetailState.isLoading = false;

    notifyListeners();
  }
}
