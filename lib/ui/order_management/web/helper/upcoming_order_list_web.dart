import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/controller/order_management/select_coffee_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_management/web/helper/user_order_card_web.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class UpcomingOrderListWeb extends ConsumerStatefulWidget {
  const UpcomingOrderListWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<UpcomingOrderListWeb> createState() => _UpcomingOrderListState();
}

class _UpcomingOrderListState extends ConsumerState<UpcomingOrderListWeb> with BaseConsumerStatefulWidget {
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
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final orderStatusWatch = ref.watch(orderStatusController);

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CommonText(
                          title: LocalizationStrings.keyUpcomingOrders.localized,
                          textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.grey636363),
                        ),
                        SizedBox(width: 15.w),
                        InkWell(
                          onTap: () {
                            if (ref.watch(selectCoffeeController).startProgramState.isLoading == false) {
                              ref.watch(selectCoffeeController).startProgramAPI(context);
                            }
                          },
                          child: CommonSVG(
                            strIcon: AppAssets.svgRoboticArm,
                            height: 40.h,
                            width: 40.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CommonText(
                    title: '${orderStatusWatch.upcomingSocketOrders.length} ${LocalizationStrings.keyOrders.localized}',
                    textStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.greyC1C1C1, decoration: TextDecoration.underline),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              //const UserCard(),
              Expanded(
                child: orderStatusWatch.upcomingSocketOrders.isEmpty
                    ? const EmptyStateWidget()
                    : GridView.builder(
                        itemCount: orderStatusWatch.upcomingSocketOrders.length,
                        itemBuilder: (context, index) {
                          return FadeBoxTransition(
                            child: UserCardWeb(
                              order: orderStatusWatch.upcomingSocketOrders[index],
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
