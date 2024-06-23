import 'package:flutter/material.dart';
import 'package:kody_operator/ui/user_management/mobile/user_management_mobile.dart';
import 'package:kody_operator/ui/user_management/web/user_management_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserManagement extends StatelessWidget with BaseStatelessWidget {
  const UserManagement({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const UserManagementMobile();
      },
      desktop: (BuildContext context) {
        return const UserManagementWeb();
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape ? const UserManagementWeb() : const UserManagementMobile();
          },
        );
      },
    );
  }
}
