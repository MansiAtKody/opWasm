
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/dispatched_order/dispatched_order_controller.dart';
import 'package:kody_operator/framework/repository/dispatch_order/model/response_model/dispatched_order_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/user_management/web/helper/user_card_top_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderDetailWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  final TaskDetail? order;
  final int index;

  const OrderDetailWidgetWeb({Key? key, required this.order, required this.index}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final dispatchedOrderListWatch = ref.watch(dispatchedOrderController);

        return Opacity(
          opacity: 1,
          child: Container(
            decoration: BoxDecoration(color: AppColors.lightPink, borderRadius: BorderRadius.all(Radius.circular(20.r)), border: Border.all(color: AppColors.pinkEDEDFF)),
            child: Column(
              children: [
                ///User Card Top Widget
                UserCardTopWidgetWeb(
                  userName: (order?.entityName == null) ? 'Admin' : order?.entityName ?? '',
                  place: order?.locationPointsName ?? '',
                  orderNote: '',
                  ticketNo: order?.uuid ?? '',
                ).paddingSymmetric(horizontal: 16.w),
                SizedBox(
                  height: 21.h,
                ),
                const Offstage(),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(maxHeight: context.height * 0.2),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(22.r)),
                      border: Border.all(color: AppColors.greyE6E6E6),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: order?.taskItemResponseDtOs?.length ?? 0,
                      itemBuilder: (context, orderItemIndex) {
                        //OrderModel model = orderListWatch.orderList[index];
                        return Row(
                          children: [
                            Stack(
                              children: [
                                ClipOval(
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    color: AppColors.whiteF7F7FC,
                                    child: CacheImage(
                                      height: 40.h,
                                      width: 40.w,
                                      imageURL: order?.taskItemResponseDtOs?[orderItemIndex].productImage ?? '',
                                      contentMode: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                // order?.taskItemResponseDtOs?[orderItemIndex].status == OrderStatusEnum.CANCELED.name
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
                                      fontSize: 10.sp,
                                      color: AppColors.black
                                      //color: order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name ? AppColors.grey8D8C8C : AppColors.black,
                                      //decoration: order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name ? TextDecoration.lineThrough : TextDecoration.none,
                                    ),
                                  )
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
                    ),
                  ).paddingSymmetric(horizontal: 16.w),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: dispatchedOrderListWatch.isForDelivery && dispatchedOrderListWatch.updateOrderIndex != index,
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
                              buttonText: LocalizationStrings.keyCancel.localized,
                              isLoading: dispatchedOrderListWatch.isForCancelOrder && dispatchedOrderListWatch.updateOrderIndex == index,
                              buttonTextStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
                              onTap: () async {
                                await dispatchedOrderListWatch.changeOrderStatusApi(context: context,taskUuid: order?.uuid ?? '',status: 'ROBOT_CANCELED',isForCancel: true);
                              },
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 16.w);
                  },
                )
              ],
            ).paddingSymmetric(vertical: 16.h),
          ),
        );
      },
    );
  }
}