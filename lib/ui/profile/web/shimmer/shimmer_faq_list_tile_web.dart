import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerFaqListTileWeb extends StatelessWidget with BaseStatelessWidget {
  const ShimmerFaqListTileWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        children: [
          /// This will make the default divider of expansion tile transparent
          ListTile(
            leading: CommonShimmer(
              height: 50.h,
              width: 50.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.black),
            ),
            trailing: CommonShimmer(
              height: 24.h,
              width: 24.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.black),
            ),
            title: Wrap(
              children: [
                CommonShimmer(
                  height: 18.h,
                  width: context.width * 0.3,
                ),
              ],
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 15.w, vertical: 15.h),
    );
  }
}
