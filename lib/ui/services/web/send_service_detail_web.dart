import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class SendServiceDetailWeb extends ConsumerStatefulWidget {
  const SendServiceDetailWeb({Key? key,required this.isSendService,required this.profileModel}) : super(key: key);
  final bool isSendService;
  final ProfileModel profileModel;
  @override
  ConsumerState<SendServiceDetailWeb> createState() =>
      _SendServiceDetailWebState();
}

class _SendServiceDetailWebState extends ConsumerState<SendServiceDetailWeb> with BaseConsumerStatefulWidget{

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final sendServiceDetailWatch = ref.watch(sendServiceDetailController);
      //sendServiceDetailWatch.disposeController(isNotify : true);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Container();
  }


}
