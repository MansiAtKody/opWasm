import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:kody_operator/ui/map/mobile/map_mobile.dart';
import 'package:kody_operator/ui/map/web/map_web.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const MapMobile();
      },
      desktop: (BuildContext context) {
        return const MapWeb();
      },
      tablet: (BuildContext context) {
        return const MapWeb();
      },
    );
  }
}
