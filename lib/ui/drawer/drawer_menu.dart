import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/drawer/mobile/drawer_menu_mobile.dart';
import 'package:kody_operator/ui/drawer/web/drawer_menu_web.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const DrawerMenuMobile();
        },
        desktop: (BuildContext context) {
          return const DrawerMenuWeb();
        }
    );
  }
}

