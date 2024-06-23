import 'package:flutter/material.dart';
import 'package:kody_operator/ui/services/mobile/services_mobile.dart';
import 'package:kody_operator/ui/services/web/services_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Services extends StatelessWidget with BaseStatelessWidget {
  const Services({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const ServicesMobile();
      },
      desktop: (BuildContext context) {
        return const ServicesWeb();
      },
      tablet: (BuildContext context) {
        return const ServicesWeb();
      },
    );
  }
}
