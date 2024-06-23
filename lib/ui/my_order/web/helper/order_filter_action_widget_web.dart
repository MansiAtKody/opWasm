import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_filter_widget_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
class OrderFilterActionWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  const OrderFilterActionWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final orderListWatch = ref.watch(myOrderController);
        return Consumer(
          builder: (context, ref, child) {
            return PopupMenuButton(
              elevation: 0,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.expand(
                width: context.width * 0.25,
                height: context.height * 0.33,
              ),
              onOpened: () {
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
              position: PopupMenuPosition.under,
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: OrderFilterWidgetWeb(),
                  ),
                ];
              },
              child: CommonSVG(
                strIcon: AppAssets.svgFilter,
                width: 45.h,
                height: 45.h,
              ),
            );
          },
        );
      },
    );
  }
}
