
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/user_management/web/helper/user_card_top_widget.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserCardWeb extends StatelessWidget with BaseStatelessWidget {
  final SocketOrders? order;
  final int index;

  const UserCardWeb({Key? key, required this.order, required this.index}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    /// commented coffee machine code
    // Map<String, dynamic> coffeeRequest = ({});
    // if (order?.ordersItems?.where((element) => coffeeList.contains(element.productName)).isNotEmpty ?? false) {
    //   coffeeRequest = ({
    //     'data': {
    //       'key': coffeeKeyJson['${order?.ordersItems?.where((element) => coffeeList.contains(element.productName)).firstOrNull?.productName}']['key'],
    //     }
    //   });
    //   List<Map<String, dynamic>> optionList = [
    //     {
    //       'key': attributeKeyJson['Temperature']['${order?.ordersItems?.where((element) => coffeeList.contains(element.productName)).firstOrNull?.productName}']['key'],
    //       'value': attributeKeyJson['Temperature']['${order?.ordersItems?.where((element) => coffeeList.contains(element.productName)).firstOrNull?.productName}']['value'],
    //     },
    //     {'key': 'ConsumerProducts.CoffeeMaker.Option.MultipleBeverages', 'value': false},
    //   ];
    //   order?.ordersItems?.where((element) => coffeeList.contains(element.productName)).firstOrNull?.ordersItemAttributes?.forEach((element) {
    //     Map<String, dynamic> attributeMap = ({
    //       'key': attributeKeyJson['${element.attributeValue}']['key'],
    //       'value': attributeKeyJson['${element.attributeValue}'][element.attributeNameValue],
    //     });
    //     if (attributeKeyJson['${element.attributeValue}']['unit'] != null) {
    //       attributeMap['unit'] = attributeKeyJson['${element.attributeValue}']['unit'];
    //     }
    //     optionList.add(attributeMap);
    //   });
    //   coffeeRequest['data']['options'] = optionList;
    // }
    return Consumer(
      builder: (context, ref, child) {
        final orderStatusWatch = ref.watch(orderStatusController);
        // final coffeeWatch = ref.watch(selectCoffeeController);
        // bool isPreparingEnable = (coffeeList.contains(order?.ordersItems?.where((element) => coffeeList.contains(element.productName)).firstOrNull?.productName) &&
        //     (coffeeWatch.activeCoffeeState.isLoading || coffeeWatch.selectCoffeeState.isLoading) &&
        //     (orderStatusWatch.updatingOrderIndex != index));
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
                  orderNote: order?.additionalNote,
                  ticketNo: order?.uuid ?? '',
                ).paddingSymmetric(horizontal: 16.w),
                SizedBox(
                  height: 21.h,
                ),
                // (coffeeList.contains(order?.ordersItems?.where((element) => coffeeList.contains(element.productName)).firstOrNull?.productName) &&
                //         (coffeeWatch.activeCoffeeState.isLoading || coffeeWatch.selectCoffeeState.isLoading) &&
                //         (orderStatusWatch.updatingOrderIndex == index))
                //     ? LinearProgressIndicator(value: coffeeWatch.loaderValue)
                //     : const Offstage(),
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
                      itemCount: order?.ordersItems?.length ?? 0,
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
                                      imageURL: order?.ordersItems?[orderItemIndex].productImage ?? '',
                                      contentMode: BoxFit.scaleDown,
                                    ),
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
                                      fontSize: 10.sp,
                                      color: order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name ? AppColors.grey8D8C8C : AppColors.black,
                                      decoration: order?.ordersItems?[orderItemIndex].status == OrderStatusEnum.CANCELED.name ? TextDecoration.lineThrough : TextDecoration.none,
                                    ),
                                  ),
                                  CommonText(
                                    title: order?.ordersItems?[orderItemIndex].ordersItemAttributes?.map((e) => e.attributeNameValue).toList().join(',') ?? '',
                                    maxLines: 2,
                                    textStyle: TextStyles.regular.copyWith(
                                      fontSize: 10.sp,
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
                            LoadingAnimationWidget.waveDots(color: AppColors.black, size: 10.sp).paddingOnly(right: 16.w)
                                :InkWell(
                              onTap: () async  {
                                orderStatusWatch.updateOrderStatus(order?.uuid??'', OrderStatusEnum.REJECTED,itemUuid:order?.ordersItems?[orderItemIndex].uuid );
                                await orderStatusWatch.orderItemStatusUpdateApi(context,order?.uuid??'' , order?.ordersItems?[orderItemIndex].uuid??'', OrderStatusEnum.REJECTED);
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
                            absorbing:orderStatusWatch.orderStatusUpdate.isLoading && orderStatusWatch.updateOrderIndex != index,
                            child: CommonButton(
                              isButtonEnabled: true,
                              height: 40.h,
                              width: 110.w,
                              buttonEnabledColor: AppColors.green14B500,
                              buttonText: LocalizationStrings.keyAccept.localized,
                              isLoading: orderStatusWatch.orderStatusUpdate.isLoading && orderStatusWatch.updatingOrderEnum == OrderStatusEnum.ACCEPTED && orderStatusWatch.updateOrderIndex == index,
                              // isLoading: (coffeeWatch.activeCoffeeState.isLoading || coffeeWatch.selectCoffeeState.isLoading || orderStatusWatch.orderStatusUpdate.isLoading) &&
                              //     (orderStatusWatch.updatingOrderEnum == OrderStatusEnum.ACCEPTED || orderStatusWatch.updatingOrderEnum == OrderStatusEnum.PREPARED) &&
                              //     orderStatusWatch.updatingOrderIndex == index,
                              buttonTextStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
                              onTap: () async{
                                // coffeeWatch.resetLoaderValue();
                                // /*coffeeWatch.na (context).then((value) {
                                //   coffeeWatch.startDasherAPI(context);
                                // });*/
                                // ///Prepare Coffee
                                // if (coffeeList.contains(order?.ordersItems?.where((element) => coffeeList.contains(element.productName)).firstOrNull?.productName)) {
                                //   orderStatusWatch.updateOrderStatus(order?.uuid ?? '', OrderStatusEnum.ACCEPTED);
                                //   SSESocketManager.instance.subscribeSocket(
                                //     (data) {
                                //       if (jsonDecode(data)['items'] != []) {
                                //         if (jsonDecode(data)['items'][0]['uri'] == '/api/homeappliances/BOSCH-CTL636EB6-68A40EA7DD54/programs/active/options/BSH.Common.Option.ProgramProgress') {
                                //           coffeeWatch.updateLoaderValue(int.parse((jsonDecode(data)['items'][0]['value']).toString()));
                                //         }
                                //         if (jsonDecode(data)['items'][0]['uri'] == '/api/homeappliances/BOSCH-CTL636EB6-68A40EA7DD54/status/BSH.Common.Status.OperationState') {
                                //           if (jsonDecode(data)['items'][0]['value'] == 'BSH.Common.EnumType.OperationState.Finished') {
                                //             SSESocketManager.instance.unSubscribeSocket();
                                //             ///Update Status
                                //             orderStatusWatch.orderStatusUpdateApi(context, order?.uuid ?? '', OrderStatusEnum.ACCEPTED).then((value) {
                                //               orderStatusWatch.orderStatusUpdateApi(context, order?.uuid ?? '', OrderStatusEnum.PREPARED);
                                //               coffeeWatch.activeCoffeeState.isLoading = false;
                                //               coffeeWatch.notifyListeners();
                                //             });
                                //           }
                                //         }
                                //       }
                                //     },
                                //   );
                                //   coffeeWatch.selectProgramAPI(context, request: jsonEncode(coffeeRequest)).then((value) {
                                //     if (coffeeWatch.selectCoffeeState.success?.status == ApiEndPoints.apiStatus_200) {
                                //       coffeeWatch.activeProgramAPI(context, request: jsonEncode(coffeeRequest));
                                //     }
                                //   });
                                // }
                                //
                                // /// Update order status api
                                // else {
                                //  await orderStatusWatch.orderStatusUpdateApi(context, order?.uuid ?? '', OrderStatusEnum.ACCEPTED).then((value){
                                //    if(orderStatusWatch.orderStatusUpdate.success?.status == ApiEndPoints.apiStatus_200){
                                //      orderStatusWatch.updateOrderStatus(order?.uuid ?? '', OrderStatusEnum.ACCEPTED);
                                //    }
                                //  });
                                //
                                // }
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
                          child: CommonButton(
                            height: 40.h,
                            isButtonEnabled: true,
                            width: 110.w,
                            buttonEnabledColor: AppColors.redEE0000,
                            buttonText: LocalizationStrings.keyDecline.localized,
                            isLoading: orderStatusWatch.orderStatusUpdate.isLoading && orderStatusWatch.updatingOrderEnum == OrderStatusEnum.REJECTED && orderStatusWatch.updateOrderIndex == index,
                            buttonTextStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
                            onTap: () {
                              orderStatusWatch.orderStatusUpdateApi(context, order?.uuid ?? '', OrderStatusEnum.REJECTED);
                            },
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