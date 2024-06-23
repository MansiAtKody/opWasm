import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:shimmer/shimmer.dart';

/// Add Order Dialogue Widget
class ShimmerAddOrderDialogueWidget extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerAddOrderDialogueWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Text
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: Container(
              color: AppColors.black,
              height: 10.h,
              width: 45.w,
            ).paddingOnly(left: 30.w, top: 20.h, bottom: 20.h),
          ),
          Expanded(
              child: Container(
            height: context.height * 0.64,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 25.h),
                      ListView.separated(
                        itemCount: 1,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder:
                            (BuildContext context, int pastOrderIndex) {
                          return CommonCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Top Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: AppColors.shimmerBaseColor,
                                      highlightColor: AppColors.white,
                                      child: Container(
                                        color: AppColors.black,
                                        height: 10.h,
                                        width: 100.w,
                                      ),
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: AppColors.shimmerBaseColor,
                                      highlightColor: AppColors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius:
                                                BorderRadius.circular(18.r)),
                                        width: context.width * 0.145,
                                        height: context.height * 0.038,
                                      ),
                                    )
                                  ],
                                ),

                                /// Department Name
                                Shimmer.fromColors(
                                  baseColor: AppColors.shimmerBaseColor,
                                  highlightColor: AppColors.white,
                                  child: Container(
                                    color: AppColors.black,
                                    height: 10.h,
                                    width: 65.w,
                                  ),
                                ).paddingOnly(bottom: 25.h),

                                /// Dispatched Orders List Widget
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, orderIndex) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r))),
                                      child: Row(
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor:
                                                AppColors.shimmerBaseColor,
                                            highlightColor: AppColors.white,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.r)),
                                              height: 40.h,
                                              width: 40.h,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Shimmer.fromColors(
                                                  baseColor: AppColors
                                                      .shimmerBaseColor,
                                                  highlightColor:
                                                      AppColors.white,
                                                  child: Container(
                                                    color: AppColors.black,
                                                    height: 10.h,
                                                    width: 110.w,
                                                  ),
                                                ).paddingOnly(bottom: 10.h),
                                                Shimmer.fromColors(
                                                  baseColor: AppColors
                                                      .shimmerBaseColor,
                                                  highlightColor:
                                                      AppColors.white,
                                                  child: Container(
                                                    color: AppColors.black,
                                                    height: 10.h,
                                                    width: 160.w,
                                                  ),
                                                )
                                              ],
                                            ).paddingOnly(left: 10.w),
                                          ),
                                          const Spacer(),

                                          /// CheckBox
                                          Shimmer.fromColors(
                                            baseColor:
                                                AppColors.shimmerBaseColor,
                                            highlightColor: AppColors.white,
                                            child: Container(
                                              height: 24.h,
                                              width: 24.h,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(3.r),
                                                  color: AppColors.black),
                                            ),
                                          ),
                                        ],
                                      ).paddingSymmetric(
                                          horizontal: 10.w, vertical: 12.h),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 10.h);
                                  },
                                )
                              ],
                            ).paddingAll(15.h),
                          ).paddingOnly(bottom: 20.h);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 15.h);
                        },
                      )
                    ],
                  ),
                ),

                /// Bottom Sheet Bottom Buttons

                Row(
                  children: [
                    /// Add Order Button

                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: AppColors.shimmerBaseColor,
                        highlightColor: AppColors.white,
                        child: Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                      ),
                    ),
                    SizedBox(width: 17.w),

                    /// Go Button
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: AppColors.shimmerBaseColor,
                        highlightColor: AppColors.white,
                        child: Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                      ),
                    ),
                  ],
                ).paddingAll(20.h)
              ],
            ),
          ).paddingSymmetric(horizontal: 16.w)),
        ],
      ),
    );
  }
}
