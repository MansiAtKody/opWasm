import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_history/mobile/helper/select_custom_date_widget_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_check_box_mobile.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class FilterPopUpMobile extends ConsumerStatefulWidget {
  const FilterPopUpMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<FilterPopUpMobile> createState() => _FilterPopUpState();
}

class _FilterPopUpState extends ConsumerState<FilterPopUpMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final orderHistoryWatch = ref.watch(orderHistoryController);

    return Material(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            bottomLeft: Radius.circular(40.r)
        ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                title: LocalizationStrings.keyFilters.localized,
                textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.blue009AF1),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CommonSVG(
                  strIcon: AppAssets.svgCross,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 35.h,
                ),
                CommonText(
                  title: LocalizationStrings.keyByOrderStatus.localized,
                  textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black),
                ),

                ///Filter for order status
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderHistoryWatch.orderStatusFilterList.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: CommonCheckBoxMobile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            value: orderHistoryWatch.orderStatusFilterList[index].isSelected,
                            onChanged: (onChanged) {
                              orderHistoryWatch.orderStatusFilterUpdate(onChanged ?? false, index);
                            },
                            checkColor: AppColors.blue009AF1,
                          ).paddingOnly(right: 5.h),
                        ),
                        CommonText(
                          title: orderHistoryWatch.orderStatusFilterList[index].filterName,
                          textStyle: TextStyles.regular.copyWith(color: (orderHistoryWatch.orderStatusFilterList[index].isSelected) ? AppColors.blue009AF1 : AppColors.grey929292),
                        ),
                      ],
                    ).paddingOnly(bottom: 19.h);
                  },
                ).paddingSymmetric(vertical: 20.h),

                const Divider(
                  height: 0,
                  color: AppColors.greyE6E6E6,
                ),

                CommonText(
                  title: LocalizationStrings.keyOrderByDate.localized,
                  textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black),
                ).paddingOnly(top: 35.h),

                ///date filter list
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderHistoryWatch.dateFilterList.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    //OrderModel model = orderListWatch.orderList[index];
                    return Row(
                      children: [
                        InkWell(
                          onTap:(){
                            orderHistoryWatch.dateFilterUpdate(index: index);
                          },
                          child: CommonSVG(
                            strIcon: orderHistoryWatch.dateFilterList[index].filterName == orderHistoryWatch.selectedDateFilter?AppAssets.svgRadioSelected:AppAssets.svgRadioUnselected,
                            svgColor: orderHistoryWatch.dateFilterList[index].filterName== orderHistoryWatch.selectedDateFilter?AppColors.blue009AF1:AppColors.black,
                          ),
                        ).paddingOnly(right: 5.h),
                        CommonText(
                          title: orderHistoryWatch.dateFilterList[index].filterName,
                          textStyle: TextStyles.regular.copyWith(color: (orderHistoryWatch.dateFilterList[index].isSelected) ? AppColors.blue009AF1 : AppColors.grey929292),
                        ),
                      ],
                    ).paddingOnly(bottom: 19.h);
                  },
                ).paddingSymmetric(vertical: 20.h),

                const Divider(
                  height: 0,
                  color: AppColors.greyE6E6E6,
                ),
                SizedBox(
                  height: 30.h,
                ),
                CommonText(
                  title: LocalizationStrings.keyCustomizeByDate.localized,
                  textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black),
                ).paddingOnly(bottom: 15.h, left: 10.w),

                ///date picker
                const SelectCustomDateWidgetMobile(),
              ],
            ),
          ),

          /// Apply filter button
          CommonButton(
            width: double.maxFinite,
            onTap: () async{
              await getOrderListApiCall(orderHistoryWatch).then((value) {
                Navigator.pop(context);
              });
            },
            isButtonEnabled:true,
            height: 50.h,
            buttonText: LocalizationStrings.keyApply.localized,
            buttonTextStyle: TextStyles.medium.copyWith(color: AppColors.white),
          ).paddingOnly(bottom: 15.h),

          /// Clear filter button
          CommonButton(
            width: double.maxFinite,
            buttonEnabledColor: AppColors.whiteF7F7FC,
            onTap: () async{
              orderHistoryWatch.clearFilter();
              await getOrderListApiCall(orderHistoryWatch).then((value) {
                Navigator.pop(context);
              });
            },
            isButtonEnabled:true,
            height: 50.h,
            buttonText: LocalizationStrings.keyClearAll.localized,
            buttonTextStyle: TextStyles.medium.copyWith(color: AppColors.black171717),
          ),
        ],
      ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
    );
  }

  /// Order list api call
  Future getOrderListApiCall(OrderHistoryController orderHistoryWatchWatch) async {
    orderHistoryWatchWatch.resetPaginationOrderList();
    orderHistoryWatchWatch.getOrderListApi(context);
    orderHistoryWatchWatch.orderListScrollController.addListener(() {
      if (mounted) {
        if (orderHistoryWatchWatch.orderListScrollController.position.pixels >=
            (orderHistoryWatchWatch
                .orderListScrollController.position.maxScrollExtent -
                300)) {
          if (orderHistoryWatchWatch.orderListState.success?.hasNextPage ??
              false) {
            orderHistoryWatchWatch.incrementOrderListPageNumber();
            orderHistoryWatchWatch.getOrderListApi(context);
          }
        }
      }
    });
  }
}
