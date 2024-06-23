import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class NotificationScreenWeb extends ConsumerStatefulWidget {
  const NotificationScreenWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationScreenWeb> createState() => _NotificationScreenWebState();
}

class _NotificationScreenWebState extends ConsumerState<NotificationScreenWeb> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final notificationScreenWatch = ref.read(notificationController);
      //notificationScreenWatch.disposeController(isNotify : true);
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
