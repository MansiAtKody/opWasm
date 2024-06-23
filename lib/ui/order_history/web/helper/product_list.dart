import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/ui/order_history/web/helper/order_list_widget.dart';
class ProductList extends ConsumerStatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductList> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async{
      final orderHistoryWatch = ref.read(orderHistoryController);
      orderHistoryWatch.disposeController(isNotify: true);
      //await orderHistoryWatch.getOrderListApi(context);
      orderHistoryWatch.getOrderListApi(context);
      await getOrderListApiCall(orderHistoryWatch);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40.h,
        ),
        const Expanded(
          child: OrderListWidget()
        ),
      ],
    );
  }

  ///Order List api call
  Future getOrderListApiCall(OrderHistoryController orderHistoryWatchWatch) async {
    orderHistoryWatchWatch.orderListScrollController.addListener(() {
      if (mounted) {
        if (orderHistoryWatchWatch.orderListScrollController.position.pixels >=
            (orderHistoryWatchWatch
                .orderListScrollController.position.maxScrollExtent -
                300)) {
          if (orderHistoryWatchWatch.orderListState.success?.hasNextPage ??
              false) {
            orderHistoryWatchWatch.incrementOrderListPageNumber();
            orderHistoryWatchWatch.getOrderListApi(context);
          }
        }
      }
    });
  }
}



