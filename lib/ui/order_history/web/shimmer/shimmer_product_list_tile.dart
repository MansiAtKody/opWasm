import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/order_history/web/helper/service_detail_popup.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerProductListTile extends StatelessWidget {
  const ShimmerProductListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderHistoryWatch = ref.watch(orderHistoryController);
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          color: AppColors.lightPink),
                      child: InkWell(
                        onTap: () {
                          showAnimatedDialog(
                            context,
                            backgroundColor: AppColors.white,
                            isCloseButtonVisible: false,
                            heightPercentage: 64,
                            widthPercentage: 70,
                            onPopCall: (animationController) {
                              orderHistoryWatch.updateAnimationController(
                                  animationController);
                            },
                            child: const SeriveDetailPopup(),
                          );
                        },
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: {
                            ///Order id
                            0: FlexColumnWidth(10.w),

                            ///User/ Entity name
                            1: FlexColumnWidth(8.w),

                            /// Location Point
                            2: FlexColumnWidth(8.w),

                            /// Created date
                            3: FlexColumnWidth(8.w),

                            /// Status
                            4: FlexColumnWidth(11.w),

                            /// View dialog
                            5: FlexColumnWidth(3.w),
                          },
                          children: [
                            TableRow(
                              children: [
                                CommonShimmer(
                                  height: 10.h,
                                  width: 42.w,
                                ).paddingOnly(right: 50.w),
                                CommonShimmer(
                                  height: 10.h,
                                  width: 100.w,
                                ).paddingOnly(right: 50.w),
                                CommonShimmer(
                                  height: 10.h,
                                  width: 110.w,
                                ).paddingOnly(right: 50.w),
                                CommonShimmer(
                                  height: 10.h,
                                  width: 92.w,
                                ).paddingOnly(right: 50.w),
                                CommonShimmer(
                                  height: 43.h,
                                  width: 107.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22.r),
                                      color: AppColors.black),
                                ).paddingOnly(right: 50.w),
                                CommonShimmer(
                                  height: 33.h,
                                  width: 33.h,
                                ),
                              ],
                            ),
                          ],
                        ).paddingOnly(
                            left: 25.w, right: 20.w, top: 13.h, bottom: 13.h),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 22.h,
                    );
                  },
                ),
              ),
              SizedBox(
                width: 50.w,
              )
            ],
          ).paddingOnly(bottom: 23.h),
        );
      },
    );
  }
}

