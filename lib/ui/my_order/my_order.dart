import 'package:kody_operator/ui/my_order/mobile/my_order_mobile.dart';
import 'package:kody_operator/ui/my_order/web/my_order_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyOrder extends StatelessWidget with BaseStatelessWidget {
  final FromScreen? fromScreen;
  final OrderType? orderType;

  const MyOrder({this.fromScreen, Key? key, this.orderType}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return MyOrderMobile(orderType: orderType);
      },
      desktop: (BuildContext context) {
        return MyOrderWeb(fromScreen: fromScreen, orderType: orderType);
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape ? MyOrderWeb(fromScreen: fromScreen, orderType: orderType) : MyOrderMobile(orderType: orderType);
          },
        );
      },
    );
  }
}
