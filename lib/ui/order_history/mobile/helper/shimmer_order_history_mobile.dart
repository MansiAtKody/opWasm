import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerOrderHistoryMobile extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerOrderHistoryMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.sizeOf(context).height * 0.37,
                      decoration: BoxDecoration(
                        color: AppColors.lightPink,
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      ),
                      child: Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          final orderHistoryWatch =
                              ref.watch(orderHistoryController);

                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ///order detail title
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            orderHistoryWatch.title.length +
                                                1,
                                        itemBuilder: (context, index) {
                                          return CommonShimmer(
                                              height: 10.h, width: 87.w);
                                        },
                                        separatorBuilder:
                                            (BuildContext context,
                                                int index) {
                                          return SizedBox(
                                            height: 25.h,
                                          );
                                        },
                                      ),
                                    ),
                                    // CommonShimmer(height: 10.h, width: 87.w)
                                  ],
                                ),
                              ),

                              ///order detail data
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonShimmer(
                                          height: 10.h, width: 150.w),
                                      CommonShimmer(
                                          height: 10.h, width: 150.w),
                                      CommonShimmer(
                                          height: 10.h, width: 150.w),
                                      CommonShimmer(
                                          height: 10.h, width: 150.w),
                                      CommonShimmer(
                                          height: 10.h, width: 150.w),
                                      CommonShimmer(
                                          height: 10.h, width: 150.w),
                                      CommonShimmer(
                                        height: 33.h,
                                        width: 69.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ).paddingSymmetric(
                              vertical: 36.h, horizontal: 20.w);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 20.h,
                    );
                  },
                ).paddingOnly(left: 12.w, right: 12.w),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Shimmer Search Bar
class ShimmerSearchBarOrderHistoryMobile extends StatelessWidget with BaseStatelessWidget {
  const ShimmerSearchBarOrderHistoryMobile({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonShimmer(
      height: 44.h,
      width: context.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(67.r), color: AppColors.black),
    ).paddingOnly( left: 12.w, right: 12.w);
  }
}
