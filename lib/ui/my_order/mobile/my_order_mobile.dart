import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_filter_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/bottom_tab_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_filter_action_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_list_mobile.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/select_custom_date_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/shimmer/shimmer_my_order_mobile.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';

class MyOrderMobile extends ConsumerStatefulWidget {
  final OrderType? orderType;

  const MyOrderMobile({Key? key, this.orderType}) : super(key: key);

  @override
  ConsumerState<MyOrderMobile> createState() => _MyOrderMobileState();
}

class _MyOrderMobileState extends ConsumerState<MyOrderMobile> with BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final myOrderWatch = ref.read(myOrderController);
      myOrderWatch.disposeController(isNotify: true);
      if (widget.orderType != null) {
        myOrderWatch.updateSelectedOrderTypeFilter(ref: ref, selectedOrderTypeFilter: myOrderWatch.orderTypeFilterList.where((element) => element.type == widget.orderType).firstOrNull);
      }
      getOrderListApiCall(myOrderWatch);
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final orderListWatch = ref.watch(myOrderController);
    return CommonWhiteBackground(
      appBar:  CommonAppBar(
        backgroundColor: AppColors.black,
        title:  LocalizationStrings.keyMyOrder.localized,
        isDrawerEnable: true,
        actions: [
          orderListWatch.orderListState.isLoading ? const Offstage() : const OrderFilterActionWidget()
        ],
      ), child: Stack(
      alignment: Alignment.center,
        children: [
          Column(
          children: [
            SizedBox(height: 20.h),

            ///Date picker to filter orders in certain date range
            const SelectCustomDateWidget(),

            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  OrderTypeFilterModel currentFilter = orderListWatch
                      .orderTypeFilterList[index];
                  orderListWatch.animatePage(index);
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
                controller: orderListWatch.orderTypePageController,
                children: [
                  orderListWatch.orderListState.isLoading ? const ShimmerMyOrderMobile() : const OrdersListMobile(),
                  orderListWatch.orderListState.isLoading ? const ShimmerMyOrderMobile() : const OrdersListMobile(),

                ],
              ),
            ),
          ],
          ).paddingOnly(bottom:20.h),

          /// Bottom tab widget
          Positioned(
              bottom: context.height*0.06,
              child:const BottomTabWidgetMobile())
        ],
      ),
    );

  }
  /// Order list with pagination
  Future getOrderListApiCall(MyOrderController myOrderWatch) async {
    myOrderWatch.resetPaginationOrderList();
    myOrderWatch.orderListApi(context);
    myOrderWatch.myOrderListScrollController.addListener(() {
      if (mounted) {
        if (myOrderWatch.myOrderListScrollController.position.pixels >=
            (myOrderWatch
                .myOrderListScrollController.position.maxScrollExtent -
                300)) {
          if (myOrderWatch.orderListState.success?.hasNextPage ??
              false) {
            if (myOrderWatch.debounce?.isActive ?? false) myOrderWatch.debounce?.cancel();

            myOrderWatch.debounce = Timer(const Duration(milliseconds: 500), () async{
            myOrderWatch.incrementOrderListPageNumber();
           await myOrderWatch.orderListApi(context);
            });
          }
        }
      }
    });
  }
}
