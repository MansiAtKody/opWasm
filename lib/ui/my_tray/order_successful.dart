import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/my_tray/mobile/order_successful_mobile.dart';
import 'package:kody_operator/ui/my_tray/web/order_successful_web.dart';

class OrderSuccessful extends StatelessWidget with BaseStatelessWidget {
  final FromScreen fromScreen;
  const OrderSuccessful({Key? key,required this.fromScreen}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return OrderSuccessfulMobile(fromScreen: fromScreen);
        },
        desktop: (BuildContext context) {
          return  OrderSuccessfulWeb( fromScreen: fromScreen);
        },
        tablet: (BuildContext context) {
         return OrientationBuilder(builder:(context,orientation){
           return orientation == Orientation.landscape? OrderSuccessfulWeb( fromScreen: fromScreen): OrderSuccessfulMobile(fromScreen: fromScreen);
         } );
         },
    );
  }
}

