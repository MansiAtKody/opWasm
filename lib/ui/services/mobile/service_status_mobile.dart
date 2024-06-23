import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/service_status_controller.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/repository/service/service_request_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/mobile/helper/common_person_list_tile.dart';
import 'package:kody_operator/ui/services/mobile/helper/request_details_common_widget.dart';
import 'package:kody_operator/ui/services/mobile/helper/shimmer_service_status_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class ServiceStatusMobile extends ConsumerStatefulWidget {
  const ServiceStatusMobile({
    required this.isSendService,
    required this.request,
    required this.model,
    Key? key,
  }) : super(key: key);

  final ProfileModel? model;
  final ServiceRequestModel? request;
  final bool isSendService;

  @override
  ConsumerState<ServiceStatusMobile> createState() => _ServiceStatusMobileState();
}

class _ServiceStatusMobileState extends ConsumerState<ServiceStatusMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final serviceStatusWatch = ref.read(serviceStatusController);
      serviceStatusWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(seconds: 3),(){
        serviceStatusWatch.updateLoadingStatus(false);
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
    final serviceStatusWatch = ref.watch(serviceStatusController);
    return Scaffold(
      appBar: CommonAppBar(
        isLeadingEnable: true,
        customTitleWidget: CommonText(
          title: widget.isSendService ? LocalizationStrings.keySendService.localized : LocalizationStrings.keyReceiveService.localized,
          textStyle: TextStyles.medium.copyWith(fontSize: 22.sp, color: AppColors.white),
        ),
      ),
      body: CommonWhiteBackground(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        backgroundColor: AppColors.buttonDisabledColor,
        height: context.height,
        child: serviceStatusWatch.isLoading ? const ShimmerServiceStatusMobile() : _bodyWidget(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///Status of the sent or received Services
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonPersonListTile(
                  profile: ProfileModel(
                    imageUrl: widget.model?.imageUrl ?? '',
                    name: widget.model?.name ?? '',
                    department: widget.model?.department ?? '',
                    id: 0,
                  ),
                  backgroundColor: AppColors.white,
                  isSuffixVisible: false,
                  height: 15.h,
                ).paddingSymmetric(
                  horizontal: 10.w,
                ),
                Divider(
                  height: 4.h,
                ).paddingOnly(left: 20.w, right: 20.w, top: 20.h),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CommonText(
                    //   title: LocalizationStrings.keySubject.localized,
                    //   textStyle: TextStyles.regular.copyWith(
                    //     color: AppColors.grey7E7E7E,
                    //   ),
                    // ).paddingOnly(bottom: 4.h),
                    // CommonText(
                    //   title: widget.request?.subject ?? '',
                    //   textStyle: TextStyles.regular.copyWith(
                    //     color: AppColors.black171717,
                    //   ),
                    // ).paddingOnly(bottom: 20.h),
                    CommonText(
                      title: LocalizationStrings.keyMessage.localized,
                      textStyle: TextStyles.regular.copyWith(
                        color: AppColors.grey7E7E7E,
                      ),
                    ).paddingOnly(bottom: 4.h),
                    CommonText(
                      title: widget.request?.message ?? '',
                      maxLines: 20,
                      textStyle: TextStyles.regular.copyWith(
                        color: AppColors.black171717,
                      ),
                    ),

                    /// Divider
                    Divider(
                      height: 4.h,
                    ).paddingSymmetric(vertical: 30.h),

                    CommonText(
                      title: LocalizationStrings.keyRequestDetails.localized,
                      textStyle: TextStyles.medium.copyWith(
                        color: AppColors.black171717,
                      ),
                    ).paddingOnly(bottom: 20.h),
                    RequestDetailsCommonWidget(
                      title: widget.request?.orderId ?? '',
                      label: LocalizationStrings.keyOrderId.localized,
                    ).paddingOnly(bottom: 10.h),
                    RequestDetailsCommonWidget(
                      title: widget.request?.fromPerson ?? '',
                      label: LocalizationStrings.keyFrom.localized,
                    ).paddingOnly(bottom: 10.h),
                    RequestDetailsCommonWidget(
                      title: widget.request?.toPerson ?? '',
                      label: LocalizationStrings.keyTo.localized,
                    ).paddingOnly(bottom: 10.h),
                    RequestDetailsCommonWidget(
                      title: widget.request?.itemType ?? '',
                      label: LocalizationStrings.keyItemType.localized,
                    ).paddingOnly(bottom: 10.h),
                    RequestDetailsCommonWidget(
                      title: widget.request?.orderStatus ?? '',
                      label: LocalizationStrings.keyOrderStatus.localized,
                    ).paddingOnly(bottom: 10.h),
                    RequestDetailsCommonWidget(
                      title: (widget.request?.trayNumber ?? '').toString(),
                      label: 'Tray ',
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
              ],
            ).paddingSymmetric(horizontal: 0.w, vertical: 20.h),
          ],
        ),
      ),
    );
  }
}
