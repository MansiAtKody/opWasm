import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/services/web/shimmer/shimmer_send_service_left_widget.dart';
import 'package:kody_operator/ui/services/web/shimmer/shimmer_send_service_right_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerServicesWeb extends StatelessWidget {
  const ShimmerServicesWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                padding: EdgeInsets.symmetric(vertical: 30.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: context.width * 0.02),
                    /// Send Service Left Widget
                    const ShimmerSendServiceLeftWidget(),
                    SizedBox(
                      width: 24.w,
                    ),
                    /// Send Service Right Widget
                    const ShimmerSendServiceRightWidget(),
                    SizedBox(width: context.width * 0.02),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.height * 0.05),
          ],
        ),
      ],
    ).paddingOnly(top: 38.h, left: 38.w, right: 38.w);
  }
}

///Top Back and title widget
