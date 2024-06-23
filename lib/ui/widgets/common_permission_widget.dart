
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:lottie/lottie.dart';

class CommonPermissionWidget extends ConsumerWidget with BaseConsumerWidget {
  final Function() onPositiveButtonTap;
  const CommonPermissionWidget({Key? key,required this.onPositiveButtonTap,}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          AppAssets.animCameraStorage,
          height: 145.h,
          width: 145.h,
          fit: BoxFit.scaleDown,
      ).paddingOnly(top: 30.h),

        ///title
        CommonText(
        title: LocalizationStrings.keyCameraStoragePermissionRequiredMessage.localized,
          textStyle: TextStyles.medium.copyWith(
              color: AppColors.black171717,fontSize: 18.sp
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
        ).paddingOnly(bottom: 15.h,left: 40.h,right: 40.h),

        ///Sub title
        CommonText(
          title:  LocalizationStrings.keyCameraStoragePermissionGrantMessage.localized,
          textStyle: TextStyles.regular.copyWith(
              color: AppColors.grey828282,fontSize: 14.sp),
          maxLines: 3,
          textAlign: TextAlign.center,
        ).paddingOnly(left: 40.h,right: 40.h,bottom: 30.h),

        ///Bottom Buttons
        Row(
          children: [
            Expanded(
              child: CommonButton(
                  height: 55.h,
                  buttonText: LocalizationStrings.keyNotNow.localized,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  buttonEnabledColor: AppColors.lightPinkF7F7FC,
                  buttonTextColor: AppColors.black171717),
            ),

            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: CommonButton(
                  height: 55.h,
                  buttonText: LocalizationStrings.keyContinue.localized,
                  onTap: onPositiveButtonTap,
                  buttonEnabledColor: AppColors.black171717,
                  buttonTextColor: AppColors.white),
            ),
          ],
        ).paddingSymmetric(horizontal: 15.w,vertical: 15.h)

      ],
    );
  }

}


