import 'package:flutter/material.dart';
import 'package:kody_operator/ui/error/mobile/error_mobile.dart';
import 'package:kody_operator/ui/error/web/error_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Error extends StatelessWidget with BaseStatelessWidget {
  final ErrorType? errorType;
  const Error({Key? key, this.errorType}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return ErrorMobile(errorType: errorType);
      },
      desktop: (BuildContext context) {
        return ErrorWeb(errorType: errorType);
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape ? ErrorWeb(errorType: errorType) : ErrorMobile(errorType: errorType);
          },
        );
      },
    );
  }
}
