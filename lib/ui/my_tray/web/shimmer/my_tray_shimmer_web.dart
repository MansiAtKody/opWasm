import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:shimmer/shimmer.dart';

class MyTrayWebShimmer extends StatelessWidget with BaseStatelessWidget {
  const MyTrayWebShimmer({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),

          ///Add not and add more item widget
          Row(
            children: [
              CommonShimmer(height: 20.h, width: 60.w),

              const Spacer(
                flex: 4,
              ),

              /// Additional Note Button
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.white,
                child: const CommonButton(),
              ),

              SizedBox(
                width: 20.w,
              ),

              /// Add More Items Widget
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.white,
                child: const CommonButton(),
              )
            ],
          ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),

          ///My tray list
          Column(
            children: [
              _myTrayWidget(context),
              SizedBox(
                height: 80.h,
              ),
              SizedBox(
                height: 80.h,
              ),
            ],
          )
        ],
      ),
    );
  }
}

///my Tray list
Widget _myTrayWidget(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _myTrayTileListWebWidget(context).paddingOnly(bottom: 10.h);
          },
        ).paddingOnly(left: 30.w, right: 30.w, top: 20.h),
        Row(
          children: [
            CommonShimmer(height: 24.h, width: 24.h).paddingOnly(right: 10.w),
            CommonShimmer(height: 20.h, width: context.width * 0.1),
          ],
        ).paddingOnly(left: 30.w, bottom: 30.h),
      ],
    ),
  ).paddingSymmetric(horizontal: 20.w);
}

/// My Tray Tile List Web Widget
Widget _myTrayTileListWebWidget(BuildContext context) {
  return CommonCard(
      color: AppColors.lightPinkF7F7FC,
      child: Row(
        children: [
          /// item image
          ClipOval(
            child: CommonShimmer(
              height: 124.h,
              width: 124.h,
            ),
          ),

          SizedBox(
            width: 36.w,
          ),

          /// item name, close icon
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// item name
                    CommonShimmer(height: 20.h, width: context.width * 0.1),

                    SizedBox(width: 20.w),
                  ],
                ),

                SizedBox(height: 17.h),

                ///Attribute and Attribute Name
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonShimmer(height: 20.h, width: context.width * 0.2),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 17.h);
                  },
                ),

                /// customize text & add & remove & item count
                Row(
                  children: [
                    _customizeTextWidget(),
                    const Spacer(),
                    Row(
                      children: [
                        _widgetQtyButton(),
                        CommonShimmer(
                          height: 30.h,
                          width: 15.w,
                        ).paddingSymmetric(horizontal: 10.w),
                        _widgetQtyButton(),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ).paddingOnly(left: 41.w, top: 30.h, bottom: 30, right: 30));
}

/// Customization Text Widget
Widget _customizeTextWidget() {
  return Row(
    children: [
      CommonShimmer(height: 15.h, width: 60.h),
      Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.white,
          child: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primary2,
            size: 25.h,
          ))
    ],
  );
}

/// Qty widget
Widget _widgetQtyButton() {
  return ClipOval(child: CommonShimmer(height: 50.h, width: 50.h));
}
