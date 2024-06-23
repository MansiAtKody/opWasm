import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/ticket_chat_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class TicketChatBottomWidget extends ConsumerWidget with BaseConsumerWidget {
  const TicketChatBottomWidget({
    super.key,
  });

  ///Build Override
  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final ticketChatWatch = ref.watch(ticketChatController);
    return CommonCard(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: context.width * 0.7,
            padding: EdgeInsets.symmetric(vertical: 10.h),

            ///Chat Input Field
            child: CommonInputFormField(
              textEditingController: ticketChatWatch.chatInputController,
              backgroundColor: AppColors.chatCardBgColor,
              borderRadius: BorderRadius.circular(58.r),
              borderColor: AppColors.transparent,
              hasLabel: false,
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (value) {
                // ticketChatWatch.sendChat(ref.watch(helpAndSupportController));
              },
              contentPadding:
                  EdgeInsets.only(left: 22.w, top: 25.h, bottom: 25.h),
              placeholderText: LocalizationStrings.keyTypeHere.localized,
              hintText: LocalizationStrings.keyTypeHere.localized,
              fieldTextStyle: TextStyles.regular.copyWith(
                fontSize: 14.sp,
                color: AppColors.chatCardTextColor,
              ),
              onTap: () {
                // ticketChatWatch.scrollToBottom(duration: 300);
              },
            ),
          ),

          ///Send Button
          InkWell(
            onTap: () {
              // ticketChatWatch.sendChat(ref.watch(helpAndSupportController));
            },
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: const Center(
                child: CommonSVG(
                  strIcon: AppAssets.svgTicketChatSend,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
