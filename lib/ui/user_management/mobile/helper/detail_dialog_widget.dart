import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/user_management/user_management_controller.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailDialogWidget extends ConsumerWidget with BaseConsumerWidget {
  final SubOperatorData? subOperatorData;
  final Function(bool value) onSwitchTap;
  final int index;

  const DetailDialogWidget({Key? key, required this.subOperatorData, required this.onSwitchTap, required this.index}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Image
        ClipOval(
          child: CachedNetworkImage(height: 103.h, width: 103.h, imageUrl: subOperatorData?.profileImage?? appName),
        ).paddingOnly(bottom: 11.h),

        /// Name
        CommonText(
          title: subOperatorData?.name??'',
          textStyle: TextStyles.medium.copyWith(fontSize: 18.sp, color: AppColors.black),
        ).paddingOnly(bottom: 16.h),

        const Divider(
          color: AppColors.greyCBCBCB,
        ).paddingOnly(bottom: 16.h),

        /// Email id
        Row(
          children: [
            CommonText(
              title: LocalizationStrings.keyEmailId.localized,
              textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.grey8D8C8C),
            ),
            const Expanded(flex: 6, child: SizedBox()),
            Expanded(
              flex: 5,
              child: CommonText(
                title: subOperatorData?.email??'',
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.right,
                maxLines: 3,
              ),
            ),
          ],
        ).paddingOnly(bottom: 16.h),

        /// Status
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     CommonText(
        //       title: LocalizationStrings.keyStatus.localized,
        //       textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.grey8D8C8C),
        //     ),
        //     subOperatorData?.active == true
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
        // ).paddingOnly(bottom: 16.h),

        ///Status toggle
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
                    ),
                  );
                }

              },
            ),
          ],
        ).paddingOnly(bottom: 30.h),

        /// Close button
        CommonButtonMobile(
          buttonText: LocalizationStrings.keyClose.localized,
          isButtonEnabled: true,
          buttonTextColor: AppColors.blue009AF1,
          buttonEnabledColor: AppColors.white,
          borderColor: AppColors.blue009AF1,
          onTap: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
