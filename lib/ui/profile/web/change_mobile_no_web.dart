import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';

class ChangeMobileNoWeb extends ConsumerStatefulWidget {
  const ChangeMobileNoWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangeMobileNoWeb> createState() => _ChangeMobileNoWebState();
}

class _ChangeMobileNoWebState extends ConsumerState<ChangeMobileNoWeb> {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final changeMobileNoWatch = ref.watch(changeMobileNoController);
      //changeMobileNoWatch.disposeController(isNotify : true);
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
