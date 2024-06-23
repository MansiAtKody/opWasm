import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/datetime_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/web/helper/table_child_widget.dart';
import 'package:kody_operator/ui/order_history/web/helper/common_status_button.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderListTile extends StatelessWidget {
  final OrderListResponseData model;
  final Function()? onItemTap;
  final int? index;
  const OrderListTile({super.key, this.onItemTap, required this.model,required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ref,child) {
        final myOrderWatch =   ref.watch(myOrderController);
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.r)), color: AppColors.white),
          child: InkWell(
            onTap: () async{
              ref.read(navigationStackProvider).push(NavigationStackItem.orderFlowStatus(orderId:model.uuid ??''));
            },
            child: Table(
              textDirection: TextDirection.ltr,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(4.w), /// order id
                1: FlexColumnWidth(3.w), /// department
                2: FlexColumnWidth(4.w), /// order time
                3: FlexColumnWidth(3.w), /// total quantity
                4: FlexColumnWidth(4.w), /// status
                5: FlexColumnWidth(3.w), /// view details
                6: FlexColumnWidth(2.w), ///  Favourite
              },

              children: [
                TableRow(children: [
                  TableChildWidget(text:model.uuid ?? ''),
                  TableChildWidget(text:model.locationPointsName ?? ''),
                  TableChildWidget(text: '${DateTime.fromMillisecondsSinceEpoch(model.createdAt ?? 0).dateOnly} | ${DateTime.fromMillisecondsSinceEpoch(model.createdAt ?? 0).timeOnly}'),
                  TableChildWidget(text:model.totalQty.toString()),
                  CommonStatusButton(status: model.status ?? '', isFilled: false).paddingOnly(right: 10.w),
                  InkWell(
                    onTap: (){
                      ref.read(navigationStackProvider).push(NavigationStackItem.orderFlowStatus(orderId:model.uuid ??''));
                    },
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          title: LocalizationStrings.keyViewDetails.localized,
                          fontSize: 14.sp,
                          clrfont: AppColors.blue009AF1,
                          textDecoration: TextDecoration.underline,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: AppColors.blue009AF1,
                        ),
                      ],
                    ),
                  ),
                  ( model.status == OrderStatusEnum.REJECTED.name || model.status == OrderStatusEnum.CANCELED.name || model.status == OrderStatusEnum.DELIVERED.name)
                      ?favouriteIconWidget(myOrderWatch, context):const Offstage()

                ]),
              ],
            ).paddingOnly(left: 20.w, right: 10.w, top: 13.h, bottom: 13.h),
          ),
        );
      }
    );
  }

  Widget favouriteIconWidget(MyOrderController myOrderWatch, BuildContext context ){
    return (myOrderWatch.favouriteOrderState.isLoading && myOrderWatch.updatingFavouriteOrderIndex == index)?
      LoadingAnimationWidget.waveDots(color: AppColors.black, size: 22.h).alignAtCenterRight().paddingOnly(left: 5.w,right: 20.w):
      ///Favourite
      InkWell(
          onTap: ()async{
            await myOrderWatch.favouriteOrderApi(context, model.uuid??'', !(model.isFavourite??false)).then((value) async{
              if(model.isFavourite == false&&myOrderWatch.selectedOrderTypeFilter?.type == OrderType.favourite){
                await myOrderWatch.orderListApi(context,isFavouriteOrders: true);
              }
            });

          },
          child: CommonSVG(strIcon: model.isFavourite==true?AppAssets.svgFavourite.localized:AppAssets.svgFavouriteWithoutColor));
  }
}
