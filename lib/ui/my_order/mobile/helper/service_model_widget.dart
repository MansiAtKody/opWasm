import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/item_tile_list.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';


///Common Order Widget
class ServiceModelWidget extends StatelessWidget with BaseStatelessWidget {
  const ServiceModelWidget({
    super.key,
    required this.order,
    this.onFavIconTap,
  });

  final OrderModel order;

  ///On Favourite Icon Tapped
  final void Function()? onFavIconTap;

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final orderListWatch = ref.watch(myOrderController);

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
              return ItemTileList(
                index: index,
                orderItem: model,
                isShowFavIcon: orderListWatch.selectedOrderTypeFilter?.type == OrderType.order && index == 0,
                isFav: order.isFav,
                isProduct: order.orderType == OrderType.order,
                onFavIconTap: onFavIconTap,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 40.h);
            },
          ),
          Divider(
            height: 40.h,
          ),
        ],
      );
    });
  }
}
