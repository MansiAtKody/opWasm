import 'package:kody_operator/ui/services/mobile/request_sent_mobile.dart';
import 'package:kody_operator/ui/services/web/request_sent_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RequestSent extends StatelessWidget with BaseStatelessWidget {
  const RequestSent({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const RequestSentMobile();
      },
      desktop: (BuildContext context) {
        return const RequestSentWeb();
      },
      tablet: (BuildContext context) {
        return const RequestSentWeb();
      },
    );
  }
}
