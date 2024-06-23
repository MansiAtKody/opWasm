import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/service_history_controller.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/mobile/helper/appbar_bottom_widget_service_history_mobile.dart';
import 'package:kody_operator/ui/services/mobile/helper/common_document_sent_widget.dart';
import 'package:kody_operator/ui/services/mobile/helper/shimmer_service_history_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_sliver_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class ServiceHistoryMobile extends ConsumerStatefulWidget {
  const ServiceHistoryMobile({
    required this.isSendService,
    required this.profileModel,
    Key? key,
  }) : super(key: key);

  final ProfileModel profileModel;
  final bool isSendService;

  @override
  ConsumerState<ServiceHistoryMobile> createState() => _ServiceHistoryMobileState();
}

class _ServiceHistoryMobileState extends ConsumerState<ServiceHistoryMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final serviceHistoryWatch = ref.read(serviceHistoryController);
      serviceHistoryWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(seconds: 3),(){
        serviceHistoryWatch.updateLoadingStatus(false);
      });
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
    final serviceHistoryWatch = ref.watch(serviceHistoryController);
    return Scaffold(
      body: CommonSliverAppBar(
        isBorderRadiusEnable: false,
        title: widget.isSendService ? LocalizationStrings.keySendService.localized : LocalizationStrings.keyReceiveService.localized,
        appBarWidget: serviceHistoryWatch.isLoading ? const ShimmerServiceHistoryAppbarWidget().paddingOnly(top: 70.h, left: 20.w, right: 20.w, bottom: 0.h) : AppbarBottomWidgetServiceHistoryMobile(profileModel: widget.profileModel).paddingOnly(top: 70.h, left: 20.w, right: 20.w, bottom: 0.h),
        expandedHeight: 220.h,
        bodyWidget: CommonWhiteBackground(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          backgroundColor: AppColors.buttonDisabledColor,
          child: serviceHistoryWatch.isLoading ? const ShimmerServiceHistoryMobile() : _bodyWidget(),
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///If there are any recent Requests than Display Request or Display No Recent Requests
                  widget.profileModel.requests?.isNotEmpty ?? false
                      ? ListView.builder(
                          itemCount: widget.profileModel.requests?.length ?? 0,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                ///Navigates to Service Status Screen
                                ref.read(navigationStackProvider).push(NavigationStackItem.serviceStatus(request: widget.profileModel.requests?[index], model: widget.profileModel, isSendService: widget.isSendService));
                              },

                              ///Common Person Tile
                              child: CommonDocumentSentWidget(
                                serviceRequestModel: widget.profileModel.requests?[index],
                                ).paddingOnly(bottom: 20.h, left: 10.w, right: 10.w),
                            );
                          }).paddingOnly(top: 15.h)
                      : EmptyStateWidget(
                          title: LocalizationStrings.keyNoDataFound.localized,
                          titleColor: AppColors.black171717,
                          subTitle: LocalizationStrings.keyThereIsNoPreviousRequest.localized,
                          // emptyStateFor: EmptyState.noData,
                        )
                ],
              ),
            ),
          ),

          /// Bottom button Widget
          CommonButtonMobile(
            withBackground: false,
            buttonText: LocalizationStrings.keyCreateRequest.localized,
            rightIcon: const Icon(Icons.arrow_forward, color: AppColors.white),
            onTap: () {
              ref.read(navigationStackProvider).push(NavigationStackItem.sendServiceDetail(isSendService: widget.isSendService, profileModel: widget.profileModel));
            },
          ).paddingSymmetric(horizontal: 15.w, vertical: 20.h)
        ],
      ),
    );
  }
}
