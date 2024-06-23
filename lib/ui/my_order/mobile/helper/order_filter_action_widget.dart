import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_filter_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class OrderFilterActionWidget extends ConsumerWidget with BaseConsumerWidget {
  const OrderFilterActionWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final orderListWatch = ref.watch(myOrderController);
        return PopupMenuButton(
          elevation: 0,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.expand(
            width: context.width,
            height: context.height * 0.7,
          ),
          onOpened: (){
            orderListWatch.updateIsMenuEnable(true);
          },
          onSelected: (value){
            orderListWatch.updateIsMenuEnable(false);
          },
          onCanceled: () async {

            orderListWatch.updateIsMenuEnable(false);
            await orderListWatch.orderListApi(context);
          },
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          offset: Offset(0, -5.h),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(child: OrderFilterWidget()),
            ];
          },
          child: CommonSVG(
            strIcon: AppAssets.svgFilter,
            width: 45.h,
            height: 45.h,
          ),
        ).paddingLTRB(0.0, 7.h, 20.w, 0.0);
      },
    );
  }
}
