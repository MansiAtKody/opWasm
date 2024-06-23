import 'package:flutter/material.dart';
import 'package:kody_operator/ui/services/mobile/announcement_get_details_mobile.dart';
import 'package:kody_operator/ui/services/web/announcement_get_details_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AnnouncementGetDetails extends StatelessWidget with BaseStatelessWidget{
  final AnnouncementsTypeEnum appBarTitle;
   AnnouncementGetDetails({Key? key, required this.appBarTitle}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return AnnouncementGetDetailsMobile(appBarTitle: appBarTitle,);
      },
      desktop: (BuildContext context) {
        return const AnnouncementGetDetailsWeb();
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.landscape ? const AnnouncementGetDetailsWeb() :
            AnnouncementGetDetailsMobile(appBarTitle: appBarTitle,);
          },
        );
      },
    );
  }
}

