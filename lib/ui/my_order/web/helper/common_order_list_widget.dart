
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_list_response_model.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_list_tile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CommonOrderListWidget extends ConsumerWidget  with BaseConsumerWidget{
  final List<OrderListResponseData> orderList;

  const CommonOrderListWidget({super.key, required this.orderList});

  @override
  Widget buildPage(BuildContext context,ref) {
    final myOrderWatch =   ref.watch(myOrderController);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: orderList.length,
      controller: myOrderWatch.myOrderListScrollController,
      itemBuilder: (context, index) {
        OrderListResponseData model = orderList[index];
        return OrderListTile(
            model: model,
            index: index,
            onItemTap: () {},
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 22.h,
        );
      },
    );
  }
}
