import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerProductManagementWeb extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerProductManagementWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonShimmer(
          height: 15.h,
          width: context.width * 0.15,
        ).paddingOnly(bottom: 35.h),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Product Tab bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _productTypeTabWidget(),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CommonShimmer(
                        height: 14.h,
                        width: context.width * 0.07,
                      ),
                    ).paddingOnly(right: 30.w)
                  ],
                ).paddingOnly(bottom: 32.h),

                /// Product Name, Category & Product Status
                Row(
                  children: [
                    Expanded(
                        child: CommonShimmer(
                      height: 10.h,
                      width: 20.w,
                    )),
                    SizedBox(
                      width: 50.w,
                    ),
                    Expanded(
                      flex: 4,
                      child: CommonShimmer(
                        height: 10.h,
                        width: context.width * 0.01,
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Expanded(
                      flex: 2,
                      child: CommonShimmer(
                        height: 10.h,
                        width: context.width * 0.01,
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    Expanded(
                      flex: 4,
                      child: CommonShimmer(
                        height: 10.h,
                        width: context.width * 0.01,
                      ),
                    ),
                    const Expanded(flex: 6, child: SizedBox()),
                  ],
                ),

                ///Product List Tile Widget
                Expanded(
                  child: _productListTile(),
                ),
              ],
            ).paddingOnly(left: 40.w, right: 75.w, top: 33.h),
          ).paddingOnly(bottom: 30.h),
        ),
      ],
    ).paddingOnly(left: 38.w, right: 38.w, top: 36.h);
  }
}

/// Shimmer Product Type Tab Widget
Widget _productTypeTabWidget() {
  return SizedBox(
    height: 59.h,
    child: ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return CommonShimmer(
          height: 49.h,
          width: context.width * 0.09,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(74.r),
              color: AppColors.black),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 20.w,
        );
      },
    ),
  );
}

/// Shimmer List Tile Widget
Widget _productListTile() {
  return ListView.separated(
    shrinkWrap: true,
    itemCount: 5,
    itemBuilder: (BuildContext context, int productIndex) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.whiteF7F7FC,
        ),
        child: Column(
          children: [
            /// Product List Tile
            ListTile(
              title: Row(
                children: [
                  /// Cupertino Switch
                  Expanded(
                    child: CommonShimmer(
                      height: 20.h,
                      width: 36.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36.r),
                          color: AppColors.black),
                    ).paddingOnly(right: 32.w),
                  ),

                  /// Product Name
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        /// Product Image
                        ClipOval(
                          child: CommonShimmer(
                            height: 53.h,
                            width: 53.h,
                          ),
                        ).paddingOnly(right: 11.w),
                        Expanded(
                          child: CommonShimmer(
                            height: 10.h,
                            width: 80.w,
                          ).paddingOnly(right: 5.w),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40.w),
                  Expanded(
                    flex: 2,
                    child: CommonShimmer(
                      height: 10.h,
                      width: context.width * 0.01,
                    ).paddingOnly(right: 5.w),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 2,
                    child: CommonShimmer(
                      height: 10.h,
                      width: 78.w,
                    ).paddingOnly(right: 5.w),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        CommonShimmer(
                          height: 8.h,
                          width: context.width * 0.1,
                        ),
                        SizedBox(width: 4.w),

                        /// Trailing Icon
                        CommonShimmer(
                          height: 16.h,
                          width: 16.h,
                        ),
                      ],
                    ).paddingOnly(right: 5.w),
                  ),
                ],
              ),
            ).paddingOnly(top: 13.h, bottom: 10.h),
          ],
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return SizedBox(height: 20.h);
    },
  ).paddingOnly(top: 26.h, bottom: 20.h);
}
