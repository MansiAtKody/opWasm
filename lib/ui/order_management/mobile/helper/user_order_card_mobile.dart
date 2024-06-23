import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/user_card_top_widget_mobile.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserCardMobile extends StatelessWidget with BaseStatelessWidget {
  final SocketOrders? order;
  final int index;


  const UserCardMobile({Key? key, required this.order,required this.index }) : super(key: key);

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
            orderNote: order?.additionalNote ?? '',
            ticketNo: order?.uuid ?? '',
          ),
          SizedBox(
            height: 21.h,
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final orderStatusWatch = ref.watch(orderStatusController);
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: order?.ordersItems?.length ?? 0,
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
                              imageURL: order?.ordersItems?[orderItemIndex].productImage??'',
                              contentMode: BoxFit.fill,
                            ),
                          ),
                          order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name
                              ? Center(
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.grey8D8C8C.withOpacity(0.4),
                                    ),
                                    // child: ,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonText(
                              title: order?.ordersItems?[orderItemIndex].productName ?? '',
                              textStyle: TextStyles.regular.copyWith(
                                fontSize: 12.sp,
                                color: order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name ? AppColors.grey8D8C8C : AppColors.black,
                                decoration: order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                            ),
                            CommonText(
                              title: order?.ordersItems?[orderItemIndex].ordersItemAttributes?.map((e) => e.attributeNameValue).toList().join(',') ?? '',
                              maxLines: 2,
                              textStyle: TextStyles.regular.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.grey8D8C8C,
                                decoration: order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                            )
                          ],
                        ).paddingOnly(left: 10.w),
                      ),
                      const Spacer(),
                      order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name?
                      const Offstage()
                          :(orderStatusWatch.orderItemStatusUpdate.isLoading && orderStatusWatch.updatingOrderItemIndex == orderItemIndex && orderStatusWatch.updatingOrderIndex == index)?
                      LoadingAnimationWidget.waveDots(color: AppColors.black, size: 10.sp)
                          :InkWell(
                        onTap: () {
                          orderStatusWatch.updateOrderStatus(order?.uuid??'', OrderStatusEnum.REJECTED,itemUuid:order?.ordersItems?[orderItemIndex].uuid );
                          orderStatusWatch.orderItemStatusUpdateApi(context,order?.uuid??'' , order?.ordersItems?[orderItemIndex].uuid??'', OrderStatusEnum.REJECTED);
                        },
                        child: SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: const CommonSVG(
                            strIcon: AppAssets.svgCancelOrder,
                            boxFit: BoxFit.scaleDown,
                          ),
                        ),
                      )
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
              final orderStatusWatch = ref.watch(orderStatusController);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AbsorbPointer(
                      absorbing:  orderStatusWatch.orderStatusUpdate.isLoading && orderStatusWatch.updateOrderIndex != index,
                      child: CommonButton(
                        isButtonEnabled: true,
                        height: 40.h,
                        width: 110.w,
                        buttonEnabledColor: AppColors.green14B500,
                        buttonText: LocalizationStrings.keyAccept.localized,
                        isLoading: orderStatusWatch.orderStatusUpdate.isLoading && orderStatusWatch.updatingOrderEnum == OrderStatusEnum.ACCEPTED && orderStatusWatch.updateOrderIndex == index,
                        buttonTextStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
                        onTap: () async{
                          await orderStatusWatch.orderStatusUpdateApi(context, order?.uuid ?? '', OrderStatusEnum.ACCEPTED).then((value){
                            if(orderStatusWatch.orderStatusUpdate.success?.status == ApiEndPoints.apiStatus_200){
                              orderStatusWatch.updateOrderStatus(order?.uuid ?? '', OrderStatusEnum.ACCEPTED);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: AbsorbPointer(
                      absorbing:  orderStatusWatch.orderStatusUpdate.isLoading && orderStatusWatch.updateOrderIndex != index,
                      child: CommonButton(
                        height: 40.h,
                        isButtonEnabled: true,
                        width: 110.w,
                        buttonEnabledColor: AppColors.redEE0000,
                        isLoading: orderStatusWatch.orderStatusUpdate.isLoading && orderStatusWatch.updatingOrderEnum == OrderStatusEnum.REJECTED && orderStatusWatch.updatingOrderIndex == index,
                        buttonText: LocalizationStrings.keyDecline.localized,
                        buttonTextStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
                        onTap: () {
                          orderStatusWatch.orderStatusUpdateApi(context, order?.uuid ?? '', OrderStatusEnum.REJECTED);
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
