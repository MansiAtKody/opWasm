
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/common_title_value_widget.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class OrderModelWidget extends ConsumerWidget with BaseConsumerWidget{
  final OrderListResponseData? orderModel;
  final int? index;
  const OrderModelWidget({super.key, this.orderModel,this.index});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      final myOrderWatch = ref.watch(myOrderController);
      return Column(
        children: [
          ( orderModel?.status == OrderStatusEnum.REJECTED.name || orderModel?.status == OrderStatusEnum.CANCELED.name || orderModel?.status == OrderStatusEnum.DELIVERED.name)
              ?Align(alignment: Alignment.centerRight,child: favouriteIconWidget(myOrderWatch, context,index ??0)).paddingOnly(bottom: 15.h):const Offstage(),

          ///Display all the items of orders
          _commonTextWidget(title: LocalizationStrings.keyOrderId.localized, value: orderModel?.uuid ?? ''),
          _commonTextWidget(title: LocalizationStrings.keyLocationPoint.localized, value: orderModel?.locationPointsName ?? ''),
          _commonTextWidget(title: LocalizationStrings.keyOrderTime.localized, value: DateTime.fromMillisecondsSinceEpoch(orderModel?.createdAt ?? 0).toString()),
          _commonTextWidget(title: LocalizationStrings.keyTotalQuantity.localized, value: orderModel?.totalQty.toString() ?? ''),
          Divider(
            height: 40.h,
          ),
        ],
      );
    });
  }

  Widget favouriteIconWidget(MyOrderController myOrderWatch, BuildContext context, int index ){
    return (myOrderWatch.favouriteOrderState.isLoading && myOrderWatch.updatingFavouriteOrderIndex == index)?
    LoadingAnimationWidget.waveDots(color: AppColors.black, size: 22.h).alignAtCenterRight().paddingOnly(left: 5.w):
    ///Favourite
    InkWell(
        onTap: ()async{
          await myOrderWatch.favouriteOrderApi(context, orderModel?.uuid??'', !(orderModel?.isFavourite??false)).then((value) async{
            if(orderModel?.isFavourite == false&&myOrderWatch.selectedOrderTypeFilter?.type == OrderType.favourite){
              await myOrderWatch.orderListApi(context,isFavouriteOrders: true);
            }
          });

        },
        child: CommonSVG(strIcon: orderModel?.isFavourite==true?AppAssets.svgFavorite.localized:AppAssets.svgUnfavorite));
  }

  ///Common title tile widget
  _commonTextWidget({required String title, required String value, double? bottomPadding}) {
    return CommonTitleValueWidget(
      title: title,
      value: value,
      bottomPadding: bottomPadding,
      titleFontSize: 12.sp,
      valueFontSize: 12.sp,
    );
  }
}