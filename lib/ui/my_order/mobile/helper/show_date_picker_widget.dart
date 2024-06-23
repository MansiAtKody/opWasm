import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/custom_date_picker.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
class ShowDatePicketWidget extends StatelessWidget with BaseStatelessWidget {
  final Widget dateWidget;
  final bool isStartDate;

  const ShowDatePicketWidget({super.key, required this.dateWidget, required this.isStartDate});

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey7E7E7E.withOpacity(0.2),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                isStartDate
                    ? Expanded(
                        flex: 2,
                        child: Hero(
                          tag: isStartDate ? startDateHero : endDateHero,
                          child: dateWidget,
                        ),
                      )
                    : const Offstage(),
                const Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                isStartDate
                    ? const Offstage()
                    : Expanded(
                        flex: 2,
                        child: Hero(
                          tag: isStartDate ? startDateHero : endDateHero,
                          child: dateWidget,
                        ),
                      ),
              ],
            ).paddingSymmetric(horizontal: 20.w),
            SizedBox(height: 20.h),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final orderListWatch = ref.watch(myOrderController);
                return CustomDatePicker(
                  selectDateOnTap: true,
                  bubbleDirection: isStartDate,
                  initialDate: isStartDate ? orderListWatch.startDate : orderListWatch.endDate,
                  firstDate: isStartDate ? DateTime(DateTime.now().year, DateTime.now().month - 6) : orderListWatch.startDate,
                  lastDate: DateTime.now(),
                  getDateCallback: (DateTime? selectedDate, {bool? isOkPressed}) {
                    if (isOkPressed ?? false) {
                      orderListWatch.updateStartEndDate(isStartDate, selectedDate);
                    }
                  },
                  onOkTap: () {
                    // orderListWatch.updateIsDatePickerVisible(false);
                  },
                  onCancelTap: () {
                    // orderListWatch.updateIsDatePickerVisible(false);
                  },
                ).paddingSymmetric(horizontal: 20.w);
              },
            ),
          ],
        ),
      ),
    );
  }
}
