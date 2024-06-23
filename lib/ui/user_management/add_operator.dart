import 'package:flutter/material.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/user_management/mobile/add_operator_mobile.dart';
import 'package:kody_operator/ui/user_management/web/add_operator_web.dart';

class AddOperator extends StatelessWidget {
  final SubOperatorData? operatorData;
  final String? uuid;
  const AddOperator({Key? key,this.operatorData,this.uuid}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const AddOperatorMobile();
        },
        desktop: (BuildContext context) {
          return AddOperatorWeb(subOperatorData: operatorData,uuid: uuid,);
        }
    );
  }
}

