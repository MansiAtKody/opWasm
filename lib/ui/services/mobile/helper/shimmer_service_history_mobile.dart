import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerServiceHistoryMobile extends StatelessWidget {
  const ShimmerServiceHistoryMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _commonDocumentSentWidget(context)
                            .paddingOnly(bottom: 20.h, left: 10.w, right: 10.w);
                      }).paddingOnly(top: 15.h)
                ],
              ),
            ),
          ),

          /// Bottom button Widget
          CommonShimmer(
            height: 60.h,
            width: context.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(58.r),
                color: AppColors.black),
          ).paddingSymmetric(horizontal: 15.w, vertical: 20.h)
        ],
      ),
    );
  }
}

/// Common Document Sent Widget
Widget _commonDocumentSentWidget(BuildContext context) {
  return Container(
    color: AppColors.transparent,
    child: CommonCard(
      cornerRadius: 15.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ///Ticket Icon
          CommonShimmer(
            height: 42.h,
            width: 42.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black,
            ),
          ).paddingLTRB(12.w, 20.h, 20.w, 0.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///Ticket Title
                    Flexible(
                      child: CommonShimmer(
                        height: 17.h,
                        width: context.width * 0.2,
                      ),
                    ),

                    ///Ticket Status
                    CommonShimmer(
                      height: 27.h,
                      width: 75.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: AppColors.black),
                    ).paddingOnly(top: 20.h, bottom: 12.h),
                  ],
                ).paddingOnly(right: 17.w),

                ///Ticket Description
                CommonShimmer(
                  height: 17.h,
                  width: context.width * 0.4,
                ).paddingOnly(right: 60.w, bottom: 5.h),
                CommonShimmer(
                  height: 17.h,
                  width: context.width * 0.4,
                ).paddingOnly(right: 60.w, bottom: 5.h),
                CommonShimmer(
                  height: 8.h,
                  width: 48.w,
                ).paddingOnly(right: 60.w, top: 20.h),
              ],
            ),
          ),
        ],
      ).paddingOnly(bottom: 20.h),
    ),
  );
}

/// Service History App Bar Widget
class ShimmerServiceHistoryAppbarWidget extends StatelessWidget with BaseStatelessWidget{
  const ShimmerServiceHistoryAppbarWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.white.withOpacity(0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonShimmer(
            height: 67.h,
            width: 67.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black,
            ),
          ).paddingOnly(right: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
        ],
      ).paddingAll(20.h),
    ).paddingSymmetric(vertical: 20.h);
  }
}
