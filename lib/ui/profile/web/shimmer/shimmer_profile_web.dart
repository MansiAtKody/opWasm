import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/profile/web/shimmer/shimmer_personal_information_widget_web.dart';
import 'package:kody_operator/ui/profile/web/shimmer/shimmer_profile_list_tile_widget_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerProfileWeb extends StatelessWidget with BaseStatelessWidget {
  const ShimmerProfileWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Profile Body Header Widget
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

        ///Profile Body
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Profile body left side widget
                Expanded(
                  flex: 4,
                  child: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final profileWatch = ref.watch(profileController);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                ///Common Profile List Tile
                                return const ShimmerProfileListTileWidgetWeb().paddingOnly(left: 30.w);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 20.h);
                              },
                              shrinkWrap: true,
                              itemCount: profileWatch.profileList.length,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonShimmer(
                                  height: 15.h,
                                  width: context.width * 0.05,
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              CommonShimmer(
                                height: 15.h,
                                width: context.width * 0.07,
                              ),
                            ],
                          ).paddingOnly(left: 30.w),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(width: 35.w),

                ///Profile Body Right Side Widget
                const Expanded(
                  flex: 7,
                  child: ShimmerPersonalInformationWidgetWeb(),
                ),
                SizedBox(width: 35.w),
              ],
            ).paddingSymmetric(vertical: 45.h),
          ),
        ),
      ],
    ).paddingOnly(top: 38.h, left: 38.w, right: 38.w, bottom: 38.h);
  }
}
