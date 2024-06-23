import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

/// Shimmer Setting
class ShimmerSettingMobile extends StatelessWidget with BaseStatelessWidget {
  const ShimmerSettingMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonWhiteBackground(
        height: context.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ///top Buttons
              _topButtonWidget(context).paddingOnly(bottom: 40.h, top: 15.h),

              /// Center Emergency buttons
              _centerEmergencyButtonWidget().paddingOnly(bottom: 40.h),

              ///Bottom Buttons
              _bottomButtonWidget(context)
            ],
          ).paddingOnly(left: 20.w, right: 20.w, top: 10.h),
        ));
  }
}

/// Shimmer Top Button
Widget _topButtonWidget(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          /// Intermission button
          Expanded(
            flex: 4,
            child: CommonShimmer(
              height: 70.h,
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.r),
                  color: AppColors.black),
            ),
          ),

          const Expanded(flex: 1, child: SizedBox()),

          /// Go to charging button
          Expanded(
            flex: 4,
            child: CommonShimmer(
              height: 70.h,
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.r),
                  color: AppColors.black),
            ),
          )
        ],
      ).paddingOnly(bottom: 16.h),
      Row(
        children: [
          /// Intermission
          Expanded(
            flex: 4,
            child: CommonShimmer(
              height: 70.h,
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.r),
                  color: AppColors.black),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),

          /// Map
          Expanded(
            flex: 4,
            child: CommonShimmer(
              height: 70.h,
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.r),
                  color: AppColors.black),
            ),
          )
        ],
      ),
    ],
  );
}

/// Center Emergency Buttons
Widget _centerEmergencyButtonWidget() {
  return Align(
    alignment: Alignment.center,
    child: CommonShimmer(
      height: 246.h,
      width: 246.h,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: AppColors.black),
    ).paddingOnly(bottom: 25.h),
  );
}

/// Bottom Button Widget
Widget _bottomButtonWidget(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      /// Speed Button
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonShimmer(
            height: 14.h,
            width: 49.w,
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: CommonShimmer(
              height: 70.h,
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.r),
                  color: AppColors.black),
            ),
          ),
        ],
      ).paddingOnly(bottom: 16.h),

      /// Light toggle button
      Row(
        children: [
          CommonShimmer(
            height: 14.h,
            width: context.width * 0.3,
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              ///update light status
            },
            child: CommonShimmer(
              height: 43.h,
              width: 70.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.r),
                  color: AppColors.black),
            ),
          ),
        ],
      ).paddingOnly(bottom: 16.h),

      /// Obstacle sound toggle button
      Row(
        children: [
          CommonShimmer(
            height: 14.h,
            width: context.width * 0.3,
          ),
          const Spacer(),
          CommonShimmer(
            height: 43.h,
            width: 70.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36.r),
                color: AppColors.black),
          ),
        ],
      ).paddingOnly(bottom: 16.h),

      /// Sound button
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonShimmer(
            height: 14.h,
            width: 49.w,
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: CommonShimmer(
              height: 70.h,
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.r),
                  color: AppColors.black),
            ),
          ),
        ],
      ).paddingOnly(bottom: 16.h),
    ],
  );
}
