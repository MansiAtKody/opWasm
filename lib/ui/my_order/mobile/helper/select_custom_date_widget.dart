

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/show_date_picker_widget.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SelectCustomDateWidget extends ConsumerWidget with BaseConsumerWidget {
  const SelectCustomDateWidget({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final orderListWatch = ref.watch(myOrderController);
        return SizedBox(
          height: 0.13.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.01.sh,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    title: LocalizationStrings.keySelectCustomDate.localized,
                    fontWeight: TextStyles.fwMedium,
                  ),
                  InkWell(
                    onTap: (){
                      if(orderListWatch.startDate!= null && orderListWatch.endDate!=null){
                        orderListWatch.clearStartDateEndDate();
                        orderListWatch.resetPaginationOrderList();
                        orderListWatch.orderListApi(context,isFavouriteOrders: (orderListWatch.selectedOrderTypeFilter?.type ==
                            OrderType.favourite));
                      }


                    },
                    child: CommonText(
                      title: LocalizationStrings.keyReset.localized,
                      textStyle: TextStyles.regular.copyWith(
                        color: AppColors.blue009AF1,
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Row(
                children: [
                  _widgetCommonSelectDateTappable(context, isStartDate: true),
                  SizedBox(
                    width: 20.w,
                  ),
                  _widgetCommonSelectDateTappable(context, isStartDate: false),
                  SizedBox(
                    width: 15.w,
                  ),
                  Container(
                    height:38.h,
                    width: 38.w,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: orderListWatch.startDate!= null && orderListWatch.endDate!=null?AppColors.black171717:AppColors.grey8D8C8C.withOpacity(0.5),
                    ),
                    child: InkWell(
                      onTap: () {
                        if(orderListWatch.startDate!= null && orderListWatch.endDate!=null){
                          orderListWatch.resetPaginationOrderList();
                          orderListWatch.orderListApi(context,isFavouriteOrders: (orderListWatch.selectedOrderTypeFilter?.type ==
                              OrderType.favourite));
                        }


                      },
                      child: CommonSVG(
                        strIcon: AppAssets.svgRightArrow,
                        svgColor:orderListWatch.startDate!= null && orderListWatch.endDate!=null?AppColors.white:AppColors.black.withOpacity(0.5),
                      ).paddingAll(10.w),
                    ),
                  ),

                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 20.w),
        );
      },
    );
  }

  Widget _widgetCommonSelectDateTappable(BuildContext context, {required bool isStartDate}) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderListWatch = ref.watch(myOrderController);
        return Expanded(
          child: Opacity(
            opacity: !isStartDate && orderListWatch.startDate == null ? 0.4 : 1,
            child: Hero(
              tag: isStartDate ? startDateHero : endDateHero,
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: InkWell(
                  onTap: () {
                    if (!(!isStartDate && orderListWatch.startDate == null)) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: true,
                          transitionDuration: const Duration(milliseconds: 100),
                          reverseTransitionDuration: const Duration(milliseconds: 100),
                          pageBuilder: (BuildContext context, _, __) {
                            return ShowDatePicketWidget(
                              dateWidget: _widgetCommonSelectDate(isStartDate: isStartDate, context: context),
                              isStartDate: isStartDate,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: _widgetCommonSelectDate(isStartDate: isStartDate, context: context),
                ),
              ),
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
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
        ? AppColors.blue009AF1
        : AppColors.grey7E7E7E
        : (orderListWatch.endDate != null)
        ? AppColors.blue009AF1
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
}
