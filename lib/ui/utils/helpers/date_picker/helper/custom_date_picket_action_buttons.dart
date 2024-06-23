import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/calendar_controller.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CustomDatePicketActionButtons extends ConsumerWidget with BaseConsumerWidget {
  final GestureTapCallback? onCancelTap;
  final GestureTapCallback? onOkTap;
  final Function(DateTime? selectedDate, {bool? isOkPressed}) getDateCallback;

  const CustomDatePicketActionButtons({
    super.key,
    this.onCancelTap,
    this.onOkTap,
    required this.getDateCallback,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextButton(
          onPressed: () {
            if (onCancelTap != null) {
              getDateCallback(null);
              onCancelTap?.call();
            }
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyles.medium.copyWith(fontSize: 14.sp, color: AppColors.blue),
          ),
        ),
        TextButton(
          onPressed: () {
            if (onOkTap != null) {
              getDateCallback(ref.read(calendarController).selectedDate, isOkPressed: true);
              onOkTap?.call();
            }
            Navigator.pop(context);
          },
          child: Text(
            LocalizationStrings.keyOk.localized,
            style: TextStyles.medium.copyWith(fontSize: 14.sp, color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
