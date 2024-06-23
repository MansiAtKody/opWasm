import 'package:kody_operator/ui/location/mobile/select_location_dialog_mobile.dart';
import 'package:kody_operator/ui/location/web/select_location_dialog_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SelectLocationDialog extends StatelessWidget with BaseStatelessWidget {
  const SelectLocationDialog({Key? key, this.buttonText, this.onButtonPressed}) : super(key: key);
  final String? buttonText;
  final void Function()? onButtonPressed;
  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return SelectLocationDialogMobile(buttonText: buttonText,onButtonPressed: onButtonPressed,);
      },
      desktop: (BuildContext context) {
        return const SelectLocationDialogWeb();
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.landscape
                ? const SelectLocationDialogWeb()
                : SelectLocationDialogMobile(buttonText: buttonText,onButtonPressed: onButtonPressed,);
          },
        );
      },
    );
  }
}
