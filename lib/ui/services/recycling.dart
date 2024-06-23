import 'package:flutter/material.dart';
import 'package:kody_operator/ui/services/mobile/recycling_mobile.dart';
import 'package:kody_operator/ui/services/web/recycling_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Recycling extends StatelessWidget {
  const Recycling({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const RecyclingMobile();
      },
      desktop: (BuildContext context) {
        return const RecyclingWeb();
      },
      tablet: (BuildContext context) {
        return const RecyclingWeb();
      },
    );
  }
}
