import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/calendar_controller.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';

class PreviousNextButtonWidget extends StatelessWidget with BaseStatelessWidget {
  const PreviousNextButtonWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final calendarWatch = ref.watch(calendarController);
        return Row(
          children: [
            Opacity(
              opacity: calendarWatch.isPreviousButtonVisible() ? 1 : 0,
              child: InkWell(
                onTap: () {
                  calendarWatch.goToPreviousMonth();
                },
                child:  const Icon(
                  CupertinoIcons.left_chevron,
                  color: AppColors.blue009AF1,
                ),
              ).paddingAll(5.w),
            ),
            SizedBox(width: 10.w),
            Opacity(
              opacity: calendarWatch.isForwardButtonVisible() ? 1 : 0,
              child: InkWell(
                onTap: () {
                  calendarWatch.goToNextMonth();
                },
                child: const Icon(
                  CupertinoIcons.right_chevron,
                  color: AppColors.blue009AF1,
                ),
              ).paddingAll(5.w),
            ),
          ],
        );
      },
    );
  }
}
