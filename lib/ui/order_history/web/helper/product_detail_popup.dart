import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';


class ProductDetailPopUp extends ConsumerStatefulWidget {
  const ProductDetailPopUp({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductDetailPopUp> createState() => _ProductDetailPopUpState();
}

class _ProductDetailPopUpState extends ConsumerState<ProductDetailPopUp> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {

    return ListView(

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CommonSVG(strIcon: AppAssets.svgProductDetail,boxFit: BoxFit.scaleDown,).paddingOnly(right: 25.w),
                CommonText(
                  title: 'I need a document',
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 24.sp
                  ),
                ),
              ],
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CommonSVG(strIcon: AppAssets.svgCross,)),
          ],
        ),
        SizedBox(height: 50.h,),
        CommonText(
          title: LocalizationStrings.keySubject.localized,
          textStyle: TextStyles.regular.copyWith(
            color: AppColors.grey7E7E7E
          ),
        ).paddingOnly(bottom: 8.h),
        CommonText(
          title: 'Lorem ipsum dolor sit amet, eiusmod tempor incididunt ut labore...',
          maxLines: 2,
          textStyle: TextStyles.regular.copyWith(
              fontSize: 18.sp,
              color: AppColors.black
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        CommonText(
          title: LocalizationStrings.keyDescription.localized,
          textStyle: TextStyles.regular.copyWith(
            color: AppColors.grey7E7E7E
          ),
        ).paddingOnly(bottom: 8.h),
        CommonText(
          title: 'Lorem ipsum dolor sit amet, eiusmod tempor incididunt ut labore Lorem ipsum dolor sit amet, eiusmod tempor incididunt ut labore ',
          textStyle: TextStyles.regular.copyWith(
              fontSize: 18.sp,
              color: AppColors.black
          ),
          maxLines: 3,
        ),
        SizedBox(
          height: 35.h,
        ),
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final orderHistoryWatch = ref.watch(orderHistoryController);

          return SizedBox(
            height: 60.h,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: orderHistoryWatch.productDetailTitle.length,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      title: orderHistoryWatch.productDetailTitle[index],
                      textStyle: TextStyles.regular.copyWith(
                          color: AppColors.grey7E7E7E
                      ),
                    ).paddingOnly(bottom: 10.h),
                    CommonText(
                      title: orderHistoryWatch.productDetailSubTitle[index],
                      textStyle: TextStyles.regular.copyWith(
                          color: AppColors.black
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 25.h,
                );
              },
            ),
          );
        },
        ),

        SizedBox(
          height: 30.h,
        ),
        CommonButton(
            width: 112.w,
            height: 40.h,
          buttonText: 'Delivered',
          buttonTextStyle: TextStyles.regular.copyWith(
            color: AppColors.grey989898
          ),
        )

      ],
    );
  }

}
