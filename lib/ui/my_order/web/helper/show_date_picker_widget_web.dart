import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
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
        final myOrderWatch = ref.watch(myOrderController);
        return CustomDatePicker(
          selectDateOnTap: true,
          bubbleDirection: isStartDate,
          bubbleWidth: context.width * 0.4,
          bubbleHeight: context.height * 0.5,
          initialDate: isStartDate ? myOrderWatch.startDate : myOrderWatch.endDate,
          firstDate: isStartDate ? DateTime(DateTime.now().year, DateTime.now().month - 6) : myOrderWatch.startDate,
          lastDate: DateTime.now(),
          getDateCallback: (DateTime? selectedDate, {bool? isOkPressed}) {
            if (isOkPressed ?? false) {
              myOrderWatch.updateStartEndDate(isStartDate, selectedDate);
            }
          },
          onOkTap: () {},
          onCancelTap: () {},
        );
      },
    );
  }
}
