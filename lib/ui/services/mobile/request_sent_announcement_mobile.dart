import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/services/mobile/helper/common_request_sent.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class RequestSentAnnouncementMobile extends ConsumerStatefulWidget {
  const RequestSentAnnouncementMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<RequestSentAnnouncementMobile> createState() => _RequestSentAnnouncementMobileState();
}

class _RequestSentAnnouncementMobileState extends ConsumerState<RequestSentAnnouncementMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final requestSentAnnouncementWatch = ref.read(requestSentAnnouncementController);
      // requestSentAnnouncementWatch.disposeController(isNotify : true);
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: _bodyWidget(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    /// Request Sent Widget
    return const CommonRequestSentWidget(animImage: AppAssets.animYourRequestSent);
  }
}
