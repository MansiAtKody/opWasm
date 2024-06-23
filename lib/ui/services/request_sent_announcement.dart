import 'package:flutter/material.dart';
import 'package:kody_operator/ui/services/mobile/announcement_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/services/mobile/request_sent_announcement_mobile.dart';
import 'package:kody_operator/ui/services/web/request_sent_announcement_web.dart';

class RequestSentAnnouncement extends StatelessWidget with BaseStatelessWidget{
  const RequestSentAnnouncement({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const RequestSentAnnouncementMobile();
        },
        desktop: (BuildContext context) {
          return const RequestSentAnnouncementWeb();
        },
        tablet: (BuildContext context) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.landscape ? const RequestSentAnnouncementWeb() : const AnnouncementMobile();
            },
          );
        }
    );
  }
}

