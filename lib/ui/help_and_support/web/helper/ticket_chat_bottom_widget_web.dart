import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/ticket_chat_controller.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class TicketChatBottomWidgetWeb extends ConsumerWidget with BaseConsumerWidget {
  const TicketChatBottomWidgetWeb({
    required this.ticket,
    super.key,
  });

  final TicketResponseModel? ticket;

  ///Build Override
  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final ticketChatWatch = ref.watch(ticketChatController);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
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
            fieldTextStyle: TextStyles.regular.copyWith(
              fontSize: 14.sp,
              color: AppColors.chatCardTextColor
            ),
            contentPadding: EdgeInsets.only(
                left: 22.w, top: 25.h, bottom: 25.h, right: 22.w),
            placeholderText: LocalizationStrings.keyTypeHere.localized,
            hintText: LocalizationStrings.keyTypeHere.localized,
            onTap: () {},
          ).paddingSymmetric(horizontal: 8.w),
        ),

        ///Send Button
        InkWell(
          onTap: () {
            // ticketChatWatch.sendChat(ref.watch(helpAndSupportController));
          },
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.chatCardBgColor,
            ),
            child: const Center(
              child: CommonSVG(
                strIcon: AppAssets.svgTicketChatSend,
              ),
            ),
          ).paddingSymmetric(horizontal: 10.w,vertical: 20.h),
        ).paddingOnly(right: 8.w),
      ],
    );
  }
}
