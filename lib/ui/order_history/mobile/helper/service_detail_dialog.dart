import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/repository/order_history/model/product_history_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ServiceDetailDialog extends StatelessWidget with BaseStatelessWidget{
  final ProductHistoryModel orderInfo;

  const ServiceDetailDialog({
    super.key,
    required this.orderInfo,

  });



  @override
  Widget buildPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          title: 'I need a document',
          textStyle: TextStyles.medium.copyWith(
              fontSize: 18.sp
          ),
        ),
        SizedBox(height: 30.h,),
        CommonText(
          title: LocalizationStrings.keySubject.localized,
          textStyle: TextStyles.regular.copyWith(
            fontSize: 14.sp,
              color: AppColors.grey8D8C8C
          ),
        ).paddingOnly(bottom: 8.h),
        CommonText(
          title: 'Lorem ipsum dolor sit amet, eiusmod tempor incididunt ut labore...',
          maxLines: 2,
          textStyle: TextStyles.regular.copyWith(
              fontSize: 14.sp,
              color: AppColors.black
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        CommonText(
          title: LocalizationStrings.keyDescription.localized,
          textStyle: TextStyles.regular.copyWith(
              fontSize: 14.sp,
              color: AppColors.grey7E7E7E
          ),
        ).paddingOnly(bottom: 8.h),
        CommonText(
          title: 'Lorem ipsum dolor sit amet, eiusmod tempor incididunt ut labore Lorem ipsum dolor sit amet, eiusmod tempor incididunt ut labore ',
          textStyle: TextStyles.regular.copyWith(
              fontSize: 14.sp,
              color: AppColors.black
          ),
          maxLines: 2,
        ),
        SizedBox(
          height: 25.h,
        ),
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final orderHistoryWatch = ref.watch(orderHistoryController);

          return SizedBox(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: orderHistoryWatch.productDetailTitle.length,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                //OrderModel model = orderListWatch.orderList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      title: orderHistoryWatch.productDetailTitle[index],
                      textStyle: TextStyles.regular.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.grey7E7E7E
                      ),
                    ).paddingOnly(bottom: 5.h),
                    CommonText(
                      title: orderHistoryWatch.productDetailSubTitle[index],
                      textStyle: TextStyles.regular.copyWith(
                          fontSize: 14.sp,
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
        Container(
          height: 42.h,
          width: 0.2.sw,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyB9B9B9),
              borderRadius: BorderRadius.all(Radius.circular(24.r))
          ),
          child: Center(
            child: CommonText(
              title: orderInfo.status,
              textStyle: TextStyles.regular.copyWith(
                  color: AppColors.greyB9B9B9
              ),
            ),
          ),
        ).paddingSymmetric(vertical: 24.h),
        InkWell(
          onTap: () {
            Navigator.pop(context);

          },
          child: Container(
            width: double.maxFinite,
            height: 0.06.sh,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.blue009AF1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.r))
            ),
            child: Center(
              child: CommonText(
                title: LocalizationStrings.keyClose.localized,
                textStyle: TextStyles.regular.copyWith(
                    color: AppColors.blue009AF1
                ),
              ),
            ),
          ),
        )

      ],
    ).paddingSymmetric(vertical: 30.h, horizontal: 20.w);
  }
}
