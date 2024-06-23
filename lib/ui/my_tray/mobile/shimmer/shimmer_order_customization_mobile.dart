import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOrderCustomizationMobile extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerOrderCustomizationMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _productDetailsWidget(context: context),
        _verticalSpace(),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonShimmer(height: 20.h, width: context.width * 0.25)
                        .paddingOnly(left: 30.w, top: 30.h, bottom: 20.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: context.height * 0.15,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipOval(
                              child: CommonShimmer(width: 60.h, height: 60.h),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            CommonShimmer(
                                height: 15.h, width: context.width * 0.2),
                            SizedBox(
                              height: 5.h,
                            ),
                            CommonShimmer(
                                height: 15.h, width: context.width * 0.2),
                          ],
                        ).paddingOnly(right: 30.w);
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 30.h);
            }),
        _verticalSpace(),
      ]).paddingAll(20.h),
    );
  }
}

/// Vertical Space Widget
Widget _verticalSpace() {
  return SizedBox(
    height: 20.h,
  );
}

/// Shimmer Product Details Widget
Widget _productDetailsWidget({required BuildContext context}) {
  return SafeArea(
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
      child: Stack(
        children: [
          Column(
            children: [
              ClipOval(
                child: CommonShimmer(
                  height: 181.h,
                  width: 181.h,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonShimmer(height: 20.h, width: context.width * 0.4),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CommonShimmer(height: 20.h, width: context.width * 0.7)
                    .paddingOnly(right: 5.w),
              ),
              SizedBox(
                height: 5.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CommonShimmer(height: 20.h, width: context.width * 0.7)
                    .paddingOnly(right: 5.w),
              )
            ],
          ).paddingAll(20.h),
          Positioned(
            left: 15.h,
            top: 15.h,
            child: Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.white,
              child: const CommonSVG(
                strIcon: AppAssets.svgBackScaffoldBg,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

///---------------------------Shimmer Bottom Navigation Bar---------------------------///

class ShimmerOrderCustomizationBottomNavigationBarWidget extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerOrderCustomizationBottomNavigationBarWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: CommonCard(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _shimmerWidgetQtyButton(),
            Container(
              width: 40.w,
              alignment: Alignment.center,
              child: CommonShimmer(height: 30.h, width: 10.w),
            ),
            _shimmerWidgetQtyButton(),
            SizedBox(
              width: 20.w,
            ),
            Flexible(
              child: Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.white,
                  child: CommonButton(
                    width: 176.w,
                  )).paddingSymmetric(horizontal: 20.w),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}

///---------------------------Shimmer Qty Widget---------------------------///

Widget _shimmerWidgetQtyButton() {
  return ClipOval(child: CommonShimmer(height: 60.h, width: 60.h));
}
