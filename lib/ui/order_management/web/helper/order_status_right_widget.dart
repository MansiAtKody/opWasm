import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/home/home_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_management/web/helper/order_status_top_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';


class OrderStatusRightWidget extends ConsumerWidget with BaseConsumerWidget {
  const OrderStatusRightWidget({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final homeWatch = ref.watch(homeController);
    return Stack(
      alignment: Alignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      children: [
        /// Top Widget
         const OrderStatusTopWidget(),
        homeWatch.orderTypeList[homeWatch.selectedTabIndex].paddingOnly(left: 26.w,right: 26.w, top: 8.h),
        Positioned(
          bottom: 15.h,
          child: Container(
            height: 45.h,
            width: 0.4.sw,
            decoration: BoxDecoration(
              color: AppColors.servicesScaffoldBgColor,
              borderRadius: BorderRadius.all(Radius.circular(24.r)),
            ),
            child: Center(
              child: Row(
                children: [
                  ...List.generate(
                    (homeWatch.orderTypeNameList.length),
                    (index) {
                      String currentFilter = homeWatch.orderTypeNameList[index];
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            ///Update Index
                            homeWatch.updateSelectedTabIndex(selectedTabIndex: index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: currentFilter == homeWatch.orderTypeNameList[homeWatch.selectedTabIndex] ? AppColors.black : AppColors.servicesScaffoldBgColor,
                              borderRadius: BorderRadius.all(Radius.circular(24.r)),
                            ),
                            child: Center(
                              child: CommonText(
                                title: '${currentFilter.localized} ${LocalizationStrings.keyOrders.localized}',
                                textStyle: TextStyles.regular.copyWith(
                                  fontSize: 14.sp,
                                  color: currentFilter == homeWatch.orderTypeNameList[homeWatch.selectedTabIndex] ? AppColors.white : AppColors.grey5A5A5A,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
