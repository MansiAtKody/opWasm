import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/dispatch_order_list.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';

class OrderUserDetailsWidget extends StatelessWidget with BaseStatelessWidget {
  const OrderUserDetailsWidget({super.key});

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

        return ListView.builder(
          itemCount: filteredOrders.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int pastOrderIndex) {
            SocketOrders orderStatusModel = filteredOrders[pastOrderIndex];
            return Opacity(
              opacity: orderStatusModel.status == 'IN_TRAY' ? 0.4 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        title: orderStatusWatch.pastSocketOrders[pastOrderIndex].entityName ?? orderStatusWatch.pastSocketOrders[pastOrderIndex].entityType ?? '',
                        textStyle: TextStyles.regular.copyWith(fontSize: 18.sp),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: context.height * 0.038,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14.r), color: AppColors.yellowFFEDBF),
                        child: CommonText(
                          title: orderStatusWatch.pastSocketOrders[pastOrderIndex].uuid ?? '',
                          textStyle: TextStyles.regular.copyWith(fontSize: 12.sp),
                        ).paddingSymmetric(horizontal: 10.w, vertical: 5.h),
                      )
                    ],
                  ),

                  /// Department Name
                  CommonText(
                    title: orderStatusWatch.pastSocketOrders[pastOrderIndex].locationPointsName ?? '',
                    textStyle: TextStyles.regular.copyWith(color: AppColors.grey8D8C8C),
                  ).paddingOnly(bottom: 15.h),

                  /// Dispatched Orders List Widget
                  DispatchOrderList(pastOrderIndex: pastOrderIndex, orderStatusModel: orderStatusModel).paddingOnly(bottom: 25.h),

                  /*CommonButton(
                    buttonText: LocalizationStrings.keyAddIn.localized,
                    width: context.width * 0.07,
                    height: 50.h,
                    buttonEnabledColor: AppColors.blue009AF1,
                    buttonTextColor: AppColors.white,
                    isButtonEnabled: true,
                    onTap: () async {
                      // robotTraySelectionWatch.addOrderInTray(orderStatusWatch, orderStatusWatch.pastSocketOrders[pastOrderIndex].uuid ?? '');
                      await robotTraySelectionWatch.addItemToTrayApi(context, ordersItemUuid: orderStatusModel.uuid ?? '');
                      if(robotTraySelectionWatch.addItemToTrayState.success?.status == ApiEndPoints.apiStatus_200) {
                        robotTraySelectionWatch.animationController?.reverse(
                            from: 0.3);
                        await robotTraySelectionWatch.getTrayListApi(context);
                        Navigator.pop(context);
                      }
                    },
                  ),*/
                ],
              ),
            );
          },
        );
      },
    );
  }

}
