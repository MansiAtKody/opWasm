import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_check_box.dart';


class DispatchOrderListMobile extends StatelessWidget with BaseStatelessWidget {
  final int pastOrderIndex;
  final SocketOrders? orderStatusModel;

  const DispatchOrderListMobile({super.key, required this.pastOrderIndex, this.orderStatusModel});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        final orderStatusWatch = ref.watch(orderStatusController);
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orderStatusWatch.pastSocketOrders[pastOrderIndex].ordersItems?.length ?? 0,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, orderIndex) {
            OrdersItem? orderDetailModel = orderStatusWatch.pastSocketOrders[pastOrderIndex].ordersItems?[orderIndex];
            return Container(
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: InkWell(
                onTap: () {
                  if(orderDetailModel?.uuid != null) {
                    robotTraySelectionWatch.updateOrderItemUuidList(
                        orderDetailModel?.uuid ?? '');
                  }
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: CacheImage(
                        imageURL: orderDetailModel?.productImage ?? staticImageURL,
                        contentMode: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            title: orderDetailModel?.productName ?? '',
                            textStyle: TextStyles.regular.copyWith(
                              fontSize: 10.sp,
                              color: AppColors.black,
                            ),
                          ),
                          CommonText(
                            title: orderDetailModel?.ordersItemAttributes?.map((e) => e.attributeNameValue).toList().join(',') ?? '',
                            maxLines: 2,
                            textStyle: TextStyles.regular.copyWith(
                              fontSize: 10.sp,
                              color: AppColors.grey8D8C8C,
                            ),
                          )
                        ],
                      ).paddingOnly(left: 10.w),
                    ),
                    // const Spacer(),

                    /// Common CheckBox
                    CommonCheckBox(
                      value: robotTraySelectionWatch.orderItemUuidList.contains(orderDetailModel?.uuid),
                      onChanged: (value) {
                        if(orderDetailModel?.uuid != null) {
                          robotTraySelectionWatch.updateOrderItemUuidList(
                              orderDetailModel?.uuid ?? '');
                        }                    },
                      side: MaterialStateBorderSide.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.selected)) {
                            return BorderSide(color: AppColors.black, width: 1.w);
                          } else {
                            return BorderSide(color: AppColors.black, width: 1.w);
                          }
                        },
                      ),
                    )
                  ],
                ).paddingSymmetric(horizontal: 10.w, vertical: 12.h),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10.h);
          },
        );
      },
    );
  }
}
