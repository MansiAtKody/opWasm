import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/user_order_card_mobile.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/robot_tray_empty_trays_widget.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class UpcomingOrderListMobile extends ConsumerStatefulWidget {
  const UpcomingOrderListMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<UpcomingOrderListMobile> createState() => _UpcomingOrderListState();
}

class _UpcomingOrderListState extends ConsumerState<UpcomingOrderListMobile> with BaseConsumerStatefulWidget {
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
    return _upComingOrders(context);
  }

  ///Upcoming orders
  Widget _upComingOrders(BuildContext context) {
    return Container(
      height: 0.4.sh,
      decoration: BoxDecoration(color: AppColors.whiteF7F7FC, borderRadius: BorderRadius.only(topRight: Radius.circular(20.r))),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final orderStatusWatch = ref.watch(orderStatusController);

          return Builder(builder: (context) {
            return orderStatusWatch.upcomingSocketOrders.isNotEmpty
                ? ListView.separated(
                    itemCount: orderStatusWatch.upcomingSocketOrders.length,
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return FadeBoxTransition(
                        child: UserCardMobile(
                          index: index,
                          order: orderStatusWatch.upcomingSocketOrders[index],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20.h,
                      );
                    },
                  )
                : const RobotTrayEmptyTraysWidget(
                    emptyStateFor: EmptyStateFor.orderList,
                  );
          });
        },
      ).paddingSymmetric(horizontal: 21.w, vertical: 20.h),
    ).paddingSymmetric(horizontal: 12.w);
  }
}
