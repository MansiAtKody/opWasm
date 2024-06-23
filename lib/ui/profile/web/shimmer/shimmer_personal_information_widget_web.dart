import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/profile/web/shimmer/shimmer_common_person_info_row_widget_web.dart';
import 'package:kody_operator/ui/profile/web/shimmer/shimmer_profile_top_widget_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerPersonalInformationWidgetWeb extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerPersonalInformationWidgetWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightPinkF7F7FC,
        borderRadius: BorderRadius.circular(20.r),
        shape: BoxShape.rectangle,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Shimmer Profile Top Widget
            const ShimmerProfileTopWidgetWeb(),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),

                  ///Title
                  CommonShimmer(
                    height: 20.h,
                    width: context.width * 0.1,
                  ),
                  SizedBox(height: 40.h),

                  ///Common Personal information Tile - Operator Name
                  const ShimmerCommonPersonalInfoRowWidgetWeb(),
                  Divider(
                    height: 40.h,
                  ),

                  ///Common Personal information Tile - Email Id
                  const ShimmerCommonPersonalInfoRowWidgetWeb(),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ///Change Email button
                      CommonShimmer(height: 18.h, width: context.width * 0.05)
                    ],
                  ),
                  Divider(
                    height: 40.h,
                  ),

                  ///Common Personal information Tile - Mobile Number
                  const ShimmerCommonPersonalInfoRowWidgetWeb(),
                  SizedBox(
                    height: 50.h,
                  ),

                  /// Change Password Button
                  CommonShimmer(
                    height: 60.h,
                    width: context.width * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: AppColors.black),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ).paddingSymmetric(horizontal: 38.w),
            ).paddingSymmetric(horizontal: 40.w),
          ],
        ).paddingOnly(top: 57.h, bottom: 36.h),
      ),
    );
  }
}
