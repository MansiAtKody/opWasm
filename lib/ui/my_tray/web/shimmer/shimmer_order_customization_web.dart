import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOrderCustomizationWeb extends StatelessWidget {
  const ShimmerOrderCustomizationWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CommonShimmer(
              width: 16.w,
              height: 14.w,
            ).paddingOnly(top: 30.h)
          ],
        ).paddingOnly(left: context.width * 0.04),
        SizedBox(height: context.height * 0.03),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: context.height * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                          child: _productDetailsWidget(context)),
                      SizedBox(height: context.height * 0.03),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: context.width * 0.02,
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FadeBoxTransition(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonShimmer(
                                          height: 20.h,
                                          width: context.width * 0.1)
                                      .paddingOnly(
                                          left: 30.w, top: 30.h, bottom: 20.h),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: context.height * 0.15,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor:
                                                AppColors.shimmerBaseColor,
                                            highlightColor: AppColors.white,
                                            child: Container(
                                                width: 60.h,
                                                height: 60.h,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AppColors.lightPinkF7F7FC,
                                                ),
                                                child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100.r),
                                                        child: CacheImage(
                                                          imageURL: '',
                                                          height: 20.h,
                                                          width: 20.w,
                                                        ))
                                                    .paddingSymmetric(
                                                        horizontal: 14.w,
                                                        vertical: 14.h)),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          CommonShimmer(
                                              height: 20.h, width: 50.w),
                                        ],
                                      ).paddingOnly(right: 30.w);
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                ],
                              ),
                            ),
                          ).paddingOnly(bottom: 30.h);
                        }),
                    _bottomWidget(context),
                    SizedBox(height: context.height * 0.1),
                  ],
                ),
              )
            ],
          ).paddingSymmetric(horizontal: context.width * 0.04),
        ),
      ],
    );
  }

  Widget _productDetailsWidget(BuildContext context) {
    return SafeArea(
      child: Container(
        height: context.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.white,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Center(
                  child: ClipOval(
                    child: CommonShimmer(
                      height: context.height * 0.3,
                      width: context.height * 0.3,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                CommonShimmer(
                  height: 20.h,
                  width: context.height * 0.2,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CommonShimmer(
                  height: 20.h,
                  width: context.height * 0.3,
                ),
                const Spacer(),
              ],
            ).paddingSymmetric(horizontal: 20.w),
          ],
        ),
      ),
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return SizedBox(
      height: context.height * 0.1,
      width: double.maxFinite,
      child: CommonCard(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.r))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _widgetQtyButton(),
                CommonShimmer(
                  height: 30.h,
                  width: 15.w,
                ).paddingSymmetric(horizontal: 10.w),
                _widgetQtyButton(),
              ],
            ),
            Flexible(
              child: Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.white,
                child: CommonButton(
                  width: 176.w,
                  height: 50.h,
                ),
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 30.w),
      ),
    );
  }

  Widget _widgetQtyButton() {
    return ClipOval(child: CommonShimmer(height: 50.h, width: 50.h));
  }
}
