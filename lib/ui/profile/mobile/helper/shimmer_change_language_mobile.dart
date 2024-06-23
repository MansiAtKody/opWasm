import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/change_language_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:shimmer/shimmer.dart';

/// ------------------- Shimmer Change Language -------------------------- ///

/// Profile App Bar Widget
class ShimmerChangeLanguageMobile extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerChangeLanguageMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonWhiteBackground(child: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final changeLanguageWatch = ref.watch(changeLanguageController);
        return CommonWhiteBackground(
          child: Column(
            children: [
              ///Main Content
              Container(
                decoration: BoxDecoration(
                    color: AppColors.lightPink,
                    borderRadius: BorderRadius.circular(20.r)),
                child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// Change Language Radio Buttons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: AppColors.shimmerBaseColor,
                                        highlightColor: AppColors.white,
                                        child: Container(
                                          height: 33.h,
                                          width: 33.h,
                                          decoration: BoxDecoration(
                                              color: AppColors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8.r)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: AppColors.shimmerBaseColor,
                                        highlightColor: AppColors.white,
                                        child: Container(
                                          height: 13.h,
                                          width: context.width * 0.6,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: AppColors.shimmerBaseColor,
                                    highlightColor: AppColors.white,
                                    child: Container(
                                      height: 18.h,
                                      width: 18.h,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ).paddingSymmetric(vertical: 17.h),
                            ],
                          ).paddingSymmetric(horizontal: 20.w);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider().paddingSymmetric(horizontal: 20.w),
                        itemCount: changeLanguageWatch.languageList.length)
                    .paddingSymmetric(vertical: 10.h),
              ).paddingAll(12.h),
            ],
          ),
        );
      },
    ));
  }
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
