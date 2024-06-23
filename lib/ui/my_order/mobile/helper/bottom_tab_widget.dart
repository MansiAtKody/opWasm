import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_filter_model.dart';

import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class BottomTabWidgetMobile extends ConsumerWidget {
  const BottomTabWidgetMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final orderListWatch =   ref.watch(myOrderController);
    return Container(
      height: 45.h,
      width: 0.7.sw,
      decoration: BoxDecoration(color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.r))),
      child: Center(
        child: Row(
          children: [
            ...List.generate(
              (orderListWatch.orderTypeFilterList.length),
                  (index) {
                OrderTypeFilterModel currentFilter = orderListWatch
                    .orderTypeFilterList[index];
                return Expanded(
                  child: InkWell(
                    onTap: () {
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: currentFilter ==
                            orderListWatch.selectedOrderTypeFilter ? AppColors
                            .black : AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(24.r)),
                      ),
                      child: Center(
                        child: CommonText(
                          title: currentFilter.name,
                          textStyle: TextStyles.regular.copyWith(
                            fontSize: 14.sp,
                            color: currentFilter ==
                                orderListWatch.selectedOrderTypeFilter
                                ? AppColors.white
                                : AppColors.greyBEBEBE,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
