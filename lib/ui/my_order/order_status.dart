import 'package:kody_operator/ui/my_order/mobile/order_status_mobile.dart';
import 'package:kody_operator/ui/my_order/web/order_status_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrderFlowStatus extends StatelessWidget with BaseStatelessWidget {
  final String? orderId;

  const OrderFlowStatus({Key? key, required this.orderId}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return OrderStatusMobile(orderId: orderId);
    }, desktop: (BuildContext context) {
      return OrderStatusWeb(orderUuid: orderId,);
    }, tablet: (BuildContext context) {
      return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.landscape ? OrderStatusWeb(orderUuid: orderId,) : OrderStatusMobile(orderId: orderId);
        },
      );
    });
  }
}
