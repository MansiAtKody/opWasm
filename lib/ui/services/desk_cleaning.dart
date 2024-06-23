import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/services/web/desk_cleaning_web.dart';

class DeskCleaning extends StatelessWidget with BaseStatelessWidget {
  const DeskCleaning({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const DeskCleaningWeb();
        },
        desktop: (BuildContext context) {
          return const DeskCleaningWeb();
        },
      tablet: (BuildContext context) {
        return const DeskCleaningWeb();
      },
    );
  }
}

