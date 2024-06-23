import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/custom_date_picker.dart';

class ShowDatePicketWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  final bool isStartDate;

  const ShowDatePicketWidgetWeb({super.key, required this.isStartDate});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderHistoryWatch = ref.watch(orderHistoryController);
        return CustomDatePicker(
          selectDateOnTap: true,
          bubbleDirection: isStartDate,
          bubbleWidth: context.width * 0.4,
          bubbleHeight: context.height * 0.5,
          initialDate: isStartDate ? orderHistoryWatch.startDate : orderHistoryWatch.endDate,
          firstDate: isStartDate ? DateTime(DateTime.now().year, DateTime.now().month - 1) : orderHistoryWatch.startDate,
          lastDate: DateTime.now(),
          getDateCallback: (DateTime? selectedDate, {bool? isOkPressed}) {
            if (isOkPressed ?? false) {
              orderHistoryWatch.updateStartEndDate(isStartDate, selectedDate);
            } else {
              orderHistoryWatch.updateTempDate(selectedDate);
            }
          },
          onOkTap: () {
            orderHistoryWatch.updateIsDatePickerVisible(false);
          },
          onCancelTap: () {
            orderHistoryWatch.updateIsDatePickerVisible(false);
          },
        );
      },
    );
  }
}
