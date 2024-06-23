import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_detail_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/order_history/web/helper/common_status_button.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/framework/utility/extension/int_extension.dart';

import 'package:kody_operator/ui/utils/const/app_enums.dart';

class OrderDetailDialogWidgetWeb extends ConsumerWidget with BaseConsumerWidget {
  const OrderDetailDialogWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final orderHistoryWatch = ref.watch(orderHistoryController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ///User name
                  CommonText(
                    title: orderHistoryWatch.orderDetailState.success?.data?.entityName??'',
                    textStyle: TextStyles.regular.copyWith(fontSize: 22.sp),
                  ).paddingOnly(right: 15.w),

                  ///Order id
                  Container(
                    decoration: BoxDecoration(color: AppColors.yellowFFEDBF, borderRadius: BorderRadius.all(Radius.circular(24.r))),
                    child: CommonText(
                      title: orderHistoryWatch.orderDetailState.success?.data?.uuid??'',
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: 22.sp,
                        color: AppColors.black,
                      ),
                    ).paddingSymmetric(horizontal: 18.w, vertical: 8.h),
                  ).paddingOnly(right: 15.w),

                  ///Status
                  CommonStatusButton(status: orderHistoryWatch.orderDetailState.success?.data?.status??OrderStatusEnum.PENDING.name),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      final orderHistoryWatch = ref.watch(orderHistoryController);
                      orderHistoryWatch.animationController?.reverse(from: 0.3);
                      Navigator.pop(context);
                    },
                    child: const CommonSVG(strIcon: AppAssets.svgCrossWithBg),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Row(
          children: [

            ///Location point
            const CommonSVG(strIcon: AppAssets.svgPlace).paddingSymmetric(horizontal: 15.w),
            CommonText(
              title: orderHistoryWatch.orderDetailState.success?.data?.locationPointsName??'',
              textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black515151),
            ).paddingOnly(right: 15.w),

            const CommonSVG(strIcon: AppAssets.svgDivider).paddingSymmetric(horizontal: 15.w),

            /// Created date
            const CommonSVG(strIcon: AppAssets.svgOrderTime).paddingSymmetric(horizontal: 15.w),
            CommonText(
              title: dateFormatFromDateTime(orderHistoryWatch.orderDetailState.success?.data?.createdAt?.milliSecondsToDateTime(),'dd-MM-yyyy hh:mm a').toString(),
              textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black515151),
            ).paddingOnly(right: 15.w),
          ],
        ),
        SizedBox(
          height: 21.h,
        ),
        /// Itmes List widget
        Container(
          decoration: BoxDecoration(color: AppColors.buttonDisabledColor, borderRadius: BorderRadius.all(Radius.circular(15.r)), border: Border.all(color: AppColors.buttonDisabledColor)),
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: orderHistoryWatch.orderDetailState.success?.data?.ordersItems?.length??0,
                itemBuilder: (context, index) {
                OrdersItem? orderItems =orderHistoryWatch.orderDetailState.success?.data?.ordersItems?[index];
                  return Container(
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(15.r)), border: Border.all(color: AppColors.greyE6E6E6)),
                    child: Row(
                      children: [
                        ///Image
                    ClipRRect(
                    borderRadius: BorderRadius.circular(57.r),
                          child: SizedBox(
                            height: 53.h,
                            width: 53.w,
                            child:CacheImage(
                              imageURL:orderItems?.productImage??'',
                            )
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///Item name
                              CommonText(
                                title:orderItems?.productName??'',
                                textStyle: TextStyles.regular.copyWith(
                                  color: AppColors.black,
                                  fontSize: 16.sp,
                                ),
                              ),

                             ///Customization list
                             SizedBox(
                               height: 20.h,
                               child: ListView.builder(
                                 shrinkWrap: true,
                                 physics: const NeverScrollableScrollPhysics(),
                                 scrollDirection: Axis.horizontal,
                                 itemCount:orderItems?.ordersItemAttributes?.length??0,
                                   itemBuilder: (context,index){
                                     OrdersItemAttribute? orderItemAttribute =  orderItems?.ordersItemAttributes?[index];
                                 return  Row(
                                   children:[
                                     CommonText(
                                     title: orderItemAttribute?.attributeNameValue??'',
                                     maxLines: 2,
                                     textStyle: TextStyles.regular.copyWith(
                                       fontSize: 14.sp,
                                       color: AppColors.grey8D8C8C,
                                     ),
                                   ),
                                     index == (orderItems?.ordersItemAttributes?.length??0)-1 ?const Offstage():const CommonSVG(strIcon: AppAssets.svgDivider).paddingSymmetric(horizontal: 15.w),
                                   ],
                                 );
                               }),
                             )

                            ],
                          ).paddingOnly(left: 10.w),
                        ),
                        const Spacer(),

                        ///Status
                        Container(
                          height: 43.h,
                          width:107.w ,
                          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(22.r)), border: Border.all(color: (orderItems?.status== OrderStatusEnum.REJECTED.name)
                              ? AppColors.redEE0000
                              : (orderItems?.status == OrderStatusEnum.DELIVERED.name)
                              ? AppColors.greyB9B9B9
                              :(orderItems?.status== OrderStatusEnum.CANCELED.name)?AppColors.yellowEF8F00:AppColors.green),),
                          child: Align(
                            alignment: Alignment.center,
                            child: CommonText(
                              title: orderItems?.status??'',
                              textAlign: TextAlign.center,
                              textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: (orderItems?.status== OrderStatusEnum.REJECTED.name)
                                  ? AppColors.redEE0000
                                  : (orderItems?.status == OrderStatusEnum.DELIVERED.name)
                                  ? AppColors.greyB9B9B9
                                  :(orderItems?.status== OrderStatusEnum.CANCELED.name)?AppColors.yellowEF8F00:AppColors.green),),
                          ),
                          ).paddingSymmetric(horizontal: 15.w),
                      ],
                    ).paddingSymmetric(horizontal: 10.w, vertical: 12.h),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
              ).paddingAll(20.h);
            },
          ),
        ),
      ],
    );
  }
}

