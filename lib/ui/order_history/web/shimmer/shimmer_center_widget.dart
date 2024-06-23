import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/order_history/web/shimmer/shimmer_product_list.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerCenterWidget extends StatelessWidget with BaseStatelessWidget {
  const ShimmerCenterWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
      child: Column(
        children: [
          Row(
            children: List.generate(
              2,(index) {
                return CommonShimmer(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.r)), color: AppColors.lightPink),
                  height: 40.h,
                  width: 110.w,
                ).paddingOnly(right: 20.w);
              },
            ),
          ),
          const Expanded(
            child: ShimmerProductList(),
          ),
        ],
      ).paddingSymmetric(vertical: 25.h, horizontal: 40.w),
    ).paddingOnly(top: 18.h, bottom: 40.h);
  }
}
