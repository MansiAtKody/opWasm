import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/calendar_controller.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/helper/custom_date_day_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/helper/custom_date_month_list.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/helper/custom_date_picket_action_buttons.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/helper/custom_date_year_list.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/helper/previous_next_button_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_bubble_widgets.dart';

class CustomDatePicker extends ConsumerStatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final GestureTapCallback? onCancelTap;
  final GestureTapCallback? onOkTap;
  final bool selectDateOnTap;
  final Function(DateTime? selectedDate, {bool? isOkPressed}) getDateCallback;
  final bool? bubbleDirection;
  final double? bubbleHeight;
  final double? bubbleWidth;

  const CustomDatePicker({
    super.key,
    this.selectDateOnTap = false,
    this.bubbleDirection,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onCancelTap,
    this.onOkTap,
    this.bubbleHeight,
    this.bubbleWidth,
    required this.getDateCallback,
  });

  @override
  ConsumerState<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends ConsumerState<CustomDatePicker> with SingleTickerProviderStateMixin, BaseConsumerStatefulWidget {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final calendarWatch = ref.watch(calendarController);
      calendarWatch.disposeController(context, this, initialDate: widget.initialDate, firstDate: (widget.firstDate ?? DateTime(1900)), lastDate: widget.lastDate ?? DateTime(DateTime.now().year + 50));
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonBubbleWidget(
      height: widget.bubbleHeight ?? 0.40.sh,
      width: widget.bubbleWidth,
      isBubbleFromLeft: widget.bubbleDirection ?? true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    final calendarWatch = ref.watch(calendarController);
                    return Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              calendarWatch.updateWidgetDisplayed();
                            },
                            child: calendarWatch.widgetDisplayed == WidgetDisplayed.day
                                ? Text(
                                    '${calendarWatch.getMonth(ref.watch(calendarController).displayDate.month)} ${ref.watch(calendarController).displayDate.year}',
                                    style: TextStyles.bold.copyWith(fontSize: 16.5.sp, color: AppColors.black),
                                  )
                                : calendarWatch.widgetDisplayed == WidgetDisplayed.month
                                    ? Text(
                                        '${ref.watch(calendarController).displayDate.year}',
                                        style: TextStyles.bold.copyWith(fontSize: 16.5.sp, color: AppColors.black),
                                      )
                                    : Text(
                                        'Select Year',
                                        style: TextStyles.bold.copyWith(fontSize: 16.5.sp, color: AppColors.black),
                                      ),
                          ),
                        ),
                        calendarWatch.widgetDisplayed == WidgetDisplayed.day ? const PreviousNextButtonWidget() : const Offstage(),
                      ],
                    );
                  },
                ).paddingOnly(left: 5.w),
                SizedBox(height: 0.02.sh),
                Expanded(
                  child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final calendarWatch = ref.watch(calendarController);
                      switch (calendarWatch.widgetDisplayed) {
                        case WidgetDisplayed.day:
                          return CustomDateDayWidget(selectDateOnTap: widget.selectDateOnTap, getDateCallback: widget.getDateCallback);
                        case WidgetDisplayed.month:
                          return const CustomDateMonthList();
                        case WidgetDisplayed.year:
                          return const CustomDateYearList();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final calendarWatch = ref.watch(calendarController);
              if (calendarWatch.widgetDisplayed != WidgetDisplayed.day) {
                return const Offstage();
              }
              return CustomDatePicketActionButtons(getDateCallback: widget.getDateCallback, onCancelTap: widget.onCancelTap, onOkTap: widget.onOkTap).paddingOnly(bottom: 0.01.sh);
            },
          )
        ],
      ).paddingOnly(left: 10.w, right: 10.w),
    );
  }
}
