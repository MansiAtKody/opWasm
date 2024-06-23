import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/order_management/order_management_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_management/web/helper/order_details.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderManagementRightWidget extends ConsumerWidget with BaseConsumerWidget {
  const OrderManagementRightWidget({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final orderManagementWatch = ref.watch(orderManagementController);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r), color: AppColors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              /// Top Widget
              // const OrderManagementTopWidget(),
              SizedBox(
                height: 37.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(title: LocalizationStrings.keyTotalOrders.localized, textStyle: TextStyles.regular.copyWith(color: AppColors.black1F1E1F, fontSize: 20.sp)),
                  CommonText(title: '(16)', textStyle: TextStyles.regular.copyWith(color: AppColors.black1F1E1F, fontSize: 20.sp)),
                ],
              ).paddingOnly(left: 30.w, right: 36.w),

              /// Center Widget
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 36.w, mainAxisSpacing: 30.h, mainAxisExtent: MediaQuery.of(context).size.height * 0.29),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      /// Order Details Dialogue
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: AppColors.white,
                            insetPadding: EdgeInsets.all(20.sp),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: SizedBox(width: MediaQuery.sizeOf(context).width * 0.5, height: MediaQuery.sizeOf(context).width * 0.3, child: const OrderDetails()),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://marketplace.canva.com/EAFXS8-cvyQ/1/0/1600w/canva-brown-and-light-brown%2C-circle-framed-instagram-profile-picture-2PE9qJLmPac.jpg',
                                  height: 63.w,
                                  width: 63.w,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              CommonText(
                                title: 'John Smith',
                                textStyle: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 14.sp),
                              )
                            ],
                          ),
                          Container(color: AppColors.whiteEEEEEE, width: 182.w, height: 0.5.h).paddingSymmetric(vertical: 15.h),
                          CommonSVG(strIcon: AppAssets.svgCoffeeCup, height: 51.w, width: 51.w)
                        ],
                      ).paddingSymmetric(vertical: 15.h, horizontal: 15.w),
                    ),
                  );
                },
              ).paddingOnly(left: 32.w, right: 36.w, top: 37.h),
              SizedBox(
                height: 39.h,
              ),

              /// Show Tray Button
              orderManagementWatch.isPressed == false
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: CommonButton(
                              onTap: () {
                                orderManagementWatch.showTray();
                              },
                              buttonText: LocalizationStrings.keyShowTray.localized,
                              backgroundColor: AppColors.redFF3D00)
                          .paddingOnly(left: 60.w, right: 42.w, top: 45.h, bottom: 45.h),
                    )
                  : const SizedBox()
            ],
          ),
        ).paddingOnly(left: 44.w, right: 42.w, bottom: 45.h, top: 45.h),
      ],
    );
  }
}
