import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/calendar_controller.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';

class DayNameList extends ConsumerWidget with BaseConsumerWidget {
  const DayNameList({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final calendarWatch = ref.watch(calendarController);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        calendarWatch.day.length,
        (index) => Container(
          alignment: Alignment.center,
          child: Text(
            calendarWatch.day[index].weekDayName.substring(0, 2),
            style: TextStyles.medium.copyWith(fontSize: 16.5.sp, color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
