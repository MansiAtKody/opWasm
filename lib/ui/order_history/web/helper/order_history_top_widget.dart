import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderHistoryCenterWidget extends StatelessWidget with BaseStatelessWidget {
  const OrderHistoryCenterWidget({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderHistoryWatch = ref.watch(orderHistoryController);
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
          child: Column(
            children: [
              Row(
                children: List.generate(
                  orderHistoryWatch.orderTypeList.length,
                      (index) {
                    OrderHistoryModel selectedOrderType = orderHistoryWatch.orderTypeList[index];
                    return InkWell(
                      onTap: () {
                        orderHistoryWatch.updateSelectedOrderType(ref, selectedOrderType: selectedOrderType);
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.r)), color: orderHistoryWatch.selectedOrderType == selectedOrderType ? AppColors.blue009AF1 : AppColors.lightPink),
                        height: 40.h,
                        width: 110.w,
                        child: Center(
                          child: CommonText(
                            title: selectedOrderType.name,
                            textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: orderHistoryWatch.selectedOrderType == selectedOrderType ? AppColors.white : AppColors.grey626262),
                          ),
                        ),
                      ),
                    ).paddingOnly(right: 20.w);
                  },
                ),
              ),
              Expanded(
                child: orderHistoryWatch.selectedOrderType?.screen ?? const Offstage(),
              ),
            ],
          ).paddingSymmetric(vertical: 25.h, horizontal: 40.w),
        ).paddingOnly(top: 18.h, bottom: 40.h);
      },
    );
  }
}
