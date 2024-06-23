import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/services/mobile/send_service_mobile.dart';
import 'package:kody_operator/ui/services/web/send_service_web.dart';

class SendService extends StatelessWidget with BaseStatelessWidget {
  const SendService({required this.isSendService,Key? key}) : super(key: key);
  final bool isSendService;

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return SendServiceMobile(isSendService: isSendService);
        },
        desktop: (BuildContext context) {
          return  SendServiceWeb(isSendService:isSendService,);
        },
      tablet: (BuildContext context) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.landscape
                ? SendServiceWeb(
              isSendService: isSendService,
            )
                : SendServiceMobile(isSendService: isSendService);
          },
        );
      },
    );
  }
}

