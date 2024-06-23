import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/controller/my_order/order_status_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_status_list_tile.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderStatusProgressWidgetWeb extends ConsumerWidget with BaseConsumerWidget{
  const OrderStatusProgressWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final myOrderWatch = ref.watch(myOrderController);
    return (myOrderWatch.orderStatusList.indexWhere((element) => element.status == orderStatusEnumValues.map[myOrderWatch.orderDetailsState.success?.data?.status ?? '']) != -1)
        ? CommonCard(
      child: ListView.builder(
        itemBuilder: (context, index) {
          OrderStatusModel orderStatusModel = myOrderWatch.orderStatusList[index];
          return OrderStatusListTile(orderStatusModel: orderStatusModel);
        },
        itemCount: myOrderWatch.orderStatusList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ).paddingAll(context.height*0.02),
    )
        : const Offstage();
  }
}
