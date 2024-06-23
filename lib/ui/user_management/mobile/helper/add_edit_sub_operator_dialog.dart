// ignore_for_file: use_build_context_synchronously
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/user_management/add_operator_controller.dart';
import 'package:kody_operator/framework/controller/user_management/user_management_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_form_widget.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class AddEditSubOperatorDialog extends ConsumerStatefulWidget {
  final SubOperatorData? subOperatorData;
  final String? uuid;

  const AddEditSubOperatorDialog({super.key, this.subOperatorData, this.uuid});

  @override
  ConsumerState<AddEditSubOperatorDialog> createState() =>
      _AddEditSubOperatorDialogState();
}

class _AddEditSubOperatorDialogState
    extends ConsumerState<AddEditSubOperatorDialog> {
  Widget build(BuildContext context) {
    return SizedBox();
  }
  ///Init Override
  // @override
  // void initState() {
  //   super.initState();
  //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
  //     final addOperatorWatch = ref.read(addOperatorController);
  //     if (widget.uuid != null) {
  //       addOperatorWatch
  //           .subOperatorDetailApi(context: context, uuid: widget.uuid ?? '')
  //           .then((value) async {
  //         await addOperatorWatch.editSubOperatorDynamicFormApiNew(context);
  //       });
  //     } else {
  //       await addOperatorWatch.addSubOperatorDynamicFormApiNew(context);
  //     }
  //   });
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   final addOperatorWatch = ref.watch(addOperatorController);
  //   DynamicFormData? responseData;
  //   if (widget.uuid != null) {
  //     responseData = addOperatorWatch.editSubOperatorFormState.success?.data;
  //   } else {
  //     responseData = addOperatorWatch.addSubOperatorFormState.success?.data;
  //   }
  //   return addOperatorWatch.addSubOperatorFormState.isLoading || addOperatorWatch.editSubOperatorFormState.isLoading
  //       ? const Center(child: CircularProgressIndicator(color: AppColors.black))
  //       : Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 CommonText(
  //                   title: widget.uuid != null
  //                       ? LocalizationStrings.keyEditSubOperator.localized
  //                       : LocalizationStrings.keyAddSubOperator.localized,
  //                   textStyle: TextStyles.medium
  //                       .copyWith(color: AppColors.black, fontSize: 18.sp),
  //                 ),
  //                 InkWell(
  //                   onTap: (){
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: const CommonSVG(
  //                     strIcon: AppAssets.svgCrossIcon,
  //                   ),
  //                 )
  //               ],
  //             ).paddingOnly(bottom: 20.h),
  //
  //             ///Form
  //             Expanded(
  //               child: DynamicFormWidget(
  //                   responseData: responseData,
  //                   formKey: addOperatorWatch.formKey),
  //             ),
  //
  //             ///Button
  //             CommonButtonMobile(
  //                     buttonText: LocalizationStrings.keySave.localized,
  //                     isButtonEnabled: true,
  //                     buttonTextColor: AppColors.primary2,
  //                     borderColor: AppColors.primary2,
  //                     buttonEnabledColor: AppColors.white,
  //                     loadingAnimationColor: AppColors.primary2,
  //                     isLoading: addOperatorWatch.addSubOperatorState.isLoading || addOperatorWatch.editSubOperatorState.isLoading,
  //                     onTap: () async {
  //                       bool? isValidate = addOperatorWatch.formKey.currentState?.validate();
  //                       if (isValidate == true) {
  //                         if (widget.uuid != null) {
  //                           await editOperatorApi(context);
  //                         } else {
  //                           await addOperatorApi(context);
  //                         }
  //                       }
  //                     },
  //                   ),
  //           ],
  //         ).paddingSymmetric(horizontal: 17.w, vertical: 30.h);
  // }
  //
  // /// Add operator api call
  // Future<void> addOperatorApi(BuildContext context) async {
  //   final addOperatorWatch = ref.read(addOperatorController);
  //   final userManagementWatch = ref.read(userManagementController);
  //   await addOperatorWatch.addSubOperatorApiNew(context);
  //   if(addOperatorWatch.addSubOperatorState.success?.status == ApiEndPoints.apiStatus_200){
  //     if(context.mounted){
  //       Navigator.pop(context);
  //       await userManagementWatch.subOperatorListApi(context, pageNumber: 1);
  //     }
  //   }
  // }
  //
  // /// Edit operator api call
  // Future<void> editOperatorApi(BuildContext context) async {
  //   final addOperatorWatch = ref.read(addOperatorController);
  //   final userManagementWatch = ref.read(userManagementController);
  //   await addOperatorWatch.editOperatorApiNew(context, widget.uuid);
  //   if(addOperatorWatch.addSubOperatorState.success?.status == ApiEndPoints.apiStatus_200){
  //     if(context.mounted){
  //       Navigator.pop(context);
  //       await userManagementWatch.subOperatorListApi(context, pageNumber: 1);
  //     }
  //   }
  // }
}
