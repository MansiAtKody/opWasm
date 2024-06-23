import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';

class HelpAndSupportBottomWidget extends StatelessWidget
    with BaseStatelessWidget {
  const HelpAndSupportBottomWidget({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context) {
    return SlideUpTransition(
      delay: 100,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final helpAndSupportWatch = ref.watch(helpAndSupportController);
          ///Create Ticket Button
          return CommonButtonMobile(
            absorbing: helpAndSupportWatch.ticketDetailState.isLoading,
            width: double.infinity,
            buttonText: LocalizationStrings.keyCreateTicket.localized,
            isButtonEnabled: true,
            rightIcon: const Icon(Icons.arrow_forward, color: AppColors.white),

            onTap: () {
              ref
                  .read(navigationStackProvider)
                  .push(const NavigationStackItem.createTicket());
            },
          ).paddingSymmetric(vertical: 15.h,horizontal: 20.w);
        },
      ),
    );
  }
}
