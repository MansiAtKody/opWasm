import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/faq/faq_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:shimmer/shimmer.dart';

/// ------------------- Shimmer Profile -------------------------- ///

/// Shimmer FAQ Widget
class ShimmerFaqMobile extends StatelessWidget with BaseStatelessWidget {
  const ShimmerFaqMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final faqWatch = ref.watch(faqController);
        return CommonWhiteBackground(
          child: Container(
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.whiteF7F7FC),
            child: ListView.separated(
              //physics: const NeverScrollableScrollPhysics(),
              itemCount: faqWatch.faqModel.length,
              //shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                /// List of the Faq question
                return _faqListTileWidget().paddingSymmetric(horizontal: 10.h);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 5,
                ).paddingSymmetric(vertical: 25.h);
              },
            ).paddingOnly(bottom: 30.h),
          )
              .paddingSymmetric(vertical: 20.h, horizontal: 20.h)
              .paddingOnly(top: 12.h),
        );
      },
    );
  }
}

/// Shimmer Faq List Tile Widget
Widget _faqListTileWidget() {
  return Column(
    children: [
      /// This will make the default divider of expansion tile transparent
      ListTile(
        leading: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: Container(
            height: 44.h,
            width: 44.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black,
            ),
          ),
        ),
        trailing: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: Container(
            height: 24.h,
            width: 24.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black,
            ),
          ),
        ),
        title: Wrap(
          children: [
            Column(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.white,
                  child: Container(
                    height: 15.h,
                    width: 211.w,
                    color: AppColors.black,
                  ),
                ).paddingOnly(bottom: 10.h),
                Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.white,
                  child: Container(
                    height: 15.h,
                    width: 211.w,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Visibility(
      //   visible:isExpanded,
      //   child: ListTile(
      //     title: Wrap(
      //       children: [
      //         Text(
      //           faqWatch.faqModel
      //               .elementAt(index)
      //               .description,
      //           style: TextStyles.regular.copyWith(
      //               fontFamily: TextStyles.fontFamily,
      //               color: AppColors.black171717, fontSize: 13.sp),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // Visibility(
      //     visible: index < faqWatch.faqModel.length - 1,
      //     child: const Divider(height: 1)).paddingSymmetric(
      //     horizontal: 20.w, vertical: 10.h)
    ],
  );
}

/*
Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.white,
                    child: Container(
                      height: 10.h,
                      width: 70.w,
                      color: AppColors.black,
                    ),
                  )
*/
