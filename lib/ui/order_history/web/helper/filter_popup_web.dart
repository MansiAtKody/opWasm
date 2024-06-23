import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_management/web/helper/select_custom_date_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_check_box.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class FilterPopUpWeb extends ConsumerStatefulWidget {
  const FilterPopUpWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<FilterPopUpWeb> createState() => _FilterPopUpState();
}

class _FilterPopUpState extends ConsumerState<FilterPopUpWeb> with BaseConsumerStatefulWidget {
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                title: LocalizationStrings.keyFilters.localized,
                textStyle: TextStyles.regular.copyWith(fontSize: 22.sp, color: AppColors.blue009AF1),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CommonSVG(
                  strIcon: AppAssets.svgCrossWhite,
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
                    //OrderModel model = orderListWatch.orderList[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonCheckBox(
                          value: orderHistoryWatch.orderStatusFilterList[index].isSelected,
                          onChanged: (onChanged) {
                            orderHistoryWatch.orderStatusFilterUpdate(onChanged ?? false, index);
                          },
                          checkColor: AppColors.blue009AF1,
                        ).paddingOnly(right: 5.h),
                        CommonText(
                          title: orderHistoryWatch.orderStatusFilterList[index].filterName,
                          textStyle: TextStyles.regular.copyWith(color: (orderHistoryWatch.orderStatusFilterList[index].isSelected) ? AppColors.blue009AF1 : AppColors.black),
                        ),
                      ],
                    );
                  },
                ).paddingSymmetric(vertical: 25.h),

                const Divider(
                  height: 0,
                  color: AppColors.greyE6E6E6,
                ),

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
                          textStyle: TextStyles.regular.copyWith(color: (orderHistoryWatch.dateFilterList[index].isSelected) ? AppColors.blue009AF1 : AppColors.black),
                        ),
                      ],
                    ).paddingOnly(bottom: 20);
                  },
                ).paddingOnly(top:25.h,bottom: 5.h),

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
                ).paddingOnly(bottom: 15.h),

                ///date picker
                const SelectCustomDateWidgetWeb(),
              ],
            ),
          ),
          CommonButton(
            width: double.maxFinite,
            onTap: () async{
              await getOrderListApiCall(orderHistoryWatch).then((value){
                Navigator.pop(context);
              });

            },
            isButtonEnabled:true,
            height: 50.h,
            buttonText: LocalizationStrings.keyApply.localized,
            buttonTextStyle: TextStyles.medium.copyWith(color: AppColors.white),
          ).paddingOnly(bottom: 15.h),
          CommonButton(
            width: double.maxFinite,
            buttonEnabledColor: AppColors.whiteF7F7FC,
            onTap: () async{
              orderHistoryWatch.clearFilter();
              await getOrderListApiCall(orderHistoryWatch).then((value){
                Navigator.pop(context);
              });
            },
            isButtonEnabled:true,
            height: 50.h,
            buttonText: LocalizationStrings.keyClearAll.localized,
            buttonTextStyle: TextStyles.medium.copyWith(color: AppColors.black171717),
          ),
        ],
      ).paddingSymmetric(horizontal: 30.w, vertical: 30.h),
    );
  }

  /// Api call
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
