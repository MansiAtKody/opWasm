import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

/// ------------------- Shimmer Personal Information -------------------------- ///

class ShimmerPersonalInformationWidget extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerPersonalInformationWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          children: [
            Column(
              children: [
                _profileInfoTopWidget(),

                Divider(
                  color: AppColors.grey7E7E7E.withOpacity(0.2),
                ).paddingOnly(top: 20.h, bottom: 10.h),

                _profileInfoCenterWidget()
              ],
            ).paddingOnly(left: 28.w, right: 28.w, top: 35.h),
            const Spacer(),
            Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.white,
              child: Container(
                height: 60.h,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(58.r),
                  color: AppColors.black,
                ),
              ),
            ).paddingOnly(left: 10.w, right: 10.w, bottom: buttonBottomPadding),
          ],
        )).paddingAll(12.r);
  }
}

/// Profile Info Top Widget
Widget _profileInfoTopWidget() {
  return Row(
    children: [
      Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: Container(
          height: 67.h,
          width: 67.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.black,
          ),
        ),
      ).paddingOnly(right: 20.w),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: Container(
              height: 20.h,
              width: 97.w,
              color: AppColors.black,
            ),
          ).paddingOnly(bottom: 3.h),
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: Container(
              height: 20.h,
              width: 120.w,
              color: AppColors.black,
            ),
          ),
        ],
      ),
      const Spacer(),
      Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: Container(
          height: 36.h,
          width: 36.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.black,
          ),
        ),
      )
    ],
  );
}

/// Profile Info Center Widget
Widget _profileInfoCenterWidget() {
  return Column(
    children: [
      Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: _commonProfileInfo(),
      ).paddingOnly(bottom: 30.h),
      Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: _commonProfileInfo(),
      ).paddingOnly(bottom: 15.h),
      Align(
          alignment: Alignment.centerRight,
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.white,
            child: Container(
              height: 20.h,
              width: 99.w,
              color: AppColors.black,
            ),
          )),
      Divider(
        color: AppColors.grey7E7E7E.withOpacity(0.2),
      ).paddingOnly(top: 18.h, bottom: 8.h),
      Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: _commonProfileInfo(),
      ).paddingOnly(bottom: 15.h),
    ],
  );
}

/// Common Profile Info
Widget _commonProfileInfo() {
  return Row(
    children: [
      Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: Container(
          height: 24.h,
          width: 24.h,
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(30.r)
          ),
        ),
      ).paddingOnly(right: 12.w),
      Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: Container(
          height: 20.h,
          width: 70.w,
          color: AppColors.black,
        ),
      ),
      const Spacer(),
      Expanded(
        flex: 2,
        child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: Container(
            height: 20.h,
            width: 70.w,
            color: AppColors.black,
          ),
        ),
      ),
    ],
  );
}

/// Implementation Of Shimmer
/*
Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: Container(
                      height: 10.h,
                      width: 70.w,
                      color: AppColors.black,
                    ),
                  ),
*/