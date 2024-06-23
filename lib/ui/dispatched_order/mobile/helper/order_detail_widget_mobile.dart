import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/dispatched_order/dispatched_order_controller.dart';
import 'package:kody_operator/framework/repository/dispatch_order/model/response_model/dispatched_order_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/user_card_top_widget_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderDetailWidgetMobile extends StatelessWidget with BaseStatelessWidget {
  final TaskDetail? order;
  final int index;


  const OrderDetailWidgetMobile({Key? key, required this.order,required this.index }) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          ///User Card Top Widget
          UserCardTopWidgetMobile(
             userName: (order?.entityName == null) ? 'Admin' : order?.entityName ?? '',
             place: order?.locationPointsName ?? '',
            orderNote: '',
            ticketNo: order?.uuid ?? '',
          ),
          SizedBox(
            height: 21.h,
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: order?.taskItemResponseDtOs?.length ?? 0,
                itemBuilder: (context, orderItemIndex) {
                  //OrderModel model = orderListWatch.orderList[index];
                  return Row(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40.r),
                            child: CacheImage(
                              height: 40.w,
                              width: 40.w,
                              imageURL: order?.taskItemResponseDtOs?[orderItemIndex].productImage??'',
                              //imageURL: staticImageURL,
                              contentMode: BoxFit.fill,
                            ),
                          ),
                          // order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name
                          //     ? Center(
                          //   child: Container(
                          //     height: 40.h,
                          //     width: 40.w,
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: AppColors.grey8D8C8C.withOpacity(0.4),
                          //     ),
                          //     // child: ,
                          //   ),
                          // )
                          //     : Container()
                        ],
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonText(
                              title: order?.taskItemResponseDtOs?[orderItemIndex].productName ?? '',
                              textStyle: TextStyles.regular.copyWith(
                                fontSize: 12.sp,
                                color:  AppColors.black,
                              ),
                            ),
                            // CommonText(
                            //   title: order?.taskItemResponseDtOs?[orderItemIndex].ordersItemAttributes?.map((e) => e.attributeNameValue).toList().join(',') ?? '',
                            //   maxLines: 2,
                            //   textStyle: TextStyles.regular.copyWith(
                            //     fontSize: 12.sp,
                            //     color: AppColors.grey8D8C8C,
                            //     decoration: order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name ? TextDecoration.lineThrough : TextDecoration.none,
                            //   ),
                            // )
                          ],
                        ).paddingOnly(left: 10.w),
                      ),
                      const Spacer(),
                    ],
                  ).paddingSymmetric(horizontal: 10.w, vertical: 12.h);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 0,
                    color: AppColors.greyE6E6E6,
                  ).paddingSymmetric(horizontal: 15.w);
                },
              );
            },
          ),
          SizedBox(
            height: 13.h,
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final dispatchedOrderListWatch = ref.watch(dispatchedOrderController);

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AbsorbPointer(
                      absorbing:  dispatchedOrderListWatch.isForDelivery && dispatchedOrderListWatch.updateOrderIndex != index,
                      child: CommonButton(
                        isButtonEnabled: true,
                        height: 40.h,
                        width: 110.w,
                        buttonEnabledColor: AppColors.green14B500,
                        buttonText: LocalizationStrings.keyDelivered.localized,
                        isLoading: dispatchedOrderListWatch.isForDelivery && dispatchedOrderListWatch.updateOrderIndex == index,
                        buttonTextStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
                        onTap: () async{
                          await dispatchedOrderListWatch.changeOrderStatusApi(context: context,taskUuid: order?.uuid ?? '',status: 'DELIVERED',isForCancel: false);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: AbsorbPointer(
                      absorbing:  dispatchedOrderListWatch.isForCancelOrder && dispatchedOrderListWatch.updateOrderIndex != index,
                      child: CommonButton(
                        height: 40.h,
                        isButtonEnabled: true,
                        width: 110.w,
                        buttonEnabledColor: AppColors.redEE0000,
                        isLoading: dispatchedOrderListWatch.isForCancelOrder && dispatchedOrderListWatch.updateOrderIndex == index,
                        buttonText: LocalizationStrings.keyCancel.localized,
                        buttonTextStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
                        onTap: () async {
                          await dispatchedOrderListWatch.changeOrderStatusApi(context: context,taskUuid: order?.uuid ?? '',status: 'ROBOT_CANCELED',isForCancel: true);
                          },
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ).paddingSymmetric(vertical: 16.h, horizontal: 16.w),
    );
  }
}
