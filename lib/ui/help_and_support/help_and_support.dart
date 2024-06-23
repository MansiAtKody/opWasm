import 'package:kody_operator/ui/help_and_support/mobile/help_and_support_mobile.dart';
import 'package:kody_operator/ui/help_and_support/web/help_and_support_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HelpAndSupport extends StatelessWidget with BaseStatelessWidget {
  final String? ticketId;

  const HelpAndSupport({Key? key, this.ticketId}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const HelpAndSupportMobile();
      },
      desktop: (BuildContext context) {
        return HelpAndSupportWeb(ticketId: ticketId);
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.landscape ? HelpAndSupportWeb(ticketId: ticketId) : const HelpAndSupportMobile();
        });
      },
    );
  }
}
