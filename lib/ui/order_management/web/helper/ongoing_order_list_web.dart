import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_management/web/helper/upcoming_order_web.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class OngoingOrderList extends ConsumerStatefulWidget {
  const OngoingOrderList({Key? key}) : super(key: key);

  @override
  ConsumerState<OngoingOrderList> createState() => _OngoingOrderListState();
}

class _OngoingOrderListState extends ConsumerState<OngoingOrderList> with BaseConsumerStatefulWidget {
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
    return _ongoingOrders(context);
  }

  ///Ongoing orders
  Widget _ongoingOrders(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final orderStatusWatch = ref.watch(orderStatusController);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    title: LocalizationStrings.keyAcceptedOrder.localized,
                    textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.grey636363),
                  ),
                  CommonText(
                    title: '${orderStatusWatch.ongoingSocketOrders.length} ${LocalizationStrings.keyOrders.localized}',
                    textStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.greyC1C1C1, decoration: TextDecoration.underline),
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              //const UserCard(),
              Expanded(
                child: orderStatusWatch.ongoingSocketOrders.isEmpty
                    ? const EmptyStateWidget()
                    : GridView.builder(
                        shrinkWrap: true,
                        itemCount: orderStatusWatch.ongoingSocketOrders.length,
                        primary: true,
                        itemBuilder: (context, index) {
                          ///Common Chat Widget
                          return FadeBoxTransition(
                            child: OngoingOrderCardWeb(
                              index: index,
                              order: orderStatusWatch.ongoingSocketOrders[index],
                            ).paddingOnly(bottom: 20.h),
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
