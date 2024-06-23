import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/user_management/user_management_controller.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/user_management/mobile/helper/add_edit_sub_operator_dialog.dart';
import 'package:kody_operator/ui/utils/helpers/common_dialog_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonUserListTile extends StatelessWidget {
  final SubOperatorData? subOperatorData;
  final void Function(bool) onSwitchTap;
  final int index;

  const CommonUserListTile({Key? key, required this.subOperatorData, required this.onSwitchTap,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteF7F7FC,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          /// Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                title: LocalizationStrings.keyName.localized,
                textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.grey8D8C8C),
                maxLines: 3,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CommonText(
                  title: subOperatorData?.name??'',
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 3,
                ),
              )
            ],
          ).paddingOnly(bottom: 30.h),

          /// Status
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     CommonText(
          //       title: LocalizationStrings.keyStatus.localized,
          //       textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.grey8D8C8C),
          //     ),
          //     subOperatorData?.active??false
          //         ? ShowDownTransition(
          //             duration: 200,
          //             child: UserActiveInactiveWidgetMobile(
          //               borderColor: AppColors.green14B500,
          //               title: LocalizationStrings.keyActive.localized,
          //             ),
          //           )
          //         : SlideUpTransition(
          //             duration: 200,
          //             child: UserActiveInactiveWidgetMobile(
          //               borderColor: AppColors.redEE0000,
          //               title: LocalizationStrings.keyInActive.localized,
          //             ),
          //           ),
          //   ],
          // ).paddingOnly(bottom: 18.h),

          /// Email id
          Row(
            children: [
              CommonText(
                title: LocalizationStrings.keyEmailId.localized,
                textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.grey8D8C8C),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 4,
                child: CommonText(
                  title: subOperatorData?.email??'',
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
              ),
            ],
          ).paddingOnly(bottom: 28.h),

          /// Status toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                title: LocalizationStrings.keyActiveInactive.localized,
                textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.grey8D8C8C),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final userManagementWatch = ref.watch(userManagementController);
                  if(userManagementWatch.activateDeactivateSubOperatorState.isLoading && userManagementWatch.updatingSubOperatorIndex == index){
                    return LoadingAnimationWidget.waveDots(color: AppColors.black, size: 22.h).alignAtCenterLeft().paddingOnly(left: 5.w);
                  }
                  else{
                    return Transform.scale(
                      scale: 1.3,
                      child: CommonCupertinoSwitch(
                        switchValue: subOperatorData?.active??false,
                        onChanged: (switchValue) {
                          onSwitchTap(switchValue);
                        },
                      ).paddingOnly(left: 5.w),
                    );
                  }

                },
              ),
            ],
          ),

          ///Divider
          Visibility(
            visible: subOperatorData?.active ?? false,
            child: Column(
              children: [
                const Divider(
                  color: AppColors.greyDADADA,
                ).paddingOnly(top: 20.h),

                ///Edit
                InkWell(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CommonDialogWidget(
                            child: SizedBox(
                                height: context.height*0.5,
                                child: AddEditSubOperatorDialog(uuid: subOperatorData?.uuid??'',subOperatorData: subOperatorData,))
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      ///Edit Icon
                      CommonSVG(strIcon: AppAssets.svgEdit,height: 24.h,width: 24.w),
                      ///Edit
                      CommonText(
                        title: LocalizationStrings.keyEdit.localized,
                        textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.grey8D8C8C, decoration: TextDecoration.underline,),
                      ),
                      const Spacer(),
                      ///Right Arrow
                      CommonSVG(strIcon: AppAssets.svgRightArrow,height: 24.h,width: 24.w),
                    ],
                  ),
                ).paddingSymmetric(vertical: 20.h),
              ],
            ),
          )
        ],
      ).paddingOnly(left: 19.w,top: 25.h,right: 19.w,bottom: subOperatorData?.active ?? false ?5.h:25.h),
    );
  }
}
