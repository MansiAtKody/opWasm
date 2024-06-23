import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:shimmer/shimmer.dart';

/// ------------------- Shimmer Profile Setting -------------------------- ///

/// Profile App Bar Widget
class ShimmerProfileSettingMobile extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerProfileSettingMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonWhiteBackground(child: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Column(
          children: [
            /// Notification Preferences Cupertino Switch
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.lightPink),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: Container(
                      height: 13.h,
                      width: 192.w,
                      color: AppColors.black,
                    ),
                  ),
                  Transform.scale(
                    scale: 1.2,
                    child: Shimmer.fromColors(
                      baseColor: AppColors.shimmerBaseColor,
                      highlightColor: AppColors.white,
                      child: Container(
                        height: 27.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.w, vertical: 27.h),
            ).paddingOnly(bottom: 20.h),

            /// Delete Account
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.lightPink),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 13.h,
                            width: 192.w,
                            color: AppColors.black,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 15.h,
                            width: 10.w,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
              ),
            )
          ],
        ).paddingAll(20.h);
      },
    ));
  }
}

/// Implementation Of Shimmer
/*
Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: Container(
                      height: 10.h,
                      width: 70.w,
                      color: AppColors.black,
                    ),
                  ),
*/
