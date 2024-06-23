import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class RequestSentWeb extends ConsumerStatefulWidget {
  const RequestSentWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<RequestSentWeb> createState() => _RequestSentWebState();
}

class _RequestSentWebState extends ConsumerState<RequestSentWeb> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final requestSentWatch = ref.watch(requestSentController);
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
