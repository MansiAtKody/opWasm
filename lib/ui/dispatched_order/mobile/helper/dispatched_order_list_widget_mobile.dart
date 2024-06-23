import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/dispatched_order/dispatched_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/dispatched_order/mobile/helper/order_detail_widget_mobile.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/robot_tray_empty_trays_widget.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class DispatchedOrderListWidgetMobile extends ConsumerStatefulWidget {
  const DispatchedOrderListWidgetMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<DispatchedOrderListWidgetMobile> createState() => _DispatchedOrderListState();
}

class _DispatchedOrderListState extends ConsumerState<DispatchedOrderListWidgetMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
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
    return _upComingOrders(context);
  }

  ///Upcoming orders
  Widget _upComingOrders(BuildContext context) {
    return Container(
      height: 0.4.sh,
      decoration: BoxDecoration(color: AppColors.whiteF7F7FC, borderRadius: BorderRadius.only(topRight: Radius.circular(20.r))),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final dispatchedOrderListWatch = ref.watch(dispatchedOrderController);


          return Builder(builder: (context) {
            return dispatchedOrderListWatch.dispatchedOrderList.success!.data!.isEmpty  ? const RobotTrayEmptyTraysWidget(
            emptyStateFor: EmptyStateFor.orderList,
            ) :
                 ListView.separated(
              itemCount: dispatchedOrderListWatch.dispatchedOrderList.success?.data?.length ?? 0,
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return FadeBoxTransition(
                  child: OrderDetailWidgetMobile(
                    index: index,
                    order: dispatchedOrderListWatch.dispatchedOrderList.success!.data?[index],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 20.h,
                );
              },
            )
               ;
          });
        },
      ).paddingSymmetric(horizontal: 10.w, vertical: 20.h),
    ).paddingSymmetric(horizontal: 12.w);
  }
}
