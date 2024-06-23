
import 'package:kody_operator/ui/notification/mobile/notification_screen_mobile.dart';
import 'package:kody_operator/ui/notification/web/notification_screen_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:kody_operator/ui/utils/theme/theme.dart';


class NotificationScreen extends StatelessWidget with BaseStatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const NotificationScreenMobile();
        },
        desktop: (BuildContext context) {
          return const NotificationScreenWeb();
        }
    );
  }
}

