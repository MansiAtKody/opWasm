import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOrderManagementMobile extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerOrderManagementMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonWhiteBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _statisticsWidget(context),

          ///statistics widget
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: Container(
              height: 10.h,
              width: 45.w,
              color: AppColors.black,
            ),
          ).paddingSymmetric(vertical: 20.h, horizontal: 20.w),

          /// Order Tab Widget
          _orderTabWidget(),

          Expanded(child: _orderDetailsDataWidget(context))
        ],
      ),
    );
  }
}

/// Order Tab Widget
Widget _orderTabWidget() {
  return Column(
    children: [
      Row(
        children: [
          SizedBox(
            height: 70.h,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppColors.shimmerBaseColor,
                        highlightColor: AppColors.white,
                        child: Container(
                          height: 10.h,
                          width: 50.w,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 15.h),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 80.w);
              },
            ),
          ).paddingSymmetric(horizontal: 26.w),
        ],
      ).paddingSymmetric(horizontal: 12.w)
    ],
  );
}

/// Robot Tray Details Data Widget
Widget _orderDetailsDataWidget(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(18.h),
    width: context.width,
    height: context.height,
    decoration: BoxDecoration(
      color: AppColors.whiteF7F7FC,
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    child: ListView.separated(
      itemCount: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              ///User Card Top Widget
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///User Name And Location
                  Expanded(
                    flex: 5,
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
                        ).paddingOnly(bottom: 10.h),
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 10.h,
                            width: 67.w,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 5.w,
                  ),

                  ///View Note Widget
                  Expanded(
                    flex: 3,
                    child: Shimmer.fromColors(
                      baseColor: AppColors.shimmerBaseColor,
                      highlightColor: AppColors.white,
                      child: Container(
                        height: 28.h,
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),

                  ///Ticket Number
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Shimmer.fromColors(
                        baseColor: AppColors.shimmerBaseColor,
                        highlightColor: AppColors.white,
                        child: Container(
                          height: 28.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                      ).paddingSymmetric(horizontal: 18.w, vertical: 8.h),
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
                    borderRadius: BorderRadius.all(Radius.circular(22.r)),
                    border: Border.all(color: AppColors.greyE6E6E6)),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.black),
                          ),
                        ),

                        ///
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Shimmer.fromColors(
                                baseColor: AppColors.shimmerBaseColor,
                                highlightColor: AppColors.white,
                                child: Container(
                                  height: 10.h,
                                  width: 120.w,
                                  color: AppColors.black,
                                ),
                              ).paddingOnly(bottom: 10.h),
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
                        const Spacer(),

                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.black),
                          ),
                        )
                      ],
                    ).paddingSymmetric(horizontal: 10.w, vertical: 12.h);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 0,
                      color: AppColors.greyE6E6E6,
                    ).paddingSymmetric(horizontal: 15.w);
                  },
                ),
              ),
              SizedBox(
                height: 13.h,
              ),

              /// Bottom Button Widget
              _bottomButtonWidget()
            ],
          ).paddingSymmetric(vertical: 16.h, horizontal: 16.w),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 15.h);
      },
    ),
  ).paddingSymmetric(horizontal: 17.w);
}

/// Statistics Widget
Widget _statisticsWidget(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(18.r))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: Container(
            height: 10.h,
            width: 73.w,
            color: AppColors.black,
          ),
        ).paddingSymmetric(vertical: 20.h),
        Row(
          children: [
            _statisticsOrderDetailsWidget(context),
            SizedBox(width: 10.w),
            _statisticsOrderDetailsWidget(context),
            SizedBox(width: 10.w),
            _statisticsOrderDetailsWidget(context)
          ],
        )
      ],
    ).paddingSymmetric(horizontal: 10.w),
  ).paddingSymmetric(horizontal: 12.w);
}

/// Statistics Order Details Widget
Widget _statisticsOrderDetailsWidget(BuildContext context) {
  return Expanded(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.19,
      decoration: BoxDecoration(
          color: AppColors.whiteF7F7FC,
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: Container(
              height: 65.h,
              width: 65.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.black),
            ),
          ),
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: Container(
              height: 10.h,
              width: 75.w,
              color: AppColors.black,
            ),
          ),
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: Container(
              height: 16.h,
              width: 42.w,
              color: AppColors.black,
            ),
          )
        ],
      ).paddingSymmetric(vertical: 16.h),
    ),
  );
}

/// Bottom Button Widget
Widget _bottomButtonWidget() {
  return Row(
    children: [
      /// Add Order Button

      Expanded(
        child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: Container(
            height: 40.h,
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
            height: 40.h,
            decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(30.r)),
          ),
        ),
      ),
    ],
  ).paddingAll(0.h);
}
