import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';

class LeftButtonsWidget extends ConsumerWidget with BaseConsumerWidget {
  const LeftButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///Pause and return
        SlideUpTransition(
          delay: 50,
          child: CommonButton(
            height: 75.h,
            onTap: () {},
            buttonEnabledColor: AppColors.clrF7F7FC,
            isButtonEnabled: true,
            buttonText: LocalizationStrings.keyPauseAndReturn.localized,
            buttonTextStyle: TextStyles.regular.copyWith(
              fontSize: 16.sp,
              color: AppColors.black171717,
            ),
          ).paddingOnly(bottom: 30.h, top: 70.h),
        ),

        ///Go to charging pile
        SlideUpTransition(
          delay: 100,
          child: CommonButton(
            height: 75.h,
            onTap: () {},
            buttonEnabledColor: AppColors.clrF7F7FC,
            isButtonEnabled: true,
            buttonText: LocalizationStrings.keyGoToChargingPile.localized,
            buttonTextStyle: TextStyles.regular.copyWith(
              fontSize: 16.sp,
              color: AppColors.black171717,
            ),
          ).paddingOnly(bottom: 30.h),
        ),

        ///Intermission
        SlideUpTransition(
          delay: 150,
          child: CommonButton(
            height: 75.h,
            onTap: () {},
            buttonEnabledColor: AppColors.clrF7F7FC,
            isButtonEnabled: true,
            buttonText: LocalizationStrings.keyIntermission.localized,
            buttonTextStyle: TextStyles.regular.copyWith(
              fontSize: 16.sp,
              color: AppColors.black171717,
            ),
          ).paddingOnly(bottom: 30.h),
        ),

        ///Map
        SlideUpTransition(
          delay: 200,
          child: CommonButton(
            height: 75.h,
            onTap: () {
              ref.read(navigationStackProvider).push(const NavigationStackItem.map());
            },
            buttonEnabledColor: AppColors.clrF7F7FC,
            isButtonEnabled: true,
            buttonText: LocalizationStrings.keyMap.localized,
            buttonTextStyle: TextStyles.regular.copyWith(
              fontSize: 16.sp,
              color: AppColors.black171717,
            ),
          ).paddingOnly(bottom: 40.h),
        )
      ],
    );
  }
}
