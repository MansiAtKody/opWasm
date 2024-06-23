import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOrderHomeMobile extends StatelessWidget with BaseStatelessWidget {
  const ShimmerOrderHomeMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      children: [
        SizedBox(height: 20.h),
        Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: 6,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.h,
                mainAxisExtent: context.height * 0.30,
                crossAxisSpacing: 20.w,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CommonCard(
                      elevation: 4,
                      margin: EdgeInsets.zero,
                      child: SizedBox(
                        width: context.width,
                        height: context.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipOval(
                              child: CommonShimmer(
                                height: 96.h,
                                width: 96.h,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            CommonShimmer(height: 20.h, width: 80.w)
                          ],
                        ).paddingOnly(bottom: 20.h),
                      ),
                    ).paddingOnly(bottom: 40.h),
                    Positioned(
                      bottom: 20.h,
                      child: Shimmer.fromColors(
                        baseColor: AppColors.shimmerBaseColor,
                        highlightColor: AppColors.white,
                        child: CommonButton(
                          height: 40.h,
                          width: context.width * 0.2,
                        ),
                      ),
                    )
                  ],
                );
              },
            ).paddingSymmetric(horizontal: 20.w),
            SizedBox(
              height: 20.h,
            )
          ],
        )
      ],
    );
  }
}
