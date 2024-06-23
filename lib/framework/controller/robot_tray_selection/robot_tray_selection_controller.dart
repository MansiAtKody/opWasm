import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/contract/robot_tray_selection_repository.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/request_model/add_item_to_tray_request_model.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/request_model/robot_list_request_model.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/response_model/get_tray_list_response_model.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/response_model/robot_list_response_model.dart';
import 'package:kody_operator/framework/repository/order_management/contract/order_control_repository.dart';
import 'package:kody_operator/framework/repository/order_management/model/robot_details_response_model.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/robot_tray_selection_model.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final robotTraySelectionController = ChangeNotifierProvider(
    (ref) => getIt<RobotTraySelectionModuleController>());

@injectable
class RobotTraySelectionModuleController extends ChangeNotifier {
  OrderControlRepository orderRepository;

  RobotTraySelectionModuleController(
      this.orderRepository, this.robotTraySelectionRepository);

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    selectedRobotIndex = null;
    selectedTrayButtonIndex = null;
    isChecked = false;
    selectedRobotNew = null;
    selectedTrayNumber = null;
    orderItemUuidList = [];
    pageNoForRobotListApi = 1;
    robotList = [];
    robotListForOrder = [];
    trayDataList = [];
    isSwitchLoading = false;
    isRobotAvailable = false;
    if (isNotify) {
      notifyListeners();
    }
  }

  bool isRobotAvailable = false;

  bool isSwitchLoading = false;

  updateSwitchLoading(bool value){
    isSwitchLoading = value;
    notifyListeners();
  }


  updateRobotStatus(){
      isRobotAvailable = !isRobotAvailable;
    notifyListeners();
  }

  changeRobotSwitchStatus(){
    if(selectedRobotNew?.state == RobotTrayStatusEnum.AVAILABLE.name){
      isRobotAvailable = true;
    }
    else {
      isRobotAvailable = false;
    }
    notifyListeners();
  }

  ScrollController gridScrollController = ScrollController();

  AnimationController? trayBoxAnimationController;

  updateTrayBoxAnimationController(
      AnimationController? trayBoxAnimationController) {
    this.trayBoxAnimationController = trayBoxAnimationController;
    notifyListeners();
  }

  AnimationController? orderBoxAnimationController;

  updateOrderBoxAnimationController(
      AnimationController? orderBoxAnimationController) {
    this.orderBoxAnimationController = orderBoxAnimationController;
    notifyListeners();
  }


  /// Robot Status List
  List<RobotTrayStatusModel> robotTrayStatusModelList = [
    // RobotTrayStatusModel(
    //   robotId: 'AidZ-r4nW-Wlhq-kbR7-',
    //   robotEntityId: 1,
    //   robotEntityType: 'ROBOT',
    //   robotName: 'Kody Robot',
    //   status: RobotTrayStatusEnum.AVAILABLE,
    // ),
  ];

  List<RobotTrayStatusEnum> robotTrayStatusList = [RobotTrayStatusEnum.AVAILABLE, RobotTrayStatusEnum.UNAVAILABLE, RobotTrayStatusEnum.SERVING];

  updateRobot() async {
    robotTrayStatusModelList[0].status =
        robotTrayStatusValues.map[robotDetailsState.success?.data?.state];
    robotTrayStatusModelList[0].robotEntityId = 1;
    robotTrayStatusModelList[0].robotId = robotDetailsState.success?.data?.uuid;
    robotTrayStatusModelList[0].robotTrayList = List.generate(
      robotDetailsState.success?.data?.numberOfTray ?? 0,
      (index) =>
          RobotTrayModel(trayId: (index + 1), trayName: 'Tray ${(index + 1)}'),
    );
    notifyListeners();
  }

  updateRobotList(List<RobotListResponseData> robotUpdatedList){
      robotList = robotUpdatedList;
      robotListForOrder = robotUpdatedList;
      notifyListeners();
  }

  UIState<RobotDetailsResponseModel> robotDetailsState =
      UIState<RobotDetailsResponseModel>();

  Future<void> getRobotDetailsApi(BuildContext context) async {
    robotDetailsState.isLoading = true;
    robotDetailsState.success = null;

    notifyListeners();

    final result =
        await orderRepository.getRobotDetails(selectedRobotNew?.uuid ?? '');

    result.when(success: (data) async {
      robotDetailsState.success = data;
      robotDetailsState.isLoading = false;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      robotDetailsState.isLoading = false;
      showCommonErrorDialog(context: context, message: errorMsg);
    });
    notifyListeners();
  }

  ///------------------------------ variable for tray management--------------------------///

  /// Selected Robot Index
  int? selectedRobotIndex;

  /// Update Selected Robot
  void updateRobotIndex(int index) {
    selectedRobotIndex = index;
    notifyListeners();
  }

  /// Selected Tray Button Index
  int? selectedTrayButtonIndex;

  ///Update Selected Button Index
  void updateTrayButtonIndex(int index) {
    selectedTrayButtonIndex = index;
    notifyListeners();
  }

  ///Animation Controller for dialog
  AnimationController? animationController;

  updateAnimationController(AnimationController animationController) {
    this.animationController = animationController;
    notifyListeners();
  }

  /// Item List Tile Checkbox
  bool isChecked = false;

  updateItemListTileChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }

  /// Get Selected Tray Color
  Color getSelectedTrayColor({required int? selectedTrayNumber}) {
    return this.selectedTrayNumber == selectedTrayNumber
        ? AppColors.blue009AF1
        : selectedTrayNumber == null
            ? AppColors.greyCACACA.withOpacity(0.5)
            : AppColors.greyCACACA;
  }

  /// Get Robot Tray Status text, color, Robot Tray Status based on Robot Tray Status
  RobotTrayStatusStyle getRobotTrayStatusTextColor(
      RobotTrayStatusEnum robotTrayStatusEnum) {
    RobotTrayStatusStyle robotTrayStatusStyle;
    switch (robotTrayStatusEnum) {
      case RobotTrayStatusEnum.AVAILABLE:
        {
          robotTrayStatusStyle = RobotTrayStatusStyle(
            robotTrayStatus: robotTrayStatusValues
                .reverse[RobotTrayStatusEnum.AVAILABLE]
                .toString(),
            robotTrayStatusTextColor: AppColors.green14B500,
          );
        }
        break;
      case RobotTrayStatusEnum.UNAVAILABLE:
        {
          robotTrayStatusStyle = RobotTrayStatusStyle(
            robotTrayStatus: robotTrayStatusValues
                .reverse[RobotTrayStatusEnum.UNAVAILABLE]
                .toString(),
            robotTrayStatusTextColor: AppColors.redEE0000,
          );
        }
        break;
      case RobotTrayStatusEnum.SERVING:
        {
          robotTrayStatusStyle = RobotTrayStatusStyle(
            robotTrayStatus: robotTrayStatusValues
                .reverse[RobotTrayStatusEnum.SERVING]
                .toString(),
            robotTrayStatusTextColor: AppColors.clr009AF1,
          );
        }
        break;

      case RobotTrayStatusEnum.PAUSE:
        {
          robotTrayStatusStyle = RobotTrayStatusStyle(
            robotTrayStatus: robotTrayStatusValues
                .reverse[RobotTrayStatusEnum.PAUSE]
                .toString(),
            robotTrayStatusTextColor: AppColors.clr009AF1,
          );
        }
        break;

      case RobotTrayStatusEnum.EMERGENCY_STOP:
        {
          robotTrayStatusStyle = RobotTrayStatusStyle(
            robotTrayStatus: robotTrayStatusValues
                .reverse[RobotTrayStatusEnum.EMERGENCY_STOP]
                .toString(),
            robotTrayStatusTextColor: AppColors.clr009AF1,
          );
        }
        break;

      case RobotTrayStatusEnum.IN_CHARGING:
        {
          robotTrayStatusStyle = RobotTrayStatusStyle(
            robotTrayStatus: robotTrayStatusValues
                .reverse[RobotTrayStatusEnum.IN_CHARGING]
                .toString(),
            robotTrayStatusTextColor: AppColors.clr009AF1,
          );
        }
        break;
    }
    return robotTrayStatusStyle;
  }

  RobotListResponseData? selectedRobotNew;

  Future<void> updateSelectedRobotNew(BuildContext context, {RobotListResponseData? selectedRobot}) async {
    selectedRobotNew = selectedRobot;
    selectedTrayNumber = null;
    trayDataList = [];
    if(selectedRobot?.state == RobotTrayStatusEnum.AVAILABLE.name){
      isRobotAvailable = true;
    }
    else {
      isRobotAvailable = false;
    }
    for(int i=1; i <= (selectedRobotNew?.numberOfTray ?? 0) ; i++){
      selectedTrayNumber = i;
      trayDataList?.add(null);
      await getTrayListApi(context);
    }

    selectedTrayNumber = 1;
    notifyListeners();
  }

  Future<void> updateSelectedRobotForDispatchOrder(BuildContext context, {RobotListResponseData? selectedRobot}) async {
    selectedRobotNew = selectedRobot;
    if(selectedRobot?.state == RobotTrayStatusEnum.AVAILABLE.name){
      isRobotAvailable = true;
    }
    else {
      isRobotAvailable = false;
    }
    notifyListeners();
  }

  int? selectedTrayNumber;

  Future<void> updateSelectedTrayNumber(BuildContext context, int trayNumber) async {
    selectedTrayNumber = trayNumber;
    notifyListeners();
  }

  List<String> orderItemUuidList = [];

  void clearOrderItemUuidList(){
    orderItemUuidList.clear();
  }

  void updateOrderItemUuidList(String uuid) {
    if (orderItemUuidList.contains(uuid)) {
      orderItemUuidList.remove(uuid);
    } else {
      orderItemUuidList.add(uuid);
    }
    notifyListeners();
  }

  List<GetTrayListResponseModel?>? trayDataList;

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  RobotTraySelectionRepository robotTraySelectionRepository;

  var robotListState = UIState<RobotListResponseModel>();
  var addItemToTrayState = UIState<CommonResponseModel>();
  var deleteItemFromTrayState = UIState<CommonResponseModel>();
  var getTrayListState = UIState<GetTrayListResponseModel>();

  int pageNoForRobotListApi = 1;
  List<RobotListResponseData> robotList = [];
  List<RobotListResponseData> robotListForOrder= [];

  /// robot list API
  Future<void> robotListApi(BuildContext context) async {
    /// increase page number
    if(robotListState.success?.hasNextPage ?? false){
      pageNoForRobotListApi += 1;
    }
    /// set loading status and clear notificationList
    if(pageNoForRobotListApi == 1){
      robotList.clear();
      robotListForOrder.clear();
      robotListState.isLoading = true;
    }
    else{
      robotListState.isLoadMore = true;
    }
    robotListState.success = null;
    notifyListeners();

    String request = robotListRequestModelToJson(RobotListRequestModel(operatorUuid: Session.getUuid()));

    final result = await robotTraySelectionRepository.robotListApi(request, pageNoForRobotListApi);

    result.when(success: (data) async {
      robotListState.success = data;
      if (robotListState.success?.status == ApiEndPoints.apiStatus_200) {
        robotList.addAll(robotListState.success?.data ?? []);
        robotListForOrder.addAll(robotListState.success?.data ?? []);
        updateSelectedRobotNew(context, selectedRobot: robotList.where((element) => element.state == RobotTrayStatusEnum.AVAILABLE.name).firstOrNull);

      }
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });
    robotListState.isLoading = false;
    robotListState.isLoadMore = false;
    notifyListeners();
  }

  /// addItemToTrayApi
  Future<void> addItemToTrayApi(BuildContext context) async {
    addItemToTrayState.isLoading = true;
    addItemToTrayState.success = null;
    notifyListeners();

    List<TrayManagementList> trayManagementList = [];
    for(String item in orderItemUuidList){
      trayManagementList.add(TrayManagementList(ordersItemUuid: item));
    }
    String request = addItemToTrayRequestModelToJson(AddItemToTrayRequestModel(
        robotUuid: selectedRobotNew?.uuid,
        trayNumber: selectedTrayNumber,
        trayManagementList: trayManagementList
    ));

    final result = await robotTraySelectionRepository.addItemToTrayApi(request);

    result.when(success: (data) async {
      addItemToTrayState.success = data;
    }, failure: (NetworkExceptions error) {
      Navigator.pop(context);
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    addItemToTrayState.isLoading = false;
    notifyListeners();
  }

  /// deleteItemFromTrayApi
  Future<void> deleteItemFromTrayApi(BuildContext context, String uuid) async {
    deleteItemFromTrayState.isLoading = true;
    deleteItemFromTrayState.success = null;
    notifyListeners();

    final result = await robotTraySelectionRepository.deleteItemFromTrayApi(uuid);

    result.when(success: (data) async {
      deleteItemFromTrayState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    deleteItemFromTrayState.isLoading = false;
    notifyListeners();
  }

  /// getTrayListApi
  Future<void> getTrayListApi(BuildContext context) async {
    getTrayListState.isLoading = true;
    getTrayListState.success = null;
    notifyListeners();

    final result = await robotTraySelectionRepository.getTrayListApi(
        selectedRobotNew?.uuid ?? '', selectedTrayNumber ?? 1);

    result.when(success: (data) async {
      getTrayListState.success = data;
      if(getTrayListState.success?.status == ApiEndPoints.apiStatus_200){
        if(selectedTrayNumber != null) {
          trayDataList?[selectedTrayNumber! - 1] = getTrayListState.success;
        }
      }
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    getTrayListState.isLoading = false;
    notifyListeners();
  }
}
