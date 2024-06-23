import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductManagementMobile extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerProductManagementMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonWhiteBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

        Align(
          alignment: Alignment.centerRight,
          child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: Container(
              height: 10.h,
              width: 70.w,
              color: AppColors.black,
            ),
          ),
        ).paddingOnly(bottom: 24.h,top: 20.h, left: 25.w,
          right: 25.w,),

            /// Product Tab bar
            Container(
              height: 59.h,
              alignment: Alignment.center,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(74.r),
                          color: AppColors.whiteF7F7FC),
                      height: 10.h,
                      width: 108.w,
                      // color: AppColors.black,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 20.w,
                  );
                },
              ),
            ).paddingOnly(
              left: 25.w,
              right: 25.w,
              top: 25.h,
            ),

            ///Product List Tile Widget
            SizedBox(
                height: 0.760.sh,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int productIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.whiteF7F7FC,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  itemCount: 4,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Shimmer.fromColors(
                                      baseColor: AppColors.shimmerBaseColor,
                                      highlightColor: AppColors.white,
                                      child: Container(
                                        height: 10.h,
                                        width: 70.w,
                                        color: AppColors.black,
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 10.h,
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: AppColors.shimmerBaseColor,
                                      highlightColor: AppColors.white,
                                      child: Container(
                                        height: 10.h,
                                        width: 100.w,
                                        color: AppColors.black,
                                      ),
                                    ).paddingOnly(bottom: 12.h),
                                    Shimmer.fromColors(
                                      baseColor: AppColors.shimmerBaseColor,
                                      highlightColor: AppColors.white,
                                      child: Container(
                                        height: 10.h,
                                        width: 100.w,
                                        color: AppColors.black,
                                      ),
                                    ).paddingOnly(bottom: 12.h),
                                    Shimmer.fromColors(
                                      baseColor: AppColors.shimmerBaseColor,
                                      highlightColor: AppColors.white,
                                      child: Container(
                                        height: 10.h,
                                        width: 70.w,
                                        color: AppColors.black,
                                      ),
                                    ).paddingOnly(bottom: 12.h),
                                    Shimmer.fromColors(
                                      baseColor: AppColors.shimmerBaseColor,
                                      highlightColor: AppColors.white,
                                      child: Container(
                                        height: 20.h,
                                        width: 36.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius:
                                                BorderRadius.circular(36.r)),
                                      ),
                                    ).paddingOnly(bottom: 10.w),
                                  ],
                                ).paddingOnly(top: 25.h),
                              )
                            ],
                          ),
                          const Divider(color: AppColors.greyDCD9D9),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                constraints:
                                    BoxConstraints(maxWidth: context.width * 2),
                                child: Shimmer.fromColors(
                                  baseColor: AppColors.shimmerBaseColor,
                                  highlightColor: AppColors.white,
                                  child: Container(
                                    height: 10.h,
                                    width: 100.w,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).paddingSymmetric(vertical: 15.h, horizontal: 20.w),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.h);
                  },
                ).paddingOnly(top: 26.h, bottom: 20.h, left: 12.w, right: 12.w)),
          ],
        ),
      ),
    );
  }
}

/*
Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: Container(
                      height: 10.h,
                      width: 70.w,
                      color: AppColors.black,
                    ),
                  )
*/
