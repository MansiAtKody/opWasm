import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/web/helper/common_order_list_widget.dart';
import 'package:kody_operator/ui/my_order/web/shimmer/shimmer_my_order_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class OrderListWeb extends ConsumerWidget with BaseConsumerWidget {
  const OrderListWeb({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final myOrderWatch = ref.watch(myOrderController);
        return myOrderWatch.cancelOrderState.isLoading ? DialogProgressBar(isLoading: myOrderWatch.cancelOrderState.isLoading): Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// table header
              myOrderWatch.orderListState.isLoading ? const ShimmerOrderListTableHeaderWidget() : _tableHeaderWidget(),

              SizedBox(
                height: 25.h,
              ),


              myOrderWatch.orderListState.isLoading ? const Expanded(child:  ShimmerMyOrderWeb()) :myOrderWatch.myOrderList?.isNotEmpty ?? false?
              /// table child from selected tab
              Expanded(
                child: CommonOrderListWidget(
                    orderList:myOrderWatch.myOrderList ?? [],
                  ),

                /// Empty widget
              ): EmptyStateWidget(
                title: LocalizationStrings.keyNoOrders.localized,
                subTitle: LocalizationStrings.keyYouHaveNotOrderedAnything.localized,
              ),
              Visibility(
                  visible: myOrderWatch.orderListState.isLoadMore,
                  child:Center(child: const  CircularProgressIndicator(color: AppColors.black,).paddingOnly(top:22.h))),
            ],
          ).paddingOnly(bottom: 23.h),
        );
      },
    );
  }

  Widget _tableHeaderWidget(){
    return  Table(
      textDirection: TextDirection.ltr,
      columnWidths: {
        0: FlexColumnWidth(4.w), /// order id
        1: FlexColumnWidth(3.w), /// department
        2: FlexColumnWidth(4.w), /// order time
        3: FlexColumnWidth(3.w), /// total quantity
        4: FlexColumnWidth(4.w), /// status
        5: FlexColumnWidth(3.w), /// Favourite
        6: FlexColumnWidth(2.w), /// view details

      },
      children: [
        TableRow(children: [
          _widgetTableHeader(text: LocalizationStrings.keyOrderId.localized),
          _widgetTableHeader(text: LocalizationStrings.keyLocationPoint.localized),
          _widgetTableHeader(text: LocalizationStrings.keyOrderTime.localized),
          _widgetTableHeader(text: LocalizationStrings.keyTotalQuantity.localized),
          _widgetTableHeader(text: LocalizationStrings.keyStatus.localized).paddingOnly(right: 10.w),
          _widgetTableHeader(text: ''),
          _widgetTableHeader(text: ''),
        ]),
      ],
    ).paddingOnly(left: 20.w ,right: 10.w,);
  }

  Widget _widgetTableHeader({required String text,TextAlign? textAlign}){
    return Center(
      child: CommonText(
        title: text,
        textAlign: textAlign ?? TextAlign.left,
        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
      ),
    );
  }
}
