import 'package:flutter/material.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/services/mobile/send_service_detail_mobile.dart';
import 'package:kody_operator/ui/services/web/send_service_detail_web.dart';

class SendServiceDetail extends StatelessWidget with BaseStatelessWidget{
  const SendServiceDetail({Key? key, required this.isSendService,required this.profileModel}) : super(key: key);
  final bool isSendService;
  final ProfileModel profileModel;


  ///Build Override
   @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return SendServiceDetailMobile(profileModel: profileModel, isSendService: isSendService);
        },
        desktop: (BuildContext context) {
          return  SendServiceDetailWeb(isSendService:isSendService, profileModel: profileModel,);
        },
        tablet: (BuildContext context) {
      return OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.landscape
              ? SendServiceDetailWeb(
            isSendService: isSendService,
              profileModel: profileModel
          )
              : SendServiceDetailMobile(profileModel: profileModel, isSendService: isSendService);
        },
      );
    },
    );
  }
}

