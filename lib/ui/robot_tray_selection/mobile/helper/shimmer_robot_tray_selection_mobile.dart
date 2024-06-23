import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRobotTraySelectionMobile extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerRobotTraySelectionMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonWhiteBackground(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                /// Tray top Widget
                Container(
                  width: context.width,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r)),
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
                          width: 60.w,
                        ).paddingOnly(left: 30.w, top: 20.h, bottom: 20.h),
                      ),

                      /// Robot Icons List
                      SizedBox(
                        height: context.height * 0.16,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                /// Robot Image
                                Shimmer.fromColors(
                                  baseColor: AppColors.shimmerBaseColor,
                                  highlightColor: AppColors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.black,
                                        borderRadius:
                                            BorderRadius.circular(60.r)),
                                    height: 80.h,
                                    width: 80.h,
                                  ),
                                ),

                                /// Robot Name
                                Shimmer.fromColors(
                                  baseColor: AppColors.shimmerBaseColor,
                                  highlightColor: AppColors.white,
                                  child: Container(
                                    color: AppColors.black,
                                    height: 12.h,
                                    width: 49.h,
                                  ).paddingOnly(top: 12.h),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 20.h);
                          },
                        ),
                      ).paddingSymmetric(horizontal: 20.w),
                    ],
                  ),
                ).paddingOnly(top: 8.h, left: 8.w, right: 8.w),

                Container(
                  decoration: BoxDecoration(
                      color: AppColors.whiteF7F7FC,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          topRight: Radius.circular(18.r))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            color: AppColors.black,
                            height: 10.h,
                            width: 60.w,
                          ).paddingSymmetric(vertical: 20.h, horizontal: 20.w),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Column(
                            children: [
                              /// Orders Tab Widget
                              _robotTabWidget(),

                              /// Robot Tray Details Widget
                              _robotTrayDetailsDataWidget(context),
                            ],
                          ).paddingSymmetric(vertical: 10.h),
                        ).paddingSymmetric(horizontal: 20.w),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Bottom Buttons Widget
          _bottomButtonWidget()
        ],
      ),
    );
  }
}

/// Tray Tab Widget
Widget _robotTabWidget() {
  return Column(
    children: [
      // Column(
      //   children: [
      //     Shimmer.fromColors(
      //       baseColor: AppColors.shimmerBaseColor,
      //       highlightColor: AppColors.white,
      //       child: Container(
      //         // color: AppColors.black,
      //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: AppColors.black),
      //         height: 40.h,
      //       ),
      //     ).paddingOnly(bottom: 15.h),
      //   ],
      // ).paddingSymmetric(horizontal: 12.w),

      Row(
        children: [
          SizedBox(
            height: 70.h,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: context.width * 0.27120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppColors.shimmerBaseColor,
                        highlightColor: AppColors.white,
                        child: Container(
                          height: 10.h,
                          width: 50.w,
                          color: AppColors.black,
                        ).paddingOnly(right: 5.w),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 15.h),
                );
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 12.w)
    ],
  );
}

/// Robot Tray Details Data Widget
Widget _robotTrayDetailsDataWidget(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(18.h),
    width: context.width,
    decoration: BoxDecoration(
      color: AppColors.whiteF7F7FC,
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: Container(
                      height: 10.h,
                      width: 110.w,
                      color: AppColors.black,
                    ),
                  ).paddingOnly(bottom: 8.h),
                  Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: Container(
                      height: 10.h,
                      width: 70.w,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ).paddingOnly(right: 20.w),
            ),
            Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.white,
              child: Container(
                height: 27.h,
                width: 70.w,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(14.r)),
              ),
            ).paddingOnly(right: 12.w),
            Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.white,
              child: Container(
                height: 28.h,
                width: 28.h,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(50.r)),
              ),
            )
          ],
        ),
        SizedBox(
          height: 21.h,
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
          child: ListView.separated(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(50.r)),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 10.h,
                            width: 100.w,
                            color: AppColors.black,
                          ),
                        ).paddingOnly(bottom: 5.h),
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 10.h,
                            width: 170.w,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 10.w),
                  ),
                ],
              ).paddingAll(10.h);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10.h);
            },
          ),
        )
      ],
    ),
  ).paddingSymmetric(horizontal: 17.w);
}

/// Bottom Button Widget
Widget _bottomButtonWidget() {
  return Container(
    color: AppColors.whiteF7F7FC,
    child: Row(
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
    ).paddingAll(15.h),
  );
}

