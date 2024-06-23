import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/controller/my_order/order_details_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/common_title_value_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/item_tile_list.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';

class OrderDetailsMobile extends ConsumerStatefulWidget {
  final String? orderId;

  const OrderDetailsMobile({Key? key, this.orderId}) : super(key: key);

  @override
  ConsumerState<OrderDetailsMobile> createState() => _OrderDetailsMobileState();
}

class _OrderDetailsMobileState extends ConsumerState<OrderDetailsMobile> with BaseConsumerStatefulWidget {
  String? orderStatus;
  Color? orderStatusColor;

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final orderDetailsWatch = ref.read(orderDetailsController);
      orderDetailsWatch.updateOrderModelFromId(ref, widget.orderId);
      //orderDetailsWatch.disposeController(isNotify : true);
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
    return Scaffold(
      backgroundColor: AppColors.scaffoldBG,
      appBar: CommonAppBar(
        isLeadingEnable: true,
        title: LocalizationStrings.keyOrderDetails.localized,
        // topTitlePadding: 30.h,
      ),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final orderDetailsWatch = ref.watch(orderDetailsController);
    return SingleChildScrollView(
      child: CommonCard(
              child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: orderDetailsWatch.orderModel?.itemList?.length ?? 0,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              OrderItem? orderItem = orderDetailsWatch.orderModel?.itemList?[index];
              return ItemTileList(
                index: index,
                isShowFavIcon: false,
                orderItem: orderItem,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 40.h,
              );
            },
          ),
          Divider(
            height: 40.h,
          ),
          _widgetOrderDetails()
        ],
      ).paddingAll(20.h))
          .paddingAll(20.h),
    ).paddingOnly(top: 10.h);
  }

  Widget _widgetOrderDetails() {
    final orderDetailsWatch = ref.watch(orderDetailsController);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonTitleValueWidget(title: LocalizationStrings.keyOrderNo.localized, value: '#123456'),
        CommonTitleValueWidget(
          title: LocalizationStrings.keyOrderStatus.localized,
          value: (orderDetailsWatch.orderModel?.status?.name ?? '').capsFirstLetterOfSentence,
          valueColor: ref.read(myOrderController).getOrderStatusTextColor(orderDetailsWatch.orderModel?.status.toString()).buttonTextColor,
        ),
        CommonTitleValueWidget(title: LocalizationStrings.keyDepartment.localized, value: 'UI/UX Designer'),
        CommonTitleValueWidget(title: LocalizationStrings.keyDateTime.localized, value: '06 Aug 2023 at 1:45PM'),
        CommonTitleValueWidget(
          title: LocalizationStrings.keyQty.localized,
          value: '01',
          bottomPadding: 0.h,
        ),
      ],
    );
  }

  _bottomWidget() {
    return CommonButton(
      buttonText: LocalizationStrings.keyQuickOrder.localized,
      rightIcon: const Icon(Icons.arrow_forward, color: AppColors.white),
      onTap: () {
        ref.read(navigationStackProvider).push(const NavigationStackItem.selectLocationDialog());
      },
    );
  }
}
