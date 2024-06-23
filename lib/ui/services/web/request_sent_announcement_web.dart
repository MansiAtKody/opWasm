import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class RequestSentAnnouncementWeb extends ConsumerStatefulWidget {
  const RequestSentAnnouncementWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<RequestSentAnnouncementWeb> createState() =>
      _RequestSentAnnouncementWebState();
}

class _RequestSentAnnouncementWebState
    extends ConsumerState<RequestSentAnnouncementWeb> with BaseConsumerStatefulWidget{

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final requestSentAnnouncementWatch = ref.watch(requestSentAnnouncementController);
      //requestSentAnnouncementWatch.disposeController(isNotify : true);
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
