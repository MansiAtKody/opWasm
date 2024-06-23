import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/user_management/contract/user_management_repository.dart';
import 'package:kody_operator/framework/repository/user_management/model/request_model/sub_operator_list_request_model.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_list_response_model.dart';
import 'package:kody_operator/framework/repository/user_management/model/user_model.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final userManagementController = ChangeNotifierProvider(
  (ref) => getIt<UserManagementController>(),
);

@injectable
class UserManagementController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = true;
    pageNo = 1;

    if (isNotify) {
      notifyListeners();
    }
  }

  ///List of users to be displayed
  List<User> users = [
    User(
      userName: 'Operator1',
      email: 'maharaj1@gmail.com',
      userStatus: UserStatus.active,
    ),
    User(
      userName: 'Operator2',
      email: 'maharaj2@gmail.com',
      userStatus: UserStatus.active,
    ),
    User(
      userName: 'Operator3',
      email: 'maharaj3@gmail.com',
      userStatus: UserStatus.active,
    ),
    User(
      userName: 'Operator4',
      email: 'maharaj4@gmail.com',
      userStatus: UserStatus.active,
    ),
    User(
      userName: 'Operator4',
      email: 'maharaj4@gmail.com',
      userStatus: UserStatus.active,
    ),
    User(
      userName: 'Operator4',
      email: 'maharaj4@gmail.com',
      userStatus: UserStatus.active,
    ),
  ];

  /// Update Individual User's status in users list
  void updateStatus(int index) {
    if (users[index].userStatus == UserStatus.active) {
      users[index].userStatus = UserStatus.inactive;
    } else {
      users[index].userStatus = UserStatus.active;
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


  UserManagementRepository userManagementRepository;
  UserManagementController(this.userManagementRepository);
  List<SubOperatorData> subOperatorList = [];
  int pageNo = 1;
  var subOperatorState = UIState<SubOperatorListResponseModel>();

  ///Sub Operator List API
  Future<void> subOperatorListApi(BuildContext context, {int? pageNumber,bool isWeb=false}) async {
    if(isWeb==false){
      if ((pageNumber != 1) && (subOperatorState.success?.hasNextPage??false)) {
        subOperatorState.isLoadMore=true;
        pageNo = (subOperatorState.success?.pageNumber ?? 1) + 1;
      }
      else{
        pageNo=1;
        subOperatorList.clear();
        subOperatorState.isLoading=true;
      }
    }
    else{
      subOperatorState.isLoading=true;
    }
    notifyListeners();

    SubOperatorListRequestModel requestModel = SubOperatorListRequestModel(searchKeyword: '', active: null);
    String request = subOperatorListRequestModelToJson(requestModel);

    final result = await userManagementRepository.subOperatorListApi(isWeb?pageNumber ?? 1:pageNo,request);

    result.when(success: (data) async {
      subOperatorState.success = data;
      if (isWeb==false) {
        subOperatorList.addAll(subOperatorState.success?.data ?? []);
      }
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
          showCommonErrorDialog(context: context, message: errorMsg);
        });

    subOperatorState.isLoading = false;
    subOperatorState.isLoadMore=false;
    notifyListeners();
  }

  ///Activate/Deactivate Attribute Api
  UIState<CommonResponseModel> activateDeactivateSubOperatorState = UIState<CommonResponseModel>();

  int? updatingSubOperatorIndex;

  Future activateDeactivateSubOperatorApi(BuildContext context, String uuid, bool isActive) async {
    activateDeactivateSubOperatorState.isLoading = true;
    activateDeactivateSubOperatorState.success = null;
    updatingSubOperatorIndex = subOperatorState.success?.data?.indexWhere((element) => element.uuid == uuid);
    notifyListeners();

    ApiResult apiResult = await userManagementRepository.activeDeactivateSubOperatorApi(uuid, isActive);
    apiResult.when(
      success: (data) {
        activateDeactivateSubOperatorState.isLoading = false;
        activateDeactivateSubOperatorState.success = data;
        subOperatorState.success?.data?.where((element) => element.uuid == uuid).firstOrNull?.active = isActive;
        notifyListeners();
      },
      failure: (NetworkExceptions error) {
        activateDeactivateSubOperatorState.isLoading = false;
        String errorMsg = NetworkExceptions.getErrorMessage(error);
        showCommonErrorDialog(context: context, message: errorMsg);
        notifyListeners();
      },
    );
  }

}
