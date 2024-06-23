import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomeOrderWidget extends StatelessWidget with BaseStatelessWidget {
  const ShimmerHomeOrderWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: [
                Positioned(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.93,
                  top: 0,
                  child: CommonCard(
                    elevation: 4,
                    color: AppColors.white,
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.93,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 30.h),
                          Container(
                            height: context.height * 0.18,
                            width: context.height * 0.18,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: CommonShimmer(
                                height: context.height * 0.18,
                                width: context.height * 0.18,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CommonShimmer(
                              height: 20.h, width: context.width * 0.1),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.15,
                  right: constraints.maxWidth * 0.15,
                  bottom: 0,
                  child: Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: CommonButton(
                      height: constraints.maxHeight * 0.15,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: context.height * 0.4,
        mainAxisSpacing: 40.h,
        crossAxisSpacing: 25.w,
      ),
    ).paddingOnly(left: 35.w, right: context.width * 0.1);
  }
}
