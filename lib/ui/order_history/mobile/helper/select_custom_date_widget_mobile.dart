import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/order_history/mobile/helper/show_date_picker_widget_mobile.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/common_dialog_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SelectCustomDateWidgetMobile extends ConsumerWidget with BaseConsumerWidget {
  const SelectCustomDateWidgetMobile({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        return SizedBox(
          height: 0.18.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(decoration: BoxDecoration(border: Border.all(color: AppColors.greyE6E6E6), borderRadius: BorderRadius.all(Radius.circular(20.r))), child: _widgetCommonSelectDateTappable(context, isStartDate: true)).paddingOnly(bottom: 15.h),
              Container(decoration: BoxDecoration(border: Border.all(color: AppColors.greyE6E6E6), borderRadius: BorderRadius.all(Radius.circular(20.r))), child: _widgetCommonSelectDateTappable(context, isStartDate: false))
            ],
          ),
        );
      },
    );
  }

  Widget _widgetCommonSelectDateTappable(BuildContext context, {required bool isStartDate}) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderHistoryWatch = ref.watch(orderHistoryController);
        return Opacity(
          opacity: !isStartDate && orderHistoryWatch.startDate == null ? 0.4 : 1,
          child: InkWell(
            onTap: () {
              if (!(!isStartDate && orderHistoryWatch.startDate == null)) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CommonDialogWidget(
                      child: ShowDatePicketWidgetMobile(isStartDate: isStartDate),
                    );
                  },
                );
              }
            },
            child: _widgetCommonSelectDate(isStartDate: isStartDate, context: context),
          ),
        );
      },
    );
  }

  Widget _widgetCommonSelectDate({required bool isStartDate, required BuildContext context}) {
    return Consumer(builder: (context, ref, child) {
      final orderHistoryWatch = ref.watch(orderHistoryController);
      return Container(
        height: 0.07.sh,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 13.w,
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: getDateTextIconColor(isStartDate, orderHistoryWatch),
            ),
            SizedBox(
              width: 10.w,
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: CommonText(
                title: getDateFromDateTime(isStartDate, orderHistoryWatch),
                clrfont: getDateTextIconColor(isStartDate, orderHistoryWatch),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 5.w),
      );
    });
  }

  Color getDateTextIconColor(bool isStartDate, OrderHistoryController orderHistoryWatch) {
    return isStartDate
        ? (orderHistoryWatch.startDate != null)
        ? AppColors.black
        : AppColors.grey7E7E7E
        : (orderHistoryWatch.endDate != null)
        ? AppColors.black
        : AppColors.grey7E7E7E;
  }

  String getDateFromDateTime(bool isStartDate, OrderHistoryController orderListWatch) {
    if (isStartDate) {
      if (orderListWatch.startDate != null) {
        return dateFormatFromDateTime(orderListWatch.isDatePickerVisible ? orderListWatch.tempDate : orderListWatch.startDate, 'dd/MM/yyyy');
      } else {
        return 'Start Date';
      }
    } else {
      if (orderListWatch.endDate != null) {
        return dateFormatFromDateTime(orderListWatch.isDatePickerVisible ? orderListWatch.tempDate : orderListWatch.endDate, 'dd/MM/yyyy');
      } else {
        return 'End Date';
      }
    }
  }
}

/*Hero(
            tag: isStartDate ? startDateHero : endDateHero,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: InkWell(
                onTap: () {
                  if (!(!isStartDate && orderHistoryWatch.startDate == null)) {
                    orderHistoryWatch.updateIsDatePickerVisible(true);
                    orderHistoryWatch.updateTempDate(isStartDate ? orderHistoryWatch.startDate ?? DateTime.now() : orderHistoryWatch.endDate ?? DateTime.now());
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        barrierDismissible: true,
                        pageBuilder: (BuildContext context, _, __) {
                          return ShowDatePicketWidget(dateWidget: _widgetCommonSelectDate(isStartDate: isStartDate, context: context), isStartDate: isStartDate);
                        },
                      ),
                    );
                  }
                },
                child: _widgetCommonSelectDate(isStartDate: isStartDate, context: context),
              ),
            ),
          ),*/
