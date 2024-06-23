import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/profile/web/helper/change_email_dialog.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';


///Change Email Button
class ChangeEmailButton extends ConsumerWidget with BaseConsumerWidget {
  const ChangeEmailButton({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showCommonWebDialog(
          context: context,
          barrierDismissible: true,
          dialogBody: const ChangeEmailDialog(),
        );
      },
      child: Text(
        LocalizationStrings.keyChangeEmail.localized,
        style: TextStyles.regular.copyWith(
          fontSize: 16.sp,
          decorationColor: AppColors.blue009AF1,
          decoration: TextDecoration.underline,
          color: AppColors.blue009AF1,
        ),
      ),
    );
  }
}
