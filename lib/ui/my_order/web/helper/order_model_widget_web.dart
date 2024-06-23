
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/ui/my_order/web/helper/item_tile_list_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

///Common Order Widget
class OrderModelWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  const OrderModelWidgetWeb({
    super.key,
    required this.order,
    this.onFavIconTap,
    this.orderStatusWidget,
  });

  final OrderModel order;
  final Widget? orderStatusWidget;

  ///On Favourite Icon Tapped
  final void Function()? onFavIconTap;

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Column(
        children: [
          ///Display all the items of orders
          ListView.separated(
            shrinkWrap: true,
            itemCount: order.itemList!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              OrderItem model = order.itemList![index];

              ///Common Widget to display single item of order
              return ItemTileListWeb(
                index: index,
                orderItem: model,
                isShowFavIcon: index == 0,
                isFav: order.isFav,
                onFavIconTap: onFavIconTap,
                isProduct: order.orderType == OrderType.order,
                orderStatusWidget: orderStatusWidget,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(padding: EdgeInsets.only(bottom: 60.h));
            },
          ),
        ],
      );
    });
  }
}
