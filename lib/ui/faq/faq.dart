import 'package:kody_operator/ui/faq/mobile/faq_mobile.dart';
import 'package:kody_operator/ui/faq/web/faq_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class Faq extends StatelessWidget with BaseStatelessWidget {
  const Faq({Key? key}) : super(key: key);


  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const FaqMobile();
        },
        desktop: (BuildContext context) {
          return const FaqWeb();
        }
    );
  }
}

