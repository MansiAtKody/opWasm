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

class CancelOrderButtonWeb extends ConsumerWidget with BaseConsumerWidget {
  final String orderUuid;

  const CancelOrderButtonWeb({Key? key, required this.orderUuid})
      : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    final myOrderWatch = ref.watch(myOrderController);
    return (myOrderWatch.orderDetailsState.success?.data?.status ==
                OrderStatusEnum.PENDING.name )
        ? CommonButton(
            buttonText: LocalizationStrings.keyCancelOrder.localized,
            buttonEnabledColor: AppColors.blue009AF1,
            buttonTextColor: AppColors.white,
            isButtonEnabled: true,
            rightIcon: const Icon(
              Icons.arrow_forward,
              color: AppColors.white,
            ),
            rightIconLeftPadding: 5.w,
            onTap: () {
              /// Cancel order confirmation dialog
              showConfirmationDialogWeb(
                  context: context,
                  title: LocalizationStrings.keyAreYouSure.localized,
                  message: LocalizationStrings.keyCancelOrderMessage.localized,
                  dialogWidth: MediaQuery.sizeOf(context).width * 0.35,
                  didTakeAction: (isPositive) {
                    if (isPositive) {
                      final myOrderWatch = ref.read(myOrderController);
                      myOrderWatch.cancelOrderApi(context, orderUuid).then((value) async {
                        if (myOrderWatch.cancelOrderState.success?.status ==
                            ApiEndPoints.apiStatus_200) {
                          ref.read(navigationStackProvider).pop();
                          await getOrderListApiCall(myOrderWatch, context);
                        }
                      });
                    }
                  });
            },
            isLoading: myOrderWatch.cancelOrderState.isLoading,
          ).paddingOnly(bottom: 20.h)
        : const Offstage();
  }



  /// Order list with pagination
  Future getOrderListApiCall(MyOrderController myOrderWatch, BuildContext context) async {
    myOrderWatch.resetPaginationOrderList();
    myOrderWatch.orderListApi(context);
    myOrderWatch.myOrderListScrollController.addListener(() {
      if (myOrderWatch.myOrderListScrollController.position.pixels >=
          (myOrderWatch.myOrderListScrollController.position.maxScrollExtent -
              300)) {
        if (myOrderWatch.orderListState.success?.hasNextPage ?? false) {
          if (myOrderWatch.debounce?.isActive ?? false) {
            myOrderWatch.debounce?.cancel();
          }

          myOrderWatch.debounce =
              Timer(const Duration(milliseconds: 500), () async {
            myOrderWatch.incrementOrderListPageNumber();
            await myOrderWatch.orderListApi(context);
          });
        }
      }
    });
  }
}
