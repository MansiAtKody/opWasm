import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_controller.dart';
import 'package:kody_operator/framework/controller/services/service_list_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/web/helper/send_service_left_widget.dart';
import 'package:kody_operator/ui/services/web/helper/send_service_right_widget.dart';
import 'package:kody_operator/ui/services/web/shimmer/shimmer_services_web.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar_web.dart';
import 'package:kody_operator/ui/widgets/common_top_back_widget.dart';

class SendServiceWeb extends ConsumerStatefulWidget {
  const SendServiceWeb({required this.isSendService, Key? key})
      : super(key: key);
  final bool isSendService;

  @override
  ConsumerState<SendServiceWeb> createState() => _SendServiceWebState();
}

class _SendServiceWebState extends ConsumerState<SendServiceWeb>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final sendServiceWatch = ref.read(sendServiceController);
      sendServiceWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(seconds: 3), () {
        sendServiceWatch.updateLoadingStatus(false);
      });
      final serviceListWatch = ref.read(serviceListController);
      serviceListWatch.disposeController(isNotify: true);
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final sendServiceWatch = ref.watch(sendServiceController);
    return sendServiceWatch.isLoading
        ? const ShimmerServicesWeb()
        : _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Column(
      children: [
        /// App Bar Top Widget
        const CommonAppBarWeb(),

        Expanded(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FadeBoxTransition(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Top Text
                            CommonBackTopWidget(
                              showBackButton: false,
                              title: widget.isSendService
                                  ? LocalizationStrings.keySendService.localized
                                  : LocalizationStrings.keyReceiveService.localized,
                            ).paddingOnly(left: 25.w,bottom: 30.h),

                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: context.width * 0.02),
                                  SendServiceLeftWidget(
                                      isSendService: widget.isSendService),
                                  SizedBox(
                                    width: 24.w,
                                  ),
                                  const SendServiceRightWidget(),
                                  SizedBox(width: context.width * 0.02),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height * 0.05),
                ],
              ),
            ],
          ).paddingOnly(top: 38.h, left: 38.w, right: 38.w),
        ),
      ],
    );
  }
}
