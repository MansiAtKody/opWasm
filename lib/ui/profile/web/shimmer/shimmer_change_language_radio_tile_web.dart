import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

/// Shimmer Change Language Tiles
class ShimmerChangeLanguageRadioTileWeb extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerChangeLanguageRadioTileWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      height: 76.h,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                CommonShimmer(
                  height: 50.h,
                  width: 50.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.black),
                ).paddingSymmetric(
                  horizontal: 15.w,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonShimmer(
                      height: 15.h,
                      width: 70.h,
                    ),
                    SizedBox(height: 5.h),
                    CommonShimmer(
                      height: 15.h,
                      width: 70.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
          CommonShimmer(
            height: 16.h,
            width: 16.h,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.black),
          ).paddingOnly(top: 31.h, bottom: 31.h, right: 31.w),
        ],
      ),
    );
  }
}
