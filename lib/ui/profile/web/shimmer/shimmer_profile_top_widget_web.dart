import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerProfileTopWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  const ShimmerProfileTopWidgetWeb({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ///Display Profile Image
              CommonShimmer(
                height: 67.h,
                width: 67.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.black
                ),
              ).paddingOnly(right: 20.w),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: context.width * 0.4),
                    child: CommonShimmer(
                      height: 16.h,
                      width: 75.h,
                    ).paddingOnly(bottom: 5.h),
                  ),
                  CommonShimmer(
                    height: 15.h,
                    width: context.width * 0.1,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          ///Update or remove Image Button
          CommonShimmer(
            height: 40.h,
            width: 40.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black
            ),
          ),
        ],
      ).paddingOnly(bottom: 46.h, right: 44.w, left: 40.w);
    });
  }
}
