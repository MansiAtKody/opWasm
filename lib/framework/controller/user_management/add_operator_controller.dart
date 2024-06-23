import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/contract/dynamic_form_repository.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/create_dynamic_form.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_form_ui_state_new.dart';
import 'package:kody_operator/framework/repository/user_management/contract/user_management_repository.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/add_sub_operator_response_model.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/edit_sub_operator_response_model.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final addOperatorController = ChangeNotifierProvider(
  (ref) => getIt<AddOperatorController>(),
);

@injectable
class AddOperatorController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    if (isNotify) {
      notifyListeners();
    }
  }

  bool isAllFieldsValid = false;

  ///Check Validity of add/edit robot
  void checkIfAllFieldsValid() {
    isAllFieldsValid = formKey.currentState?.validate() ?? false;
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  UserManagementRepository userManagementRepository;
  DynamicFormRepository dynamicFormRepository;

  AddOperatorController(
      this.userManagementRepository, this.dynamicFormRepository);
  //
  //
  // DynamicFormUIStateNew<DynamicFormResponseModel> addSubOperatorFormState = DynamicFormUIStateNew<DynamicFormResponseModel>();
  //
  // /// Dynamic Form API
  // Future<void> addSubOperatorDynamicFormApiNew(BuildContext context) async {
  //   addSubOperatorFormState.isLoading = true;
  //   addSubOperatorFormState.success = null;
  //   notifyListeners();
  //
  //   final result = await dynamicFormRepository.addOperatorFormApi();
  //
  //   result.when(success: (data) async {
  //     addSubOperatorFormState.success = data;
  //     await DynamicForm.dynamicForm.createDynamicForm(context, addSubOperatorFormState.success, dynamicFormRepository);
  //     addSubOperatorFormState.isLoading = false;
  //   }, failure: (NetworkExceptions error) {
  //     String errorMsg = NetworkExceptions.getErrorMessage(error);
  //     showCommonErrorDialog(context: context, message: errorMsg);
  //     addSubOperatorFormState.isLoading = false;
  //   });
  //   notifyListeners();
  // }
  //
  // DynamicFormUIStateNew<DynamicFormResponseModel> editSubOperatorFormState = DynamicFormUIStateNew<DynamicFormResponseModel>();
  //
  // /// Dynamic Form API
  // Future<void> editSubOperatorDynamicFormApiNew(BuildContext context) async {
  //   editSubOperatorFormState.isLoading = true;
  //   editSubOperatorFormState.success = null;
  //   notifyListeners();
  //
  //   final result = await dynamicFormRepository.editOperatorFormApi();
  //
  //   result.when(success: (data) async {
  //     editSubOperatorFormState.success = data;
  //     await DynamicForm.dynamicForm.createDynamicForm(context, editSubOperatorFormState.success, dynamicFormRepository);
  //     editValueInOperatorController();
  //   }, failure: (NetworkExceptions error) {
  //     String errorMsg = NetworkExceptions.getErrorMessage(error);
  //     showCommonErrorDialog(context: context, message: errorMsg);
  //   });
  //
  //   editSubOperatorFormState.isLoading = false;
  //   notifyListeners();
  // }
  //
  // UIState<AddSubOperatorResponseModel> addSubOperatorState = UIState<AddSubOperatorResponseModel>();
  //
  // /// add operator api
  // Future<void> addSubOperatorApiNew(BuildContext context) async {
  //   addSubOperatorState.isLoading = true;
  //   addSubOperatorState.success = null;
  //   notifyListeners();
  //   Map<String, dynamic>? requestMap;
  //   requestMap = DynamicForm.dynamicForm
  //       .getRequestFromDynamicForm(addSubOperatorFormState.success?.data);
  //   String request = jsonEncode(requestMap);
  //   final result = await userManagementRepository.addSubOperatorApi(request);
  //
  //   result.when(success: (data) async {
  //     addSubOperatorState.success = data;
  //     if (addSubOperatorState.success?.status != ApiEndPoints.apiStatus_200) {
  //       showCommonErrorDialog(
  //           context: context, message: addSubOperatorState.success?.message ?? '');
  //     }
  //   }, failure: (NetworkExceptions error) {
  //     addSubOperatorState.isLoading = false;
  //     String errorMsg = NetworkExceptions.getErrorMessage(error);
  //     showCommonErrorDialog(context: context, message: errorMsg);
  //   });
  //   addSubOperatorState.isLoading = false;
  //   notifyListeners();
  // }
  //
  // UIState<EditSubOperatorResponseModel> editSubOperatorState = UIState<EditSubOperatorResponseModel>();
  //
  // /// add operator api
  // Future<void> editOperatorApiNew(BuildContext context, String? uuid) async {
  //   editSubOperatorState.isLoading = true;
  //   editSubOperatorState.success = null;
  //   notifyListeners();
  //   Map<String, dynamic>? requestMap;
  //   requestMap = DynamicForm.dynamicForm.getRequestFromDynamicForm(editSubOperatorFormState.success?.data, uuid: uuid);
  //   String request = jsonEncode(requestMap);
  //   final result = await userManagementRepository.editSubOperatorApi(request);
  //   result.when(success: (data) async {
  //     editSubOperatorState.success = data;
  //   }, failure: (NetworkExceptions error) {
  //     String errorMsg = NetworkExceptions.getErrorMessage(error);
  //     showCommonErrorDialog(context: context, message: errorMsg);
  //   });
  //   editSubOperatorState.isLoading = false;
  //   notifyListeners();
  // }
  //
  // UIState<SubOperatorDetailResponseModel> subOperatorDetailState = UIState<SubOperatorDetailResponseModel>();
  //
  // Future<void> subOperatorDetailApi({
  //   required BuildContext context,
  //   required String uuid,
  // }) async {
  //   subOperatorDetailState.isLoading = true;
  //   subOperatorDetailState.success = null;
  //   notifyListeners();
  //
  //   final result = await userManagementRepository.subOperatorDetail(uuid);
  //   result.when(success: (data) async {
  //     subOperatorDetailState.success = data;
  //   }, failure: (NetworkExceptions error) {
  //     subOperatorDetailState.isLoading = false;
  //     String errorMsg = NetworkExceptions.getErrorMessage(error);
  //     showCommonErrorDialog(context: context, message: errorMsg);
  //   });
  //   subOperatorDetailState.isLoading = false;
  //   notifyListeners();
  // }
  //
  // editValueInOperatorController() {
  //   SubOperatorData? responseData = subOperatorDetailState.success?.data;
  //   Map<String, dynamic>? responseMap = responseData?.toJson();
  //   DynamicFormData? dynamicResponseData = editSubOperatorFormState.success?.data;
  //   DynamicForm.dynamicForm.setDataInfields(dynamicResponseData, responseMap);
  // }

}
