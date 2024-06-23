import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';

class LeftButtonsWidgetServices extends ConsumerWidget with BaseConsumerWidget{
  const LeftButtonsWidgetServices({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        ///Desk Cleaning
        CommonButton(
          height: 123.h,
          width: 407.w,
          onTap: () {
            ref.read(navigationStackProvider).push(const NavigationStackItem.deskcleaning());
          },
          buttonText: LocalizationStrings.keyDeskCleaning.localized,
          buttonTextStyle: TextStyles.regular.copyWith(
            fontSize: 25.sp,
            color: AppColors.grey7D7D7D,
          ),
        ).paddingOnly(bottom: 40.h),

        ///Create New Task
        CommonButton(
          height: 123.h,
          width: 407.w,
          onTap: () {},
          buttonText: LocalizationStrings.keyCreateNewTask.localized,
          buttonTextStyle: TextStyles.regular.copyWith(
            fontSize: 25.sp,
            color: AppColors.grey7D7D7D,
          ),
        ).paddingOnly(bottom: 40.h)
      ],
    );
  }
}
