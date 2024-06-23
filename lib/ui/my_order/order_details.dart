import 'package:kody_operator/ui/my_order/mobile/order_details_mobile.dart';
import 'package:kody_operator/ui/my_order/web/order_details_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrderDetails extends StatelessWidget with BaseStatelessWidget {
  final String? orderId;

  const OrderDetails({Key? key, required this.orderId}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return OrderDetailsMobile(orderId: orderId);
    }, desktop: (BuildContext context) {
      return const OrderDetailsWeb();
    }, tablet: (BuildContext context) {
      return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.landscape ? const OrderDetailsWeb() : const OrderDetailsMobile();
        },
      );
    });
  }
}
