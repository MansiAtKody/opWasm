import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_type_tab_widget.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_filter_action_widget_web.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_list_web.dart';
import 'package:kody_operator/ui/my_order/web/helper/past_order_date_popUp_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class MyOrderWeb extends ConsumerStatefulWidget {
  final OrderType? orderType;
  final FromScreen? fromScreen;

  const MyOrderWeb({this.fromScreen, Key? key, this.orderType})
      : super(key: key);

  @override
  ConsumerState<MyOrderWeb> createState() => _OrderListWebState();
}

class _OrderListWebState extends ConsumerState<MyOrderWeb>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final orderListWatch = ref.read(myOrderController);
      orderListWatch.disposeController(isNotify: true);
      if (widget.orderType != null) {
        orderListWatch.updateSelectedOrderTypeFilter(
            ref: ref,
            selectedOrderTypeFilter: orderListWatch.orderTypeFilterList
                .where((element) => element.type == widget.orderType)
                .firstOrNull);
      }
      getOrderListApiCall(orderListWatch);
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final myOrderWatch = ref.watch(myOrderController);
    final orderListWatch = ref.watch(myOrderController);
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),

          ///Order Types Tab Bar
          CommonText(
            title: LocalizationStrings.keyMyOrder.localized,
            textStyle: TextStyles.medium.copyWith(fontSize: 20.sp),
          ).paddingSymmetric(horizontal: context.width * 0.03),
          Row(
            children: [
              const Align(
                  alignment: Alignment.centerLeft, child: OrderTypeTabWidget()),
              const Spacer(),
              const PastOrderDatePopUp().paddingOnly(right: 20.w),
              myOrderWatch.orderListState.isLoading || orderListWatch.selectedOrderTypeFilter?.name == orderListWatch.orderTypeFilterList[1].name
                  ? const Offstage()
                  : const OrderFilterActionWidgetWeb(),
            ],
          ).paddingOnly(left: 30.w, top: 20.h, right: 50.w),
          const Divider(height: 1)
              .paddingSymmetric(vertical: 30.h, horizontal: 20.w),
          Expanded(
            child: const OrderListWeb()
                .paddingSymmetric(horizontal: context.width * 0.03),
          ),
        ],
      ),
    );
  }

  /// Order list with pagination
  Future getOrderListApiCall(MyOrderController myOrderWatch) async {
    await myOrderWatch.orderListApi(context);
    myOrderWatch.myOrderListScrollController.addListener(() {
      if (mounted) {
        if ((myOrderWatch.myOrderListScrollController.position.pixels >=
            myOrderWatch.myOrderListScrollController.position.maxScrollExtent -
                100)) {
          if ((myOrderWatch.orderListState.success?.hasNextPage ?? false) &&
              !(myOrderWatch.orderListState.isLoadMore)) {
            myOrderWatch.incrementOrderListPageNumber();
            myOrderWatch.orderListApi(context,
                isFavouriteOrders: myOrderWatch.selectedOrderTypeFilter?.type ==
                        OrderType.favourite
                    ? true
                    : null);
          }
        }
      }
    });
  }
}
