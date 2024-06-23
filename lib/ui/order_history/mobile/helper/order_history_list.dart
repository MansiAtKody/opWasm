import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/order_history/mobile/helper/order_hostory_detail_widget.dart';
import 'package:kody_operator/ui/order_history/mobile/helper/shimmer_order_history_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class OrderHistoryList extends ConsumerStatefulWidget {

  const OrderHistoryList({Key? key,}) : super(key: key);

  @override
  ConsumerState<OrderHistoryList> createState() => _OrderHistoryListState();
}

class _OrderHistoryListState extends ConsumerState<OrderHistoryList> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async{
      final orderHistoryWatch = ref.watch(orderHistoryController);
      await orderHistoryWatch.getOrderListApi(context);
      await getOrderListApiCall(orderHistoryWatch);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(20.r))),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final orderHistoryWatch = ref.watch(orderHistoryController);
          return  !(orderHistoryWatch.orderListState.isLoading)
              ? (orderHistoryWatch.orderList?.isEmpty ?? true)
              ?const EmptyStateWidget()

              /// List Widget
              :Column(
              children:[
                Expanded(
                  child: ListView.separated(
            controller:orderHistoryWatch.orderListScrollController ,
            shrinkWrap: true,
            itemCount: orderHistoryWatch.orderList?.length??0,
            scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      OrderData? orderData = orderHistoryWatch.orderList?[index];
                      return OrderHistoryDetailWidget(
                        orderDetail: orderData,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20.h,
                      );
                    },
                  ),
                ),
                Visibility(
                    visible: orderHistoryWatch.orderListState.isLoadMore,
                    child:const  CircularProgressIndicator(color: AppColors.black,).paddingOnly(top:22.h)),
              ])
                ///Shimmer Widget
              : const ShimmerOrderHistoryMobile();
        },
      ),
    ).paddingSymmetric(horizontal: 12.w);
  }

  /// Api call
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
