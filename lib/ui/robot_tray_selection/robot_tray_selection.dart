import 'package:flutter/material.dart';
import 'package:kody_operator/ui/robot_tray_selection/mobile/robot_tray_selection_mobile.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/robot_tray_selection_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RobotTraySelection extends StatelessWidget with BaseStatelessWidget{
  const RobotTraySelection({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const RobotTraySelectionMobile();
        },
        desktop: (BuildContext context) {
          return const RobotTraySelectionWeb();
        },
        tablet: (BuildContext context) {
          return const RobotTraySelectionWeb();
        }
    );
  }
}

