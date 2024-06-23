import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';

class CancelOrderButtonWidgetMobile extends ConsumerWidget with BaseConsumerWidget{
  final String orderId;
  const CancelOrderButtonWidgetMobile( {Key? key, required this.orderId}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final myOrderWatch = ref.watch(myOrderController);
    return (myOrderWatch.orderDetailsState.success?.data?.status == OrderStatusEnum.PENDING.name)
        ? CommonButton(
      width: context.width,
      buttonText: LocalizationStrings.keyCancelOrder.localized,
      rightIcon: const Icon(
        Icons.arrow_forward,
        color: AppColors.white,
      ),
      isButtonEnabled: true,
      rightIconLeftPadding: 5.w,
      onTap: () => _cancelOrderTap(context,ref),
      isLoading: myOrderWatch.cancelOrderState.isLoading,
    ).paddingSymmetric(horizontal: 20.w, vertical: 10.h)
        : const Offstage();
  }
  /// Cancel order confirmation dialog
  _cancelOrderTap(BuildContext context,ref) {
    showConfirmationDialog(
      context,
      LocalizationStrings.keyNo.localized,
      LocalizationStrings.keyYes.localized,
          (isPositive) {
        if (isPositive) {
          final myOrderWatch = ref.read(myOrderController);
          myOrderWatch.cancelOrderApi(context, orderId ).then((value) async {
            if(myOrderWatch.cancelOrderState.success?.status == ApiEndPoints.apiStatus_200 ){
              ref.read(navigationStackProvider).pop();
              await getOrderListApiCall(myOrderWatch,context);
            }
          });
        }
      },
      title: LocalizationStrings.keyAreYouSure.localized,
      message: LocalizationStrings.keyCancelOrderMessage.localized,
    );
  }
  /// Order list with pagination
  Future getOrderListApiCall(MyOrderController myOrderWatch, BuildContext context) async {
    myOrderWatch.resetPaginationOrderList();
    myOrderWatch.orderListApi(context);
    myOrderWatch.myOrderListScrollController.addListener(() {
        if (myOrderWatch.myOrderListScrollController.position.pixels >=
            (myOrderWatch
                .myOrderListScrollController.position.maxScrollExtent -
                300)) {
          if (myOrderWatch.orderListState.success?.hasNextPage ??
              false) {
            if (myOrderWatch.debounce?.isActive ?? false) myOrderWatch.debounce?.cancel();

            myOrderWatch.debounce = Timer(const Duration(milliseconds: 500), () async{
              myOrderWatch.incrementOrderListPageNumber();
              await myOrderWatch.orderListApi(context);
            });
          }
        }
    });
  }
}
