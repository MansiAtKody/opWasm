import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_detail_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/int_extension.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class ProductDetailDialog extends ConsumerWidget with BaseConsumerWidget {
  const ProductDetailDialog({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, ref) {
    final orderHistoryWatch = ref.watch(orderHistoryController);
    return !(orderHistoryWatch.orderDetailState.isLoading)
        ? (orderHistoryWatch.orderDetailState.success?.data==null)
        ?  const EmptyStateWidget()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// User name
                  CommonText(
                    title: orderHistoryWatch.orderDetailState.success?.data?.entityName ?? '',
                    textStyle: TextStyles.medium.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),

                  /// Location point
                  Row(
                    children: [
                      const CommonSVG(strIcon: AppAssets.svgPlace)
                          .paddingOnly(right: 15.w),
                      CommonText(
                        title: orderHistoryWatch.orderDetailState.success?.data?.locationPointsName ?? '',
                        textStyle: TextStyles.regular.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.black515151,
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 15.h),

                  /// Created Time
                  Row(
                    children: [
                      const CommonSVG(strIcon: AppAssets.svgOrderTime)
                          .paddingOnly(right: 16.w, left: 2.w),
                      CommonText(
                        title: dateFormatFromDateTime(orderHistoryWatch.orderDetailState.success?.data?.createdAt?.milliSecondsToDateTime(), 'dd-MM-yyyy hh:mm a').toString() ,
                        textStyle: TextStyles.regular.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.black515151,
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 25.h),

                  /// Order id and status
                  Row(
                    children: [
                      Container(
                        height: 42.h,
                        constraints: BoxConstraints(
                          maxWidth: context.width * 0.4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.yellowFFEDBF,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.r),
                          ),
                        ),
                        child: Center(
                          child: CommonText(
                            title: orderHistoryWatch.orderDetailState.success?.data?.uuid ?? '',
                            textStyle: TextStyles.regular.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.black,
                            ),
                            
                          ).paddingSymmetric(horizontal: 18.w, vertical: 8.h),
                        ),
                      ).paddingOnly(right: 12.w),
                      Container(
                        height: 42.h,
                        width: 0.24.sw,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyB9B9B9),
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.r))),
                        child: Center(
                          child: CommonText(
                            title: orderHistoryWatch.orderDetailState.success?.data?.status ?? '',
                            textStyle: TextStyles.regular.copyWith(
                                fontSize: 14.sp, color: AppColors.greyB9B9B9),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 0,
                color: AppColors.greyE6E6E6,
              ).paddingSymmetric(vertical: 20.h),

              ///Order Item List
              SizedBox(
                height: 0.2.sh,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: orderHistoryWatch.orderDetailState.success?.data?.ordersItems?.length ?? 0,
                  itemBuilder: (context, index) {
                    OrdersItem? orderItems = orderHistoryWatch.orderDetailState.success?.data?.ordersItems?[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteF7F7FC,
                          borderRadius:
                              BorderRadius.all(Radius.circular(21.r))),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(57.r),
                            child: SizedBox(
                                height: 40.h,
                                width: 40.w,
                                child: CacheImage(
                                  imageURL: orderItems?.productImage ??''
                                )),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                ///item name
                                CommonText(
                                  title: orderItems?.productName ?? ' ',
                                  textStyle: TextStyles.regular.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.black,
                                  ),
                                ),

                                ///Customization List
                                SizedBox(
                                  height: 20.h,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: orderItems?.ordersItemAttributes?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        OrdersItemAttribute?
                                            orderItemAttribute = orderItems?.ordersItemAttributes?[index];
                                        return Row(
                                          children: [
                                            CommonText(
                                              title: orderItemAttribute?.attributeNameValue ?? '',
                                              maxLines: 2,
                                              textStyle:
                                                  TextStyles.regular.copyWith(
                                                fontSize: 14.sp,
                                                color: AppColors.grey8D8C8C,
                                              ),
                                            ),
                                            index == (orderItems?.ordersItemAttributes?.length ?? 0) - 1
                                                ? const Offstage()
                                                : const CommonSVG(
                                                        strIcon: AppAssets
                                                            .svgDivider)
                                                    .paddingSymmetric(
                                                        horizontal: 15.w),
                                          ],
                                        );
                                      }),
                                )
                              ],
                            ).paddingOnly(left: 10.w),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 10.w, vertical: 12.h),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                ),
              ).paddingOnly(bottom: 15.h),

              /// Close Button
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
                      borderRadius: BorderRadius.all(Radius.circular(30.r))),
                  child: Center(
                    child: CommonText(
                      title: LocalizationStrings.keyClose.localized,
                      textStyle: TextStyles.regular
                          .copyWith(color: AppColors.blue009AF1),
                    ),
                  ),
                ),
              )
            ],
          ).paddingSymmetric(vertical: 25.h, horizontal: 20.w)
         :SizedBox(
           height: context.height * 0.5,
           width: context.width * 0.9,
            child:const  DialogProgressBar(isLoading:true)
    );
  }
}
