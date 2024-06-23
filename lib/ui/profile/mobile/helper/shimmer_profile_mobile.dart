import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

/// ------------------- Shimmer Profile -------------------------- ///

/// Profile App Bar Widget
class ShimmerProfileAppBarWidget extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerProfileAppBarWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: SizedBox.fromSize(
            size: Size.fromRadius(51.r),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(51.r),
                child: Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.white,
                  child: Container(
                    height: 95.h,
                    width: 95.w,
                    color: AppColors.black,
                  ),
                )),
          ).paddingOnly(bottom: 30.h),
        ),
        SizedBox(height: 10.h),
        Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: Container(
            height: 20.h,
            width: 97.w,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(20.r)
            ),
          ),
        ).paddingOnly(bottom: 5.h),
        Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: Container(
            height: 20.h,
            width: 132.w,
            decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(20.r)
            ),
          ),
        ),
      ],
    ).paddingOnly(bottom: 30.h).paddingOnly(left: 12.w, right: 12.w, top: 6.h);
  }
}

/// Profile Center Widget
class ShimmerProfileCenterWidget extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerProfileCenterWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final profileWatch = ref.watch(profileController);
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileWatch.profileInfoTitleList.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.greyBEBEBE.withOpacity(0.3),
                      );
                    },
                    itemBuilder: (context, index) {
                      return _profileBase()
                          .paddingOnly(top: 20.h, bottom: 13.h);
                    },
                  ).paddingSymmetric(horizontal: 20.w);
                },
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ).paddingOnly(left: 20.w, right: 20.w, bottom: 40.h),
        ],
      ),
    );
  }
}

/// Profile Base
Widget _profileBase() {
  return Row(
    children: [
      Shimmer.fromColors(
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
      ).paddingOnly(right: 16.w),
      Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: Container(
          height: 14.h,
          width: 169.w,
          color: AppColors.black,
        ),
      ),
      const Spacer(),
      Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: Container(
          height: 15.h,
          width: 10.h,
          color: AppColors.black,
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
