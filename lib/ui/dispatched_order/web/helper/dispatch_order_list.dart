import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/dispatched_order/dispatched_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/dispatched_order/web/helper/order_detail_widget_web.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class DispatchedOrderListWeb extends ConsumerStatefulWidget {
  const DispatchedOrderListWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<DispatchedOrderListWeb> createState() => _DispatchedOrderListState();
}

class _DispatchedOrderListState extends ConsumerState<DispatchedOrderListWeb> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final orderController = ref.watch(orderStatusController);
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
    return _dispatchedOrders(context);
  }

  ///Upcoming orders
  Widget _dispatchedOrders(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.lightPinkF7F7FC, borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          //final orderStatusWatch = ref.watch(orderStatusController);
          final dispatchedOrderListWatch = ref.watch(dispatchedOrderController);

          return Column(
            children: [
              //const UserCard(),
              Expanded(
                child: dispatchedOrderListWatch.dispatchedOrderList.success!.data!.isEmpty
                    ? const EmptyStateWidget()
                    : GridView.builder(
                  itemCount: dispatchedOrderListWatch.dispatchedOrderList.success?.data?.length,
                  itemBuilder: (context, index) {
                    return FadeBoxTransition(
                      child: OrderDetailWidgetWeb(
                        order: dispatchedOrderListWatch.dispatchedOrderList.success!.data?[index],
                        index: index,
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: context.width * 0.02,
                    mainAxisSpacing: context.height * 0.02,
                    mainAxisExtent: context.height * 0.35,
                  ),
                ),
              )
            ],
          ).paddingOnly(left: 21.w,right: 21.w,top: 20.h,bottom: 75.h);
        },
      ),
    );
  }
}
