import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/profile/mobile/profile_mobile.dart';
import 'package:kody_operator/ui/profile/web/profile_web.dart';

class Profile extends StatelessWidget with BaseStatelessWidget {
  const Profile({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const ProfileMobile();
      },
      desktop: (BuildContext context) {
        return const ProfileWeb();
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? const ProfileMobile()
                : const ProfileWeb();
          },
        );
      },
    );
  }
}
