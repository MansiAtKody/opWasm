import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/order_management/order_management_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';



class OrderDetails extends ConsumerWidget with BaseConsumerWidget{
  const OrderDetails({super.key});

  ///Build Override
  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: bodyWidget(),
    );
  }

  ///body Widget
  Widget bodyWidget(){
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderManagementWatch = ref.watch(orderManagementController);
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///Top Widget
              _topWidgetOrderWidget(),
              ///Center Widget
              _centerWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonButton(
                    onTap: (){
                      orderManagementWatch.orderPersonImage('https://marketplace.canva.com/EAFXS8-cvyQ/1/0/1600w/canva-brown-and-light-brown%2C-circle-framed-instagram-profile-picture-2PE9qJLmPac.jpg');
                      Navigator.of(context).pop();
                    },
                    buttonText: 'Ready',
                    backgroundColor: AppColors.green13851E,
                  ),
                  CommonButton(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    buttonText: 'Close',
                    backgroundColor: AppColors.whiteE9E9E9,
                  ),
                ],
              ).paddingOnly(top: 41.h)
            ],
          ).paddingSymmetric(vertical: 59.h, horizontal: 59.w)
        );
      },
    );
  }


  ///Top Widget
  Widget _topWidgetOrderWidget(){
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: CachedNetworkImage(imageUrl: 'https://marketplace.canva.com/EAFXS8-cvyQ/1/0/1600w/canva-brown-and-light-brown%2C-circle-framed-instagram-profile-picture-2PE9qJLmPac.jpg', height: 63.w, width: 63.w,)),
            SizedBox(width: 32.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CommonText(
                      title: 'John Smith',
                      textStyle: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 14.sp),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      alignment: Alignment.center,
                      width: 114,
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          color: AppColors.purpleLight),
                      child: CommonText(
                        title: 'KT086',
                        textStyle: TextStyles.regular.copyWith(fontSize: 22.sp, color: AppColors.purple),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    const CommonSVG(strIcon: AppAssets.svgEmail),
                    SizedBox(width: 15.w),
                    CommonText(
                        title: 'johnsmith@gmail.com',
                        textStyle: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 22.sp)),
                    SizedBox(width: 23.w),
                    Container(height: 23.h, width: 1.w, color: AppColors.black515151,),
                    SizedBox(width: 28.w),
                    CommonText(
                        title: 'Mobile Team',
                        textStyle: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 22.sp)),
                  ],
                )
              ],
            )
          ],
        ).paddingOnly(bottom: 40.h);
    },);
  }

  ///Center Widget
  Widget _centerWidget(){
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 3,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
              mainAxisExtent: MediaQuery.of(context).size.height*0.10),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.r),
                  color: AppColors.whiteF9F9F9),
              child: Row(
                children: [
                  const CommonSVG(strIcon: AppAssets.svgCoffeeCup),
                  SizedBox(width: 20.w),
                  CommonText(
                      title: 'Cappuccino',
                      textStyle: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 22.sp)),
                ],
              ).paddingOnly(left: 10.w, top: 10.h, bottom: 12.h),
            );
          },
        );
    },);
  }
}
