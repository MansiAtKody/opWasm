import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

/// Shimmer Service Status Widget
class ShimmerServiceStatusMobile extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerServiceStatusMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonWhiteBackground(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      backgroundColor: AppColors.buttonDisabledColor,
      height: context.height,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///Status of the sent or received Services
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _commonPersonListTile().paddingSymmetric(
                    horizontal: 10.w,
                  ),
                  Divider(
                    height: 4.h,
                  ).paddingOnly(left: 20.w, right: 20.w, top: 20.h),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Subject
                      CommonShimmer(
                        height: 10.h,
                        width: 64.w,
                      ).paddingOnly(bottom: 14.h),

                      /// Subject Detail
                      CommonShimmer(
                        height: 10.h,
                        width: context.width * 0.7,
                      ).paddingOnly(bottom: 20.h),

                      /// Message
                      CommonShimmer(
                        height: 10.h,
                        width: 64.w,
                      ).paddingOnly(bottom: 20.h),

                      /// Message detail
                      CommonShimmer(
                        height: 106.h,
                        width: context.width,
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(5.r)),
                      ).paddingOnly(bottom: 4.h),

                      /// Divider
                      Divider(
                        height: 4.h,
                      ).paddingSymmetric(vertical: 30.h),

                      CommonShimmer(
                        height: 12.h,
                        width: context.width * 0.3,
                      ).paddingOnly(bottom: 20.h),
                      _commonRequestDetailWidget(context)
                          .paddingOnly(bottom: 10.h),
                      _commonRequestDetailWidget(context)
                          .paddingOnly(bottom: 10.h),
                      _commonRequestDetailWidget(context)
                          .paddingOnly(bottom: 10.h),
                      _commonRequestDetailWidget(context)
                          .paddingOnly(bottom: 10.h),
                      _commonRequestDetailWidget(context)
                          .paddingOnly(bottom: 10.h),
                      _commonRequestDetailWidget(context),
                    ],
                  ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
                ],
              ).paddingSymmetric(horizontal: 0.w, vertical: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// Common Person List Tile
Widget _commonPersonListTile() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      CommonShimmer(
        height: 67.h,
        width: 67.h,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: AppColors.black),
      ).paddingOnly(right: 14.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonShimmer(
            height: 18.h,
            width: 150.w,
          ).paddingOnly(bottom: 10.h),
          CommonShimmer(
            height: 16.h,
            width: 132.w,
          )
        ],
      ),
      const Spacer(
        flex: 1,
      ),
    ],
  ).paddingAll(15.w);
}

/// Shimmer Common Request Detail Widget
Widget _commonRequestDetailWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CommonShimmer(
        height: 18.h,
        width: 74.w,
      ).paddingOnly(bottom: 10.h),
      CommonShimmer(
        height: 18.h,
        width: context.width * 0.35,
      ).paddingOnly(bottom: 10.h),
    ],
  );
}
