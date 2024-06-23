import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/helper/dipatch_order_list_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';

class OrderUserDetailsWidgetMobile extends StatelessWidget with BaseStatelessWidget {
  const OrderUserDetailsWidgetMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderStatusWatch = ref.watch(orderStatusController);
        final trayList = ref.watch(robotTraySelectionController).trayDataList?.expand((tray) => tray?.data ?? []).toList() ?? [];
        final trayItemUuids = trayList.map((trayItem) => trayItem.uuid).toSet();

        final filteredOrders = orderStatusWatch.pastSocketOrders.where((order) {
          final orderItemsUuids = order.ordersItems?.map((item) => item.uuid).toSet() ?? {};
          return !orderItemsUuids.any(trayItemUuids.contains);
        }).toList();
        return ListView.separated(
          itemCount: filteredOrders.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int pastOrderIndex) {
            SocketOrders orderStatusModel = filteredOrders[pastOrderIndex];
            return Opacity(
              opacity: orderStatusModel.status == 'IN_TRAY' ? 0.4 : 1,
              child: CommonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Top Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CommonText(
                            title: orderStatusWatch.pastSocketOrders[pastOrderIndex].entityName ?? orderStatusWatch.pastSocketOrders[pastOrderIndex].entityType ?? '',
                            textStyle: TextStyles.regular.copyWith(fontSize: 18.sp),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: context.height * 0.038,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14.r), color: AppColors.yellowFFEDBF),
                            child: CommonText(
                              title: orderStatusWatch.pastSocketOrders[pastOrderIndex].uuid ?? '',
                              textStyle: TextStyles.regular.copyWith(fontSize: 12.sp),
                            ),
                          ),
                        )
                      ],
                    ),

                    /// Department Name
                    CommonText(
                      title: orderStatusWatch.pastSocketOrders[pastOrderIndex].locationPointsName ?? '',
                      textStyle: TextStyles.regular.copyWith(color: AppColors.grey8D8C8C),
                    ).paddingOnly(bottom: 25.h),

                    /// Dispatched Orders List Widget
                    DispatchOrderListMobile(pastOrderIndex: pastOrderIndex, orderStatusModel: orderStatusModel),

                    // CommonButton(
                    //   buttonText: LocalizationStrings.keyAddIn.localized,
                    //   height: 60.h,
                    //   buttonTextSize: 16.sp,
                    //   buttonEnabledColor: AppColors.blue009AF1,
                    //   buttonTextColor: orderStatusWatch.pastSocketOrders.isNotEmpty ? AppColors.white : AppColors.grey8F8F8F,
                    //   isButtonEnabled: orderStatusWatch.pastSocketOrders.isNotEmpty,
                    //   onTap: () {
                    //     robotTraySelectionWatch.addOrderInTray(orderStatusWatch, orderStatusWatch.pastSocketOrders[pastOrderIndex].uuid ?? '');
                    //     Navigator.pop(context);
                    //   },
                    // ),
                  ],
                ).paddingAll(15.h),
              ).paddingOnly(bottom: 20.h),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 15.h);
          },
        );
      },
    );
  }
}
