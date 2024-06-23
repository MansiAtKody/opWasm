import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class AnnouncementGetDetailsWeb extends ConsumerStatefulWidget {
  const AnnouncementGetDetailsWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<AnnouncementGetDetailsWeb> createState() =>
      _AnnouncementGetDetailsWebState();
}

class _AnnouncementGetDetailsWebState
    extends ConsumerState<AnnouncementGetDetailsWeb> with BaseConsumerStatefulWidget{

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final announcementGetDetailsWatch = ref.watch(announcementGetDetailsController);
      //announcementGetDetailsWatch.disposeController(isNotify : true);
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
