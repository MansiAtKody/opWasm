import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/profile/web/helper/change_mobile_dialog.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';


///Change Email Button
class ChangeMobileNolButton extends ConsumerWidget with BaseConsumerWidget {
  const ChangeMobileNolButton({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showCommonWebDialog(
          context: context,
          barrierDismissible: true,
          dialogBody: const ChangeMobileDialog(),
        );
        // const ChangeMobileDialog();
      },
      child: Text(
        LocalizationStrings.keyChangeMobile.localized,
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
