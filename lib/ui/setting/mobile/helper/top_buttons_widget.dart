import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_right_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class TopButtonsWidget extends ConsumerWidget with BaseConsumerWidget{
  const TopButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    return Column(
      children: [
        Row(
          children: [

            /// Intermission button
            Expanded(
              flex: 4,
              child: SlideRightTransition(
                delay: 100,
                child: CommonButtonMobile(
                  height: 70.h,
                  buttonTextColor: AppColors.black171717,
                  buttonText: LocalizationStrings.keyIntermission.localized,
                  isButtonEnabled:true,
                  buttonEnabledColor: AppColors.lightPink,
                  onTap: (){},
                ),
              ),
            ),

            const Expanded(flex:1,child: SizedBox()),

            /// Go to charging button
            Expanded(
              flex: 4,
              child: SlideLeftTransition(
                delay: 100,
                child: CommonButtonMobile(
                  height: 70.h,
                  textWidget: Expanded(
                    child: CommonText(
                      title: LocalizationStrings.keyGoToChargingPile.localized,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.black171717,
                      ),
                    ).paddingSymmetric(horizontal: 20.w),
                  ),
                  isButtonEnabled:true,
                  buttonEnabledColor: AppColors.lightPink,
                  onTap: (){},
                ),
              ),
            )
          ],
        ).paddingOnly(bottom: 16.h),


        Row(
          children: [

            /// Intermission
            Expanded(
              flex: 4,
              child: SlideRightTransition(
                delay: 200,
                child: CommonButtonMobile(
                  height: 70.h,
                  buttonTextColor: AppColors.black171717,
                  buttonText: LocalizationStrings.keyPauseAndReturn.localized,
                  isButtonEnabled:true,
                  buttonEnabledColor: AppColors.lightPink,
                  onTap: (){},
                ),
              ),
            ),
            const Expanded(flex:1,child: SizedBox()),

            /// Map
            Expanded(
              flex: 4,
              child: SlideLeftTransition(
                delay: 200,
                child: CommonButtonMobile(
                  height: 70.h,
                  buttonText: LocalizationStrings.keyMap.localized,
                  isButtonEnabled:true,
                  buttonTextColor: AppColors.black171717,
                  buttonEnabledColor: AppColors.lightPink,
                  onTap: (){
                    ///Navigate
                    ref.read(navigationStackProvider).push(const NavigationStackItem.map());
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
