

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_filter_model.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/tab_tile_list.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class OrderTypeTabWidget extends StatelessWidget with BaseStatelessWidget {
  const OrderTypeTabWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final orderListWatch = ref.watch(myOrderController);

      return SizedBox(
        height: 40.h,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: orderListWatch.orderTypeFilterList.length,
          itemBuilder: (context, index) {
            OrderTypeFilterModel currentFilter = orderListWatch.orderTypeFilterList[index];
            return TabTileList(
              index: index,
              title: currentFilter.name,
              onTabTap: () {
                orderListWatch.updateSelectedOrderTypeFilter(ref:ref,
                    selectedOrderTypeFilter: currentFilter);
                if (orderListWatch.selectedOrderTypeFilter?.type ==
                    OrderType.favourite) {
                  orderListWatch.resetPaginationOrderList();
                  orderListWatch.orderListApi(
                      context, isFavouriteOrders: true);

                } else {
                  orderListWatch.resetPaginationOrderList();
                  orderListWatch.orderListApi(context);
                }
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 20.w,
            );
          },
        ),
      );
    });
  }
}
