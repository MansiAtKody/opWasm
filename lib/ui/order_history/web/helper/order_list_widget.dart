import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_history/web/helper/common_status_button.dart';
import 'package:kody_operator/ui/order_history/web/helper/order_detail_dialog_widget.dart';
import 'package:kody_operator/ui/order_history/web/shimmer/shimmer_product_list.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:kody_operator/framework/utility/extension/int_extension.dart';

class OrderListWidget extends ConsumerWidget with BaseConsumerWidget{
  const OrderListWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final orderHistoryWatch = ref.watch(orderHistoryController);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Heading Widget
          SlideUpTransition(
              child: Table(
                textDirection: TextDirection.ltr,
                columnWidths: {
                  ///Order id
                  0: FlexColumnWidth(10.w),

                  ///User/ Entity name
                  1: FlexColumnWidth(8.w),

                  /// Location Point
                  2: FlexColumnWidth(8.w),

                  /// Created date
                  3: FlexColumnWidth(8.w),

                  /// Status
                  4: FlexColumnWidth(11.w),

                  /// View dialog
                  5: FlexColumnWidth(3.w),

                },
                children: [
                  TableRow(children: [

                    /// Order id
                    CommonText(
                      title: LocalizationStrings.keyOrderId.localized,
                      textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                      maxLines: 3,
                    ),

                    /// Entity name / user name
                    CommonText(
                      title: LocalizationStrings.keyName.localized,
                      textAlign: TextAlign.left,
                      textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                    ),

                    /// Location Points
                    CommonText(title: LocalizationStrings.keyLocationPoint.localized, textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C)),

                    /// Date
                    CommonText(
                      title: LocalizationStrings.keyDate.localized,
                      textAlign: TextAlign.left,
                      textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                    ),

                    /// Status
                    CommonText(
                      title: LocalizationStrings.keyStatus.localized,
                      textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                    ),
                    const SizedBox()
                  ]),
                ],
              ).paddingOnly(left: 17.w,right:20.w,)
          ),
          SizedBox(
            height: 25.h,
          ),

          /// List Widget
          !(orderHistoryWatch.orderListState.isLoading)
              ? (orderHistoryWatch.orderList?.isEmpty ?? true)
              ?const Expanded(child:  SingleChildScrollView(child: EmptyStateWidget()))
              : Expanded(
                child: Column(
            mainAxisSize: MainAxisSize.min,
                  children:[ Expanded(
                    child: ListView.separated(
                      controller:orderHistoryWatch.orderListScrollController ,
                      shrinkWrap: true,
                      itemCount: orderHistoryWatch.orderList?.length??0,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        OrderData? orderData = orderHistoryWatch.orderList?[index];
                        return Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.r)), color: AppColors.lightPink),
                          child: Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            columnWidths: {
                              ///Order id
                              0: FlexColumnWidth(10.w),

                              ///User/ Entity name
                              1: FlexColumnWidth(8.w),

                              /// Location Point
                              2: FlexColumnWidth(8.w),

                              /// Created date
                              3: FlexColumnWidth(8.w),

                              /// Status
                              4: FlexColumnWidth(11.w),

                              /// View dialog
                              5: FlexColumnWidth(3.w),
                            },
                            children: [
                              TableRow(
                                children: [
                                  ///Order id
                                  CommonText(
                                    title: orderData?.uuid??'',
                                    maxLines: 3,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                  ).paddingOnly(right: 12.w),

                                  /// Entity name /user name
                                  CommonText(
                                    title: orderData?.entityName??'',
                                    textAlign: TextAlign.left,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                  ).paddingOnly(right: 12.w),

                                  /// Location point
                                  CommonText(
                                    title: orderData?.locationPointsName??'',
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                  ).paddingOnly(right: 12.w),

                                  /// Date
                                  CommonText(
                                    title: dateFormatFromDateTime(orderData?.createdAt?.milliSecondsToDateTime()??DateTime.now(),'dd-MM-yyyy hh:mm a').toString(),
                                    textAlign: TextAlign.left,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                  ).paddingOnly(right: 12.w),

                                  /// status
                                  CommonStatusButton(status: orderData?.status??OrderStatusEnum.PENDING.name,).paddingOnly(right: 60.w),

                                  /// View detail icon
                                  if (orderHistoryWatch.orderDetailState.isLoading && orderHistoryWatch.updatingOrderIndex == index)
                                    LoadingAnimationWidget.waveDots(color: AppColors.black, size: 22.h).alignAtCenterLeft().paddingOnly(left: 5.w)
                                  else InkWell(
                                      onTap:() async{
                                        await orderHistoryWatch.orderDetailApi(context, orderData?.uuid??'').then((value){
                                          if(orderHistoryWatch.orderDetailState.success?.status == ApiEndPoints.apiStatus_200){
                                            showAnimatedDialog(
                                              context,
                                              title: '',
                                              heightPercentage: 64,
                                              widthPercentage: 70,
                                              isCloseButtonVisible:false,
                                              backgroundColor: AppColors.white,
                                              onPopCall: (animationController) {
                                                orderHistoryWatch.updateAnimationController(animationController);
                                              },
                                              onCloseTap: () {
                                                orderHistoryWatch.animationController?.reverse(from: 0.3);
                                                Navigator.pop(context);
                                              },
                                              child: const OrderDetailDialogWidgetWeb(),
                                            );
                                          }

                                        });

                                      },child: const CommonSVG(strIcon: AppAssets.svgExpandHistory))
                                ],
                              ),
                            ],
                          ).paddingOnly(left: 11.w,right:20.w,top: 13.h, bottom: 13.h),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 22.h,
                        );
                      },
                    ),
                  ),
                    Visibility(
                        visible: orderHistoryWatch.orderListState.isLoadMore,
                        child:const  CircularProgressIndicator(color: AppColors.black,).paddingOnly(top:22.h)),
                  ]

                ),
              )
              : const Expanded(child:  ShimmerProductList()),
          SizedBox(
            width: 50.w,
          )
        ],
      ).paddingOnly(bottom: 23.h),
    );
  }
}
