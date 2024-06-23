import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/user_management/user_management_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:shimmer/shimmer.dart';

/// -------------------------- Shimmer User Management -------------------------- ///

/// Profile App Bar Widget
class ShimmerUserManagementMobile extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerUserManagementMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonWhiteBackground(child: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final userManagementWatch = ref.watch(userManagementController);
        return ListView.builder(
            itemCount: userManagementWatch.users.length,
            itemBuilder: (context, index) {
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
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 10.h,
                            width: 92.w,
                            color: AppColors.black,
                          ),
                        ),
                        const Expanded(flex: 6, child: SizedBox()),
                        Expanded(
                          flex: 4,
                          child: Shimmer.fromColors(
                            baseColor: AppColors.shimmerBaseColor,
                            highlightColor: AppColors.white,
                            child: Container(
                              height: 10.h,
                              width: 80.w,
                              color: AppColors.black,
                            ),
                          ),
                        )
                      ],
                    ).paddingOnly(bottom: 18.h),

                    /// Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 10.h,
                            width: 92.w,
                            color: AppColors.black,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 33.h,
                            width: 69.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.black,
                            ),
                          ),
                        ).paddingSymmetric(vertical: 12.h),
                      ],
                    ).paddingOnly(bottom: 18.h),

                    /// Email id
                    Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 10.h,
                            width: 92.w,
                            color: AppColors.black,
                          ),
                        ),
                        const Expanded(flex: 6, child: SizedBox()),
                        Expanded(
                          flex: 4,
                          child: Shimmer.fromColors(
                            baseColor: AppColors.shimmerBaseColor,
                            highlightColor: AppColors.white,
                            child: Container(
                              height: 10.h,
                              width: 127.w,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ).paddingOnly(bottom: 28.h),

                    /// Status toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 10.h,
                            width: 92.w,
                            color: AppColors.black,
                          ),
                        ),
                        Transform.scale(
                          scale: 1.3,
                          child: Shimmer.fromColors(
                            baseColor: AppColors.shimmerBaseColor,
                            highlightColor: AppColors.white,
                            child: Container(
                              height: 20.h,
                              width: 36.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(horizontal: 19.w, vertical: 25.h),
              ).paddingOnly(bottom: 15.h);
            }).paddingOnly(top: 20.h, left: 20.w, right: 20.w);
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
