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

class ReorderButtonWidgetWeb extends ConsumerWidget with BaseConsumerWidget {
  const ReorderButtonWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final myOrderWatch = ref.watch(myOrderController);
    final myTrayWatch = ref.read(myTrayController);
    return    (myOrderWatch.orderDetailsState.success?.data?.status == OrderStatusEnum.DELIVERED.name) ?CommonButton(
              buttonText: LocalizationStrings.keyReorder.localized,
              buttonEnabledColor: AppColors.blue009AF1,
              buttonTextColor: AppColors.white,
              isButtonEnabled: true,
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
          ).paddingOnly(bottom: 20.h): const Offstage();
  }
}
