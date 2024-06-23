import 'package:flutter/material.dart';
import 'package:kody_operator/ui/services/mobile/announcement_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/services/web/announcement_web.dart';

class Announcement extends StatelessWidget with BaseStatelessWidget {
  const Announcement({Key? key}) : super(key: key);

  ///Build Override

  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const AnnouncementMobile();
        },
        desktop: (BuildContext context) {
          return const AnnouncementWeb();
        },
        tablet: (BuildContext context) {
      return OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.landscape ? const AnnouncementWeb() : const AnnouncementMobile();
        },
      );
    },
    );
  }
}

