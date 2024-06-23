import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/common_order_filter_tile.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_bubble_widgets.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/framework/repository/order/model/order_filter_model.dart';

class OrderFilterWidget extends ConsumerWidget with BaseConsumerWidget {
  const OrderFilterWidget({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final orderListWatch = ref.watch(myOrderController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CommonSVG(
          strIcon: AppAssets.svgFilter,
          width: 55.h,
          height: 55.h,
        ),
        SizedBox(height: 10.h),
        FadeBoxTransition(
          child: CommonBubbleWidget(
            positionFromTop: 0.015.sh,
            width: context.width * 0.85,
            borderRadius: 20.r,
            height: context.height * 0.5,
            positionFromRight: 20.w,
            isBubbleFromLeft: false,
            bubbleColor: AppColors.whiteF7F7FC,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///By Statues
                CommonText(
                  title: LocalizationStrings.keyByStatus.localized,
                  textStyle: TextStyles.medium.copyWith(fontSize: 18.sp),
                ),
                SizedBox(height: context.height * 0.015),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: orderListWatch.orderStatusFilterList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      OrderStatusFilterModel orderStatusModel = orderListWatch.orderStatusFilterList[index];
                      return CommonOrderFilterTile(
                        value: orderListWatch.getIfFilterIsInList(orderStatusModel),
                        onChanged: (onChanged) {
                          orderListWatch.updateSelectedOrderStatusFilterList(context, filter:orderStatusModel);
                        },
                        title: orderStatusModel.name,
                      );
                    }),
                Divider(color: AppColors.textFieldBorderColor),
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
                    ),
                  ),
                )
              ],
            ).paddingOnly(left: 25.w, top: 20.h),
          ),
        ),
      ],
    );
  }
}
/// Order list with pagination
Future getOrderListApiCall(MyOrderController myOrderWatch,BuildContext context) async {
  myOrderWatch.resetPaginationOrderList();
  myOrderWatch.orderListApi(context);
  myOrderWatch.myOrderListScrollController.addListener(() {
      if (myOrderWatch.myOrderListScrollController.position.pixels >=
          (myOrderWatch
              .myOrderListScrollController.position.maxScrollExtent -
              300)) {
        if (myOrderWatch.orderListState.success?.hasNextPage ??
            false) {
          myOrderWatch.incrementOrderListPageNumber();
          myOrderWatch.orderListApi(context);
        }
      }
  });
}


/*///Here also keep code to filter list.
        orderListWatch.updateIsPopUpMenuOpen(isPopUpMenuOpen: false);
        Navigator.pop(context);
        if(orderListWatch.orderTypeSelectedIndex == 0){
          orderListWatch.updateOrderFilter();
        }
        else {
          orderListWatch.updatePastOrderFilter();
        }*/
