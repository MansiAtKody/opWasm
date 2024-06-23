

import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ShowNotification extends StatelessWidget {
  final String? notificationTitle;
  final String? notificationBody;
  final Function() onCloseTap;
  const ShowNotification({Key? key, this.notificationTitle, this.notificationBody, required this.onCloseTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(10.r),
          ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonSVG(
              strIcon: AppAssets.svgForegroundNotificationIcon,
            svgColor: AppColors.white,
            height: 30.h,
            width: 30.w,
          ).paddingOnly(right: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  title: notificationTitle??'',
                  textStyle: TextStyles.medium.copyWith(
                    color: AppColors.white,
                    fontSize: 16.sp,
                  ),
                ).paddingOnly(bottom: 5.h ),
                CommonText(
                  title: notificationBody??'',
                  textStyle: TextStyles.regular.copyWith(
                    color: AppColors.white,
                    fontSize: 14.sp,
                  ),
                  maxLines: 10,
                )
              ],
            ).paddingOnly(right: 20.w),
          ),
          InkWell(
            onTap: onCloseTap,
            child:  CommonSVG(
              height: 30.h,
              width: 30.w,
              strIcon: AppAssets.svgCrossWhite
            ),
          ),
        ],
      ),
    );
  }
}
