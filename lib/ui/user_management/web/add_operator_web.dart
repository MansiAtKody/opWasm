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
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class AddOperatorWeb extends ConsumerStatefulWidget {
  final SubOperatorData? subOperatorData;
  final String? uuid;

  const AddOperatorWeb({Key? key, this.subOperatorData, this.uuid})
      : super(key: key);

  @override
  ConsumerState<AddOperatorWeb> createState() => _AddOperatorWebState();
}

class _AddOperatorWebState extends ConsumerState<AddOperatorWeb>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  Widget buildPage(BuildContext context) {
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
  // ///Dispose Override
  // @override
  // void dispose() {
  //   super.dispose();
  // }
  //
  // ///Build Override
  // @override
  // Widget buildPage(BuildContext context) {
  //   final addOperatorWatch = ref.watch(addOperatorController);
  //   DynamicFormData? responseData;
  //   if (widget.uuid != null) {
  //     responseData = addOperatorWatch.editSubOperatorFormState.success?.data;
  //   } else {
  //     responseData = addOperatorWatch.addSubOperatorFormState.success?.data;
  //   }
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             InkWell(
  //                 onTap: () {
  //                   ref.read(navigationStackProvider).pop();
  //                 },
  //                 child: CommonSVG(
  //                   strIcon: AppAssets.svgBackArrow,
  //                   height: 14.h,
  //                   width: 14.w,
  //                 ).paddingOnly(right: 22.w)),
  //             CommonText(
  //               title: widget.uuid != null
  //                   ? LocalizationStrings.keyEditSubOperator.localized
  //                   : LocalizationStrings.keyAddSubOperator.localized,
  //               textStyle: TextStyles.regular
  //                   .copyWith(color: AppColors.clr171717, fontSize: 24.sp),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: context.height * 0.03),
  //         Expanded(
  //           child: addOperatorWatch.addSubOperatorFormState.isLoading ||
  //                   addOperatorWatch.editSubOperatorFormState.isLoading
  //               ? const Center(
  //                   child: CircularProgressIndicator(color: AppColors.black))
  //               : Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     ///Form
  //                     Expanded(
  //                       child: DynamicFormWidget(
  //                           responseData: responseData,
  //                           formKey: addOperatorWatch.formKey),
  //                     ),
  //
  //                     ///Button
  //                     CommonButton(
  //                       height: 49.h,
  //                       width: 161.w,
  //                       buttonText: widget.uuid != null
  //                           ? LocalizationStrings.keyUpdate.localized
  //                           : LocalizationStrings.keyCreate.localized,
  //                       buttonEnabledColor: AppColors.primary2,
  //                       buttonDisabledColor: AppColors.grey8D8C8C,
  //                       isButtonEnabled: true,
  //                       buttonTextSize: 14.sp,
  //                       buttonTextColor: AppColors.white,
  //                       isLoading: addOperatorWatch.addSubOperatorState.isLoading || addOperatorWatch.editSubOperatorState.isLoading,
  //                       onTap: () async {
  //                         bool? isValidate = addOperatorWatch.formKey.currentState?.validate();
  //                         if (isValidate == true) {
  //                           if (widget.uuid != null) {
  //                             editOperatorApi(context);
  //                           } else {
  //                             addOperatorApi(context);
  //                           }
  //                         }
  //                       },
  //                     )
  //                   ],
  //                 ),
  //         ),
  //       ],
  //     ).paddingSymmetric(horizontal: 35.w, vertical: 35.h),
  //   ).paddingSymmetric(vertical: 40.h, horizontal: 40.w);
  // }
  //
  // Future<void> addOperatorApi(BuildContext context) async {
  //   final addOperatorWatch = ref.read(addOperatorController);
  //   final userManagementWatch = ref.read(userManagementController);
  //   addOperatorWatch.addSubOperatorApiNew(context).then((value) {
  //     if (addOperatorWatch.addSubOperatorState.success?.status ==
  //         ApiEndPoints.apiStatus_200) {
  //       ref.read(navigationStackProvider).pop();
  //       userManagementWatch.subOperatorListApi(context, pageNumber: 1);
  //     }
  //   });
  // }
  //
  // Future<void> editOperatorApi(BuildContext context) async {
  //   final addOperatorWatch = ref.read(addOperatorController);
  //   final userManagementWatch = ref.read(userManagementController);
  //   addOperatorWatch.editOperatorApiNew(context, widget.uuid).then((value) {
  //     if (addOperatorWatch.editSubOperatorFormState.success?.status ==
  //         ApiEndPoints.apiStatus_200) {
  //       ref.read(navigationStackProvider).pop();
  //       userManagementWatch.subOperatorListApi(context, pageNumber: 1);
  //     }
  //   });
  // }
}
