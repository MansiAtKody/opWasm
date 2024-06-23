import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/calendar_controller.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/utils/anim/animation_extension.dart';


class CustomDateYearList extends ConsumerStatefulWidget {
  const CustomDateYearList({super.key});

  @override
  ConsumerState<CustomDateYearList> createState() => _CustomDateMonthListState();
}

class _CustomDateMonthListState extends ConsumerState<CustomDateYearList> with SingleTickerProviderStateMixin, BaseConsumerStatefulWidget {
  AnimationController? _animController;
  late Animation<Offset> _offSetAnim;
  ScrollController yearScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    if (_animController != null) {
      final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animController!);
      _offSetAnim = Tween<Offset>(begin: const Offset(0, -0.1), end: const Offset(0, 0)).animate(curve);
      if (mounted) {
        if (!(_animController?.isDisposed ?? false)) {
          _animController?.forward();
        }
      }
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final calendarWatch = ref.watch(calendarController);
      double jumpTo = (yearScrollController.position.maxScrollExtent / double.parse((calendarWatch.numOfYears.length).toString())) *
          (double.parse((calendarWatch.numOfYears.indexWhere((element) => (element.year == calendarWatch.selectedYear?.year))).toString()));
      yearScrollController.jumpTo((jumpTo));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animController?.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    final calendarWatch = ref.watch(calendarController);
    return _animController != null
        ? FadeTransition(
            opacity: _animController!,
            child: SlideTransition(
              position: _offSetAnim,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: calendarWatch.numOfYears.length,
                controller: yearScrollController,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      calendarWatch.updateDisplayDate(displayDate: DateTime(calendarWatch.numOfYears[index].year));
                      calendarWatch.updateWidgetDisplayed(widgetDisplayed: WidgetDisplayed.month);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: calendarWatch.selectedYear == calendarWatch.numOfYears[index] ? AppColors.blue : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        calendarWatch.numOfYears[index].year.toString(),
                        style: TextStyles.medium.copyWith(fontSize: 16.5.sp, color: calendarWatch.selectedYear == calendarWatch.numOfYears[index] ? AppColors.white : AppColors.black),
                      ),
                    ).paddingSymmetric(horizontal: 10.w, vertical: 8.h),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 0.08.sh),
              ),
            ),
          )
        : const Offstage();
  }
}
