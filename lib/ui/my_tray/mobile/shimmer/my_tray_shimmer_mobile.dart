import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:shimmer/shimmer.dart';

class MyTrayMobileShimmer extends StatelessWidget with BaseStatelessWidget {
  const MyTrayMobileShimmer({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _addMoreItemsAdditionalNoteWidget(context),

        ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _myTrayList(context).paddingOnly(bottom: 10.h);
          },
        ).paddingOnly(
          left: 20.w,
          right: 20.w,
        ),
        _markAddComboWidget(context),
        _additionalNoteTextAddedWidget(context),
        Divider(
          height: 40.h,
        ).paddingSymmetric(
          horizontal: 20.w,
        ),

        /// Shimmer Frequently Widget
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonShimmer(height: 15.h, width: context.width * 0.4),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 200.h,
              child: ListView.separated(
                itemCount: 2,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2.40,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CommonCard(
                            elevation: 4,
                            margin: EdgeInsets.zero,
                            child: SizedBox(
                              width: context.width,
                              height: context.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipOval(
                                    child: CommonShimmer(
                                      height: 96.h,
                                      width: 96.h,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  CommonShimmer(
                                    height: 20.h,
                                    width: context.width * 0.2,
                                  )
                                ],
                              ).paddingOnly(bottom: 20.h),
                            ),
                          ).paddingOnly(bottom: 40.h),
                          Positioned(
                            bottom: 20.h,
                            child: Shimmer.fromColors(
                              baseColor: AppColors.shimmerBaseColor,
                              highlightColor: AppColors.white,
                              child: CommonButton(
                                height: 40.h,
                                width: context.width * 0.2,
                              ),
                            ),
                          )
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 20.w,
                  );
                },
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 20.w),

        SizedBox(
          height: 20.h,
        )
      ],
    ));
  }
}

/// Shimmer Add more Items Additional Note Widget
Widget _addMoreItemsAdditionalNoteWidget(BuildContext context) {
  return Row(
    children: [
      _commonMoreItem(context),
      SizedBox(
        width: 20.w,
      ),
      _commonMoreItem(context),
    ],
  ).paddingSymmetric(horizontal: 20.w, vertical: 20.h);
}

/// Shimmer Common More item Widget
Widget _commonMoreItem(BuildContext context) {
  return Expanded(
      child: Shimmer.fromColors(
    baseColor: AppColors.shimmerBaseColor,
    highlightColor: AppColors.white,
    child: CommonButton(
      height: 60.h,
    ),
  ));
}

/// Shimmer Add Combo Widget
Widget _markAddComboWidget(BuildContext context) {
  return Row(
    children: [
      CommonShimmer(height: 24.h, width: 24.h),
      SizedBox(width: 5.w),
      CommonShimmer(height: 15.h, width: context.width * 0.3),
    ],
  ).paddingSymmetric(horizontal: 20.w, vertical: 10.h);
}

/// Shimmer Additional Note Text Widget
Widget _additionalNoteTextAddedWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          CommonShimmer(height: 15.h, width: context.width * 0.3),
          const Spacer(),
          CommonShimmer(height: 15.h, width: context.width * 0.1),
        ],
      ),
      SizedBox(
        height: 20.h,
      ),
    ],
  ).paddingAll(20.h);
}

/// Shimmer My Tray List Widget
Widget _myTrayList(BuildContext context) {
  return CommonCard(
      child: Row(
    children: [
      /// item image
      ClipOval(
        child: CommonShimmer(
          height: 115.h,
          width: 115.h,
        ),
      ),

      SizedBox(
        width: 15.w,
      ),

      /// item name, close icon
      Expanded(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// item name
                CommonShimmer(height: 20.h, width: context.width * 0.3),

                SizedBox(width: 20.w),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),

            ///Attribute and Attribute Name
            ListView.separated(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonShimmer(height: 15.h, width: context.width * 0.7)
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.h,
                );
              },
            ),

            SizedBox(
              height: 10.h,
            ),

            /// customize text & add & remove & item count
            Row(
              children: [
                _customizeTextWidget(context),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30.h,
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: const CommonSVG(strIcon: AppAssets.svgRemove)),
                      Container(
                        width: 60.w,
                        alignment: Alignment.center,
                        child: CommonShimmer(
                          height: 20.h,
                          width: 10.h,
                        ).paddingSymmetric(horizontal: 10.w),
                      ),
                      Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.white,
                          child: const CommonSVG(strIcon: AppAssets.svgAdd)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ],
  ).paddingSymmetric(horizontal: 15.w, vertical: 20.h));
}

/// Shimmer Customize Text Widget
Widget _customizeTextWidget(BuildContext context) {
  return Row(
    children: [
      CommonShimmer(height: 20.h, width: context.width * 0.1),
      Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: Icon(
            Icons.keyboard_arrow_down,
            size: 15.h,
          ))
    ],
  );
}
