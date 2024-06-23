import 'package:kody_operator/ui/my_tray/mobile/order_customization_mobile.dart';
import 'package:kody_operator/ui/my_tray/web/order_customization_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrderCustomization extends StatelessWidget with BaseStatelessWidget {
  final FromScreen fromScreen;
  final String productUuid;
  final String? uuid;


  const OrderCustomization({Key? key, required this.fromScreen,required this.productUuid,this.uuid}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return OrderCustomizationMobile(fromScreen: fromScreen,productUuid: productUuid,uuid: uuid,);
      },
      desktop: (BuildContext context) {
        return OrderCustomizationWeb(
          fromScreen: fromScreen, productUuid: productUuid,
          uuid: uuid,
        );
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.landscape
                ? OrderCustomizationWeb(
                    fromScreen: fromScreen, productUuid: productUuid,
                  )
                : OrderCustomizationMobile(fromScreen: fromScreen,productUuid: productUuid);
          },
        );
      },
    );
  }
}
