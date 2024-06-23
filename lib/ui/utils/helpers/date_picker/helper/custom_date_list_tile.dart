import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/calendar_controller.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';

class CustomDateListTile extends ConsumerWidget with BaseConsumerWidget {
  final DateTime? currentDate;
  final bool selectDateOnTap;
  final Function(DateTime? selectedDate, {bool? isOkPressed})? getDateCallback;

  const CustomDateListTile({
    super.key,
    this.selectDateOnTap = false,
    this.getDateCallback,
    required this.currentDate,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final calendarWatch = ref.watch(calendarController);
    bool isDateSelected = (calendarWatch.selectedDate.day == currentDate?.day) && (calendarWatch.selectedDate.month == currentDate?.month) && (calendarWatch.selectedDate.year == currentDate?.year);
    return InkWell(
      onTap: () {
        if (currentDate != null) {
          calendarWatch.updateSelectedDate(selectedDate: currentDate!);
          if (selectDateOnTap && calendarWatch.isDateAvailable(currentDate!)) {
            getDateCallback?.call(currentDate);
          }
        }
      },
      child: Opacity(
        opacity: calendarWatch.isDateAvailable(currentDate) ? 1 : 0.4,
        child: Container(
          alignment: Alignment.center,
          height: 50.h,
          width: 50.h,
          decoration: isDateSelected ? const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle) : null,
          child: currentDate != null
              ? Text(
                  currentDate!.day.toString(),
                  style: TextStyles.medium.copyWith(fontSize: 16.5.sp, color: isDateSelected ? AppColors.white : AppColors.black),
                )
              : const Offstage(),
        ),
      ),
    );
  }
}
