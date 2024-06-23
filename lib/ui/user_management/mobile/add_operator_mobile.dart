import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';

class AddOperatorMobile extends ConsumerStatefulWidget {
  final SubOperatorData? operatorData;
  final String? uuid;
  const AddOperatorMobile({Key? key,this.operatorData,this.uuid}) : super(key: key);

  @override
  ConsumerState<AddOperatorMobile> createState() => _AddOperatorMobileState();
}

class _AddOperatorMobileState extends ConsumerState<AddOperatorMobile> {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final addOperatorWatch = ref.watch(addOperatorController);
      //addOperatorWatch.disposeController(isNotify : true);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Container();
  }


}
