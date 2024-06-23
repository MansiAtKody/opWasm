import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/order_user_details_widget.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/robot_tray_empty_trays_widget.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailsWidget extends StatelessWidget with BaseStatelessWidget {
  const OrderDetailsWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        final orderStatusWatch = ref.watch(orderStatusController);
        if (robotTraySelectionWatch.robotListState.isLoading ||
            robotTraySelectionWatch.getTrayListState.isLoading ||
            robotTraySelectionWatch.deleteItemFromTrayState.isLoading ||
            robotTraySelectionWatch.addItemToTrayState.isLoading) {
          return _shimmerOrderDetailsWidget();
        } else if (orderStatusWatch.pastSocketOrders.isEmpty && (robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 1) - 1]?.data?.isEmpty ?? true)) {
          return const RobotTrayEmptyTraysWidget(
            emptyStateFor: EmptyStateFor.trayList,
          );
        } else {
          return ListView.builder(
              padding: EdgeInsets.only(right: 30.w),
              shrinkWrap: true,
              itemCount: (robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?.length ?? 0) + 1,
              itemBuilder: (context, index) {
                if (index == (robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?.length ?? 1)) {
                  final orderStatusWatch = ref.watch(orderStatusController);

                  /// add button
                  return Visibility(
                    visible: orderStatusWatch.pastSocketOrders.isNotEmpty,
                    child: InkWell(
                      onTap: () {
                        if (orderStatusWatch.pastSocketOrders.isNotEmpty) {
                          /// Tray Dialog
                          showAnimatedTrayDialog(
                            context,
                            title: '${LocalizationStrings.keyTray.localized} ${robotTraySelectionWatch.selectedTrayNumber}',
                            heightPercentage: 79,
                            widthPercentage: 70,
                            onPopCall: (animationController) {
                              robotTraySelectionWatch.updateAnimationController(animationController);
                            },
                            onCloseTap: () {
                              robotTraySelectionWatch.animationController?.reverse(from: 0.3);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(child: OrderUserDetailsWidget()),

                                  /// Add In Button
                                  Consumer(builder: (context, ref, child) {
                                    final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
                                    return CommonButton(
                                      buttonText: LocalizationStrings.keyAddIn.localized,
                                      width: context.width * 0.1,
                                      height: 60.h,
                                      buttonEnabledColor: AppColors.blue009AF1,
                                      buttonTextColor: robotTraySelectionWatch.orderItemUuidList.isNotEmpty ? AppColors.white : AppColors.greyBEBEBE,
                                      buttonDisabledColor: AppColors.greyBEBEBE.withOpacity(0.3),
                                      isButtonEnabled: robotTraySelectionWatch.orderItemUuidList.isNotEmpty,
                                      isLoading: robotTraySelectionWatch.addItemToTrayState.isLoading,
                                      onTap: () async {
                                        await robotTraySelectionWatch.addItemToTrayApi(context);
                                        await ref.read(orderStatusController).socketManager.refreshSocket();
                                        robotTraySelectionWatch.orderItemUuidList.clear();
                                        if (robotTraySelectionWatch.addItemToTrayState.success?.status == ApiEndPoints.apiStatus_200) {
                                          robotTraySelectionWatch.animationController?.reverse(from: 0.3);
                                          robotTraySelectionWatch.clearOrderItemUuidList();
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            await robotTraySelectionWatch.getTrayListApi(context);
                                          }
                                        }
                                      },
                                    ).paddingOnly(top: 20.h);
                                  }),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.070,
                        height: MediaQuery.sizeOf(context).width * 0.070,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: AppColors.greyCACACA), color: AppColors.white),
                        child: const CommonSVG(
                          strIcon: AppAssets.svgAddIcon,
                        ).paddingAll(35.r),
                      ),
                    ),
                  );
                } else {
                  /// details tile
                  return Container(
                    padding: EdgeInsets.all(18.h),
                    width: context.width * 0.20,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      border: Border.all(color: AppColors.greyE6E6E6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(24.r),
                                child: CacheImage(
                                  imageURL: robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?[index].ordersItem?.productImage ?? staticImageURL,
                                  contentMode: BoxFit.scaleDown,
                                ),
                              ),
                            ).paddingOnly(right: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonText(
                                    title: robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?[index].ordersItem?.productName ?? '',
                                    textStyle: TextStyles.regular.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColors.black,
                                    ),
                                  ).paddingOnly(bottom: 5.h),
                                  CommonText(
                                    title: robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?[index].ordersItem?.ordersItemAttributes
                                            ?.map((e) => e.attributeNameValue)
                                            .toList()
                                            .join(',') ??
                                        '',
                                    maxLines: 2,
                                    textStyle: TextStyles.regular.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.grey8D8C8C,
                                    ),
                                  ).paddingOnly(bottom: 5.h),
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                                      decoration: BoxDecoration(color: AppColors.yellowFFEDBF, borderRadius: BorderRadius.all(Radius.circular(16.r))),
                                      child: CommonText(
                                        title: robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?[index].uuid ?? '',
                                        textStyle: TextStyles.regular.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColors.black,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox.fromSize(
                              size: Size.fromRadius(24.r),
                              child: InkWell(
                                onTap: () {
                                  ///Remove Order
                                  robotTraySelectionWatch
                                      .deleteItemFromTrayApi(context, robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?[index].uuid ?? '')
                                      .then((value) async {
                                    await ref.read(orderStatusController).socketManager.refreshSocket();
                                    //robotTraySelectionWatch.getTrayListApi(context);
                                    robotTraySelectionWatch.updateSelectedRobotNew(context, selectedRobot: robotTraySelectionWatch.selectedRobotNew);
                                  });
                                },
                                child: const CommonSVG(
                                  strIcon: AppAssets.svgRedCrossIcon,
                                ),
                              ),
                            ).paddingOnly(left: 10.w)
                          ],
                        ).paddingOnly(bottom: 15.h),
                        Container(
                          padding: EdgeInsets.all(5.h),
                          decoration: BoxDecoration(
                            color: AppColors.whiteEDEDFF,
                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                            border: Border.all(color: AppColors.greyE6E6E6),
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              const CommonSVG(strIcon: AppAssets.svgTrayItemOwner).paddingOnly(right: 5.w),
                              CommonText(
                                title: robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?[index].entityName ??
                                    robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?[index].entityType ??
                                    '',
                                textStyle: TextStyles.medium.copyWith(fontSize: 12.sp, color: AppColors.primary2),
                              ),
                              const Spacer(),
                              const CommonSVG(strIcon: AppAssets.svgTrayItemLocation).paddingOnly(right: 5.w),
                              CommonText(
                                title: robotTraySelectionWatch.trayDataList?[(robotTraySelectionWatch.selectedTrayNumber ?? 0) - 1]?.data?[index].ordersItem?.locationPointsName ?? '',
                                textStyle: TextStyles.medium.copyWith(fontSize: 12.sp, color: AppColors.primary2),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 10.h);
                }
              });
        }
      },
    );
  }

  /// shimmer
  Widget _shimmerOrderDetailsWidget() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.white,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: 140.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ).paddingOnly(bottom: 10.h);
        },
      ),
    );
  }
}
