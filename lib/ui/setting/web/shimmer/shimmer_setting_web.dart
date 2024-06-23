import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/setting/web/shimmer/shimmer_setting_center_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerSettingWeb extends StatelessWidget with BaseStatelessWidget {
  const ShimmerSettingWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        ///Top Back and title widget
        Row(
          children: [
            CommonShimmer(
              height: 20.h,
              width: 20.h,
            ).paddingOnly(right: 10.w),
            CommonShimmer(
              height: 17.h,
              width: context.width * 0.1,
            ),
          ],
        ).paddingOnly(bottom: 30.h),

        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r), color: AppColors.white),
            child: const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Center Widget
                  ShimmerSettingCenterWidget(),
                ],
              ),
            ),
          ).paddingOnly(bottom: 38.h),
        ),
      ],
    ).paddingOnly(top: 38.h, left: 38.w, right: 38.w);
  }
}
