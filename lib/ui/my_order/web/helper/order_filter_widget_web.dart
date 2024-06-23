

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_filter_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/common_order_filter_tile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_bubble_widgets.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderFilterWidgetWeb extends ConsumerWidget with BaseConsumerWidget {
  const OrderFilterWidgetWeb({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final orderListWatch = ref.watch(myOrderController);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: CommonBubbleWidget(
        positionFromTop: 0.015.sh,
        width: context.width * 0.25,
        height: context.height * 0.29,
        borderRadius: 20.r,
        positionFromRight: 0.02.sw,
        isBubbleFromLeft: false,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                title: LocalizationStrings.keyByStatus.localized,
                textStyle: TextStyles.medium.copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: context.height * 0.015),
              SizedBox(
                width: 0.2.sw,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: orderListWatch.orderStatusFilterList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: (context.height * 0.04),
                    mainAxisSpacing: 5.h,
                    crossAxisSpacing: 20.w,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    OrderStatusFilterModel orderStatusModel = orderListWatch.orderStatusFilterList[index];
                    return CommonOrderFilterTile(
                      value: orderListWatch.getIfFilterIsInList(orderStatusModel),
                      onChanged: (onChanged) {
                        orderListWatch.updateSelectedOrderStatusFilterList(context,filter:orderStatusModel);
                       // getOrderListApiCall(orderListWatch, context);
                      },
                      title: orderStatusModel.name,
                    );
                  },
                ),
              ),
              const Divider(color: AppColors.textFieldLabelColor).paddingOnly(right: 20.w),
              Center(
                child: InkWell(
                  onTap: (){
                    orderListWatch.updateSelectedOrderStatusFilterList(context,isClearAll:true);
                  },
                  child: CommonText(
                    title: LocalizationStrings.keyClearAll.localized,
                    textStyle: TextStyles.medium.copyWith(
                        color: AppColors.redE16000,
                        fontSize: 18.sp
                    ),
                  ).paddingOnly(top: 5.h),
                ),
              )
            ],
          ).paddingOnly(left: 25.w, top: 20.h),
        ),
      ),
    );
  }
  /// Order list with pagination
  Future getOrderListApiCall(MyOrderController myOrderWatch,BuildContext context) async {
    myOrderWatch.resetPaginationOrderList();
   await myOrderWatch.orderListApi(context);
    myOrderWatch.myOrderListScrollController.addListener(() async{
      if (myOrderWatch.myOrderListScrollController.position.pixels >=
          (myOrderWatch
              .myOrderListScrollController.position.maxScrollExtent -
              300)) {
        if (myOrderWatch.orderListState.success?.hasNextPage ??
            false) {
          myOrderWatch.incrementOrderListPageNumber();
          await myOrderWatch.orderListApi(context);
        }
      }
    });
  }
}
