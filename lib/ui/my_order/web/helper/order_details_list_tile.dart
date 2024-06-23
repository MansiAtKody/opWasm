

import 'package:kody_operator/framework/repository/order/model/response/order_details_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/my_order/web/helper/status_button_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderDetailsListTile extends StatelessWidget {
  final OrderDetailsOrdersItem? orderDetailsModel;
  const OrderDetailsListTile({super.key, required this.orderDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(15.r)), border: Border.all(color: AppColors.greyE6E6E6)),
      child: Row(
        children: [
          SizedBox(
              height: 53.h,
              width: 53.w,
              child: CacheImage(imageURL: orderDetailsModel?.productImage ?? '')),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  title: orderDetailsModel?.productName ?? '',
                  textStyle: TextStyles.regular.copyWith(
                    color: AppColors.black,
                  ),
                ),
                CommonText(
                  title: orderDetailsModel?.productDescription ?? '',
                  maxLines: 2,
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.grey8D8C8C,
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: orderDetailsModel?.ordersItemAttributes?.length,
                    itemBuilder: (context, index) {
                      return CommonText(
                        title: orderDetailsModel?.ordersItemAttributes?[index].attributeNameValue ?? '',
                        maxLines: 2,
                        textStyle: TextStyles.regular.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.yellowEF8F00,
                        ),
                      );
                    },
                ),
              ],
            ).paddingOnly(left: 10.w),
          ),
          const Spacer(),
          StatusButtonWidget(status: orderDetailsModel?.status ?? ''),
        ],
      ).paddingSymmetric(horizontal: 10.w, vertical: 12.h),
    );
  }
}
