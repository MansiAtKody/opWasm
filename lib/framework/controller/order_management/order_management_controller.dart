import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/home/home_menu_model.dart';
import 'package:kody_operator/framework/repository/order_management/contract/order_control_repository.dart';
import 'package:kody_operator/framework/repository/order_management/model/device_registration_request_model.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final orderManagementController = ChangeNotifierProvider(
  (ref) => getIt<OrderManagementController>(),
);

@injectable
class OrderManagementController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    trayImage = [null, null, null];
    if (isNotify) {
      notifyListeners();
    }
  }

  OrderManagementController(this.orderControlRepository);

  int? selectedIndex;

  //
  // int selectedTab = 4;

  HomeMenuOperator? selectedScreen;

  bool serviceExpanded = false;

  expandServices() {
    serviceExpanded = !serviceExpanded;
    notifyListeners();
  }

  /// Update Selected Tray
  void updateSelectedTray(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // updateTab(int index) {
  //   selectedTab = index;
  //   notifyListeners();
  // }

  List<String> trayNumber = ['1', '2', '3'];

  List<String?> trayImage = [null, null, null];

  String selectedPopUp = PopUpStatus.Available.name;

  ///update Popup
  void updatePopUp(String value) {
    selectedPopUp = value;
    notifyListeners();
  }

  /// update order tray person image
  void orderPersonImage(String? imgUrl) {
    trayImage[selectedIndex ?? 0] = imgUrl;
    notifyListeners();
  }

  bool isPressed = true;
  bool isExpanded = true;

  ///hide Tray Button
  void hideTray() {
    isPressed = false;
    notifyListeners();
  }

  ///hide Tray Button
  void hideSideMenu() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  ///show Tray Button
  void showTray() {
    isPressed = true;
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  OrderControlRepository orderControlRepository;
  UIState<CommonResponseModel> registerDeviceState = UIState<CommonResponseModel>();
  /// Register Device FCM token
  Future<void> registerDeviceFcmToken(BuildContext context) async {
    registerDeviceState.isLoading = true;
    registerDeviceState.success = null;
    notifyListeners();
    DeviceRegistrationRequestModel requestModel;

      if(kIsWeb){
        requestModel = DeviceRegistrationRequestModel(
          deviceId: Session.getNewFCMToken(),
          deviceType: 'WEB',
          userType: 'OPERATOR',
          uniqueDeviceId: Session.getNewFCMToken()
        );
      }else{
         requestModel = DeviceRegistrationRequestModel(
          deviceId: Session.getNewFCMToken(),
          deviceType: Platform.isAndroid ?'ANDROID' :'IOS',
          userType: Session.getUserEntityType(),
          uniqueDeviceId: Session.getNewFCMToken()

         );
      }

    String request = deviceRegistrationRequestModelToJson(requestModel);

    final result = await orderControlRepository.registerDeviceApi(request);

    result.when(success: (data) async {
      registerDeviceState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    registerDeviceState.isLoading = false;
    notifyListeners();
  }
}
