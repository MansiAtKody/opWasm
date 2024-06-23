import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_history/mobile/helper/product_detail_dialog.dart';
import 'package:kody_operator/ui/order_history/web/helper/common_status_button.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/framework/utility/extension/int_extension.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';

class OrderHistoryDetailWidget extends ConsumerWidget with BaseConsumerWidget {
  final OrderData? orderDetail;

  const OrderHistoryDetailWidget(
      {Key? key,
        this.orderDetail,
      })
      : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final orderHistoryWatch = ref.watch(orderHistoryController);
      return InkWell(
        onTap: () async{
          orderHistoryWatch.orderDetailApi(context, orderDetail?.uuid??'');
          showWidgetDialog(
            context,
            //  orderHistoryWatch.selectedOrderType == orderHistoryWatch.orderTypeList[0] ?const  ProductDetailDialog() : Container(),  //ServiceDetailDialog(orderInfo: orderDetail),
            const  ProductDetailDialog()   ,//ServiceDetailDialog(orderInfo: orderDetail),
                () {},
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.lightPink,
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final orderHistoryWatch = ref.watch(orderHistoryController);

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ///order detail title
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderHistoryWatch.title.length,
                        itemBuilder: (context, index) {
                          return CommonText(
                            title: orderHistoryWatch.title[index],
                            textStyle: TextStyles.regular.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.grey8D8C8C
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 20.h,
                          );
                        },
                      ),
                      CommonText(
                        title: LocalizationStrings.keyStatus.localized,
                        textStyle: TextStyles.regular.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.grey8D8C8C
                        ),
                      ).paddingOnly(top: 20.h),
                    ],
                  ),
                ),

                ///order detail data
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CommonText(
                          title: orderDetail?.uuid??'',
                          textStyle: TextStyles.regular.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.black
                          ),
                        ).paddingOnly(bottom: 20.h),
                        CommonText(
                          title: orderDetail?.entityName??'',
                          textStyle: TextStyles.regular.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.black
                          ),
                        ).paddingOnly(bottom: 20.h),
                        CommonText(
                          title: orderDetail?.locationPointsName??'',
                          textStyle: TextStyles.regular.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.black
                          ),
                        ).paddingOnly(bottom: 20.h),
                        CommonText(
                          title: dateFormatFromDateTime(orderDetail?.createdAt?.milliSecondsToDateTime()??DateTime.now(),'dd-MM-yyyy hh:mm a').toString(),
                          textStyle: TextStyles.regular.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.black
                          ),
                        ).paddingOnly(bottom: 17.h),
                        CommonStatusButton(status: orderDetail?.status ??OrderStatusEnum.REJECTED.name)

                      ],
                    ))
              ],
            ).paddingSymmetric(vertical: 25.h, horizontal: 20.w);
          },),
        ),
      );
  }
}
