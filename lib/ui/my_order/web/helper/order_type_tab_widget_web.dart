
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_filter_model.dart';
import 'package:kody_operator/ui/my_order/web/helper/tab_list_tile_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class OrderTypeTabWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  final double? tabHeight;

  const OrderTypeTabWidgetWeb({super.key, this.tabHeight});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final orderListWatch = ref.watch(myOrderController);

      return SizedBox(
        height: tabHeight ?? 40.h,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: orderListWatch.orderFilterList.length,
          itemBuilder: (context, index) {
            OrderTypeFilterModel orderFilter = orderListWatch.orderFilterList[index];
            return TabTileListWeb(
              index: index,
              title: orderFilter.name,
              titleFontSize: 16.sp,
              onTabTap: () {
                orderListWatch.updateSelectedOrderFilter(selectedOrderFilter: orderFilter);
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
