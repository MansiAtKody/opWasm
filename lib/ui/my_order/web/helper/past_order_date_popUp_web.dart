

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/web/helper/show_date_picker_widget_web.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/common_dialog_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/calendar_controller.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class PastOrderDatePopUp extends StatelessWidget with BaseStatelessWidget {
  const PastOrderDatePopUp({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.expand(
        width: context.width * 0.4,
        height: context.height * 0.2,
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      color: AppColors.white,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        PopupMenuItem<SampleItem>(
          padding: EdgeInsets.zero,
          value: SampleItem.itemOne,
          child: Container(
              color: AppColors.white,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final orderListWatch = ref.watch(myOrderController);
                  final calendarWatch = ref.watch(calendarController);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            title: LocalizationStrings.keySelectCustomDate.localized,
                            textStyle: TextStyles.medium.copyWith(
                              color: AppColors.black272727,
                              fontSize: 20.sp,
                            ),
                          ),
                          InkWell(
                            onTap:(){
                              calendarWatch.notifyListeners();
                              orderListWatch.clearStartDateEndDate();
                              orderListWatch.resetPaginationOrderList();
                              orderListWatch.orderListApi(context,isFavouriteOrders: (orderListWatch.selectedOrderTypeFilter?.type ==
                                  OrderType.favourite));
                              Navigator.of(context).pop();

                            },
                            child: CommonText(
                              title: LocalizationStrings.keyClearAll.localized,
                              textStyle: TextStyles.medium.copyWith(
                                color: AppColors.redE80202,
                                fontSize: 18.sp,
                              ),
                            ),
                          )
                        ],
                      ).paddingOnly(bottom: 25.h),
                      Row(
                        children: [
                          _widgetCommonSelectDateTappable(context, isStartDate: true),
                          SizedBox(
                            width: 20.w,
                          ),
                          _widgetCommonSelectDateTappable(context, isStartDate: false),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            height: 0.05.sh,
                            width: 0.05.sh,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.black171717,
                            ),
                            child: InkWell(
                              onTap: () {
                                orderListWatch.clearFilter();
                              },
                              child: const CommonSVG(
                                strIcon: AppAssets.svgRightArrow,
                                svgColor: AppColors.white,
                              ).paddingAll(10.w),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20.w, vertical: 15.h);
                },
              )),
        ),
      ],
      offset: Offset(-1.w, 60.h),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        height: 50.h,
        width: 50.w,
        child: const Icon(
          Icons.calendar_today_outlined,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget _widgetCommonSelectDateTappable(BuildContext context, {required bool isStartDate}) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderListWatch = ref.watch(myOrderController);
        return Expanded(
          child: Opacity(
            opacity: !isStartDate && orderListWatch.startDate == null ? 0.4 : 1,
            // child: ShowDatePicketWidgetWeb(
            //   dateWidget: _widgetCommonSelectDate(isStartDate: isStartDate, context: context),
            //   isStartDate: isStartDate,
            // ),
            child: InkWell(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CommonDialogWidget(
                      child: ShowDatePicketWidgetWeb(isStartDate: isStartDate),
                    );
                  },
                );
              },
              child: _widgetCommonSelectDate(isStartDate: isStartDate, context: context),
            ),
          ),
        );
      },
    );
  }

  Widget _widgetCommonSelectDate({required bool isStartDate, required BuildContext context}) {
    return Consumer(builder: (context, ref, child) {
      final orderListWatch = ref.watch(myOrderController);
      return Container(
        height: 0.07.sh,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.lightPinkF7F7FC),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: getDateTextIconColor(isStartDate, orderListWatch),
            ),
            SizedBox(
              width: 10.w,
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: CommonText(
                title: getDateFromDateTime(isStartDate, orderListWatch),
                clrfont: getDateTextIconColor(isStartDate, orderListWatch),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 5.w),
      );
    });
  }

  Color getDateTextIconColor(bool isStartDate, MyOrderController orderListWatch) {
    return isStartDate
        ? (orderListWatch.startDate != null)
            ? AppColors.black
            : AppColors.grey7E7E7E
        : (orderListWatch.endDate != null)
            ? AppColors.black
            : AppColors.grey7E7E7E;
  }

  String getDateFromDateTime(bool isStartDate, MyOrderController orderListWatch) {
    if (isStartDate) {
      if (orderListWatch.startDate != null) {
        return dateFormatFromDateTime(orderListWatch.startDate, 'dd/MM/yyyy');
      } else {
        return LocalizationStrings.keyStartDate.localized;
      }
    } else {
      if (orderListWatch.endDate != null) {
        return dateFormatFromDateTime(orderListWatch.endDate, 'dd/MM/yyyy');
      } else {
        return LocalizationStrings.keyEndDate.localized;
      }
    }
  }

  openDatePicker({required BuildContext context, required bool isStartDate, required DateTime? initialDate, required DateTime? firstDate, required DateTime? lastDate}) async {
    final datePick = await showDatePicker(context: context, initialDate: initialDate ?? DateTime.now(), firstDate: firstDate ?? DateTime(7), lastDate: lastDate ?? DateTime.now());
    return datePick;
  }
}
