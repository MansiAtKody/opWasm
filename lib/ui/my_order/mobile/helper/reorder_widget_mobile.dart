import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_details_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/reorder_button_click.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';

class ReorderWidgetMobile extends ConsumerWidget with BaseConsumerWidget{
  const ReorderWidgetMobile({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final myOrderWatch = ref.watch(myOrderController);
    return (myOrderWatch.orderDetailsState.success?.data?.status == OrderStatusEnum.DELIVERED.name) ? Consumer(
        builder: (context,ref,child) {
          final myTrayWatch = ref.read(myTrayController);
          return CommonButton(
              buttonText: LocalizationStrings.keyReorder.localized,
              buttonEnabledColor: AppColors.blue009AF1,
              buttonTextColor: AppColors.white,
              isButtonEnabled: true,
              width: context.width,
              isLoading:myTrayWatch.cartListState.isLoading,
              rightIcon: const Icon(
                Icons.arrow_forward,
                color: AppColors.white,
              ),
              rightIconLeftPadding: 5.w,
              onTap: () async{
                OrderDetailsResponseModel? orderDetails = myOrderWatch.orderDetailsState.success;
                reorderButtonClick(orderDetails,context,ref);
              }
          ).paddingOnly(bottom: 20.h,top: 20.h);
        }
    )
        : const Offstage();
  }

  // await myTrayWatch.cartListApi(context).then((value){
  // if(myTrayWatch.cartListState.success?.status == ApiEndPoints.apiStatus_200){
  // if(myTrayWatch.cartListState.success?.data?.cartDtoList?.isNotEmpty ??false){
  // _reOrderTapCall(context,myTrayWatch,myOrderWatch,ref);
  // }else{
  // myTrayWatch.addItemListCartApi(context,myOrderWatch.orderDetailsState.success?.data?.ordersItems).then((value) {
  // if(myTrayWatch.addItemListCartState.success?.status == ApiEndPoints.apiStatus_200){
  // ref.read(navigationStackProvider).push(const NavigationStackItem.myTray());
  // }
  //
  // });
  // }
  // }
  // });
  // /// Reorder tap call
  // _reOrderTapCall(BuildContext context,MyTrayController myTrayWatch, MyOrderController myOrderWatch, WidgetRef ref) {
  //   showConfirmationDialog(
  //     context,
  //     LocalizationStrings.keyNo.localized,
  //     LocalizationStrings.keyYes.localized,
  //         (isPositive) async{
  //           if (isPositive) {
  //             await myTrayWatch.clearCartApi(context).then((value) async{
  //               if(myTrayWatch.clearCartState.success?.status == ApiEndPoints.apiStatus_200){
  //                 await  myTrayWatch.addItemListCartApi(context,myOrderWatch.orderDetailsState.success?.data?.ordersItems).then((value) {
  //                   if(myTrayWatch.addItemListCartState.success?.status == ApiEndPoints.apiStatus_200){
  //                     ref.read(navigationStackProvider).push(const NavigationStackItem.myTray());
  //                   }
  //                 });
  //               }
  //             });
  //
  //           }
  //     },
  //     title: LocalizationStrings.keyAlreadyItemsConfirmationMessage.localized,
  //     message: LocalizationStrings.keyAlreadyItemsRemoveConfirmationMessage.localized,
  //   );
  // }
}
