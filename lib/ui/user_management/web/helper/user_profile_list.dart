import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_management/web/helper/active_inactive_widget.dart';
import 'package:kody_operator/ui/utils/anim/show_down_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class UserProfileList extends StatelessWidget with BaseStatelessWidget {
  const UserProfileList({super.key, required this.subOperatorData, required this.onSwitchTap});

  final SubOperatorData? subOperatorData;
  final void Function(bool) onSwitchTap;

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      height: 76.h,
      decoration: BoxDecoration(
        color: AppColors.lightPinkF7F7FC,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                /// Product Image
                ClipOval(
                  child: CachedNetworkImage(height: 53.h, width: 53.h, imageUrl: subOperatorData?.profileImage ?? 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80'),
                ).paddingSymmetric(vertical: 10.h, horizontal: 10.w),
                CommonText(
                  title: subOperatorData?.name??'',
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: CommonText(
              title: subOperatorData?.email??'',
              textStyle: TextStyles.regular.copyWith(
                fontSize: 12.sp,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserStatus.active == UserStatus.active
                    ? ShowDownTransition(
                        duration: 200,
                        child: UserActiveInactiveWidgetWeb(
                          borderColor: AppColors.green14B500,
                          title: LocalizationStrings.keyActive.localized,
                        ),
                      )
                    : SlideUpTransition(
                        duration: 200,
                        child: UserActiveInactiveWidgetWeb(
                          borderColor: AppColors.redEE0000,
                          title: LocalizationStrings.keyInActive.localized,
                        ),
                      ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonCupertinoSwitch(
              switchValue:UserStatus.active == UserStatus.active ? true : false,
              onChanged: (switchValue) {
                onSwitchTap(switchValue);
              },
            ),
          ),
          SizedBox(
            width: 40.w,
          ),
        ],
      ),
    );
  }
}
