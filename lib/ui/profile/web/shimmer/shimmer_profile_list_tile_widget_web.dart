import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';


/// Shimmer Common Profile Tile
class ShimmerProfileListTileWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  const ShimmerProfileListTileWidgetWeb({super.key,});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      height: 76.h,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.lightPinkF7F7FC,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ///Prefix Icon
              CommonShimmer(
                width: 45.w,
                height: 45.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black
                ),
              ).paddingSymmetric(horizontal: 17.w, vertical: 13.h),
              ///Title
              CommonShimmer(
                width: context.width * 0.1,
                height: 12.w,
              ),
            ],
          ),
          ///Suffix Icon
          CommonShimmer(
            width: 15.w,
            height: 15.w,
          ).paddingOnly(
            top: 26.h,
            bottom: 26.h,
            right: 20.w,
          )
        ],
      ),
    );
  }
}