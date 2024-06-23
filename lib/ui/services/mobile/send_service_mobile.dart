import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/mobile/helper/profile_list_send_service_mobile.dart';
import 'package:kody_operator/ui/services/mobile/helper/send_service_mobile_appbar_widget.dart';
import 'package:kody_operator/ui/services/mobile/helper/ticket_history_widget_send_service_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class SendServiceMobile extends ConsumerStatefulWidget {
  final bool isSendService;

  const SendServiceMobile({Key? key, required this.isSendService}) : super(key: key);

  @override
  ConsumerState<SendServiceMobile> createState() => _SendServiceMobileState();
}

class _SendServiceMobileState extends ConsumerState<SendServiceMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final sendServiceWatch = ref.read(sendServiceController);
      sendServiceWatch.disposeController(isNotify: true);
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
      appBar: CommonAppBar(
        backgroundColor: AppColors.black,
        title: widget.isSendService ? LocalizationStrings.keySendService.localized : LocalizationStrings.keyReceiveService.localized,
      ),
      body: _bodyWidget(),
      // body: CommonSliverAppBar(
      //   isBorderRadiusEnable: false,
      //   title: widget.isSendService ? LocalizationStrings.keySendService.localized : LocalizationStrings.keyReceiveService.localized,
      //   expandedHeight: 180.h,
      //   bodyWidget: ,
      // ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final sendServiceWatch = ref.watch(sendServiceController);
    return Column(
      children: [
        SendServiceMobileAppbarWidget(isSendService: widget.isSendService),
        SizedBox(height: context.height * 0.03),
        Expanded(
          child: CommonWhiteBackground(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            backgroundColor: AppColors.buttonDisabledColor,
            child: sendServiceWatch.profiles.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
                    child: ProfileListSendServiceMobile(isSendService: widget.isSendService))
                : Container(

                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
                    child: TicketHistoryWidgetSendServiceMobile(isSendService: widget.isSendService)),
          ),
        ),
      ],
    );
  }
}
