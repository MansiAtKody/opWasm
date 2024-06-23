import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/chat_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/help_and_support/mobile/helper/chat_widget.dart';
import 'package:kody_operator/ui/help_and_support/web/helper/ticket_chat_top_widget.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';

///Ticket Chat Widget
class TicketChatWidget extends StatelessWidget {
  final TicketResponseModel? selectedTicket;

  const TicketChatWidget({
    super.key,
    required this.selectedTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final helpAndSupportWatch = ref.watch(helpAndSupportController);
        return FadeBoxTransition(
          child: Container(
            height: context.height * 0.8,
            color: AppColors.transparent,
            child: CommonCard(
              color: AppColors.whiteF7F7FC,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (helpAndSupportWatch.ticketDetailState.isLoading)...{
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  } else ...{
                    TicketChatTopWidget(
                      elevation: 0,
                      ticket: selectedTicket,
                    ),
                    const Divider()
                        .paddingOnly(right: 20.w, left: 20.w, bottom: 30.h),
                    ///Displays Chat Widget
                    helpAndSupportWatch.ticketDetailState.success?.data?.acknowledgeComment != null
                        || helpAndSupportWatch.ticketDetailState.success?.data?.resolveComment != null
                        ? Expanded(
                      child: helpAndSupportWatch.ticketDetailState.isLoading
                          ? const Expanded(
                            child: Center(
                                child: CircularProgressIndicator(),
                              ),
                          )
                          : Consumer(
                              builder: (BuildContext context,WidgetRef ref,Widget? child) {
                                return ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  primary: true,
                                  itemBuilder: (context, index) {
                                    return ChatCard(
                                      chat: ChatModel(
                                          message:
                                          helpAndSupportWatch.ticketDetailState.success?.data?.resolveComment
                                              ?? helpAndSupportWatch.ticketDetailState.success?.data?.acknowledgeComment
                                              ?? '',
                                          datetime: DateTime.fromMillisecondsSinceEpoch(selectedTicket?.resolvedDate ??
                                              selectedTicket?.acknowledgedDate ??
                                              selectedTicket?.createdAt),
                                      ),
                                    ).paddingOnly(bottom: 20.h);
                                  },
                                );
                              },
                            ),
                    ) : const Spacer(),
                  }
                ],
              ).paddingSymmetric(horizontal: 10.w, vertical: 15.h),
            ),
          ),
        );
      },
    );
  }
}
