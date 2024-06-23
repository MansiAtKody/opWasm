import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/controller/help_and_support/ticket_chat_controller.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/chat_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/help_and_support/mobile/helper/chat_widget.dart';
import 'package:kody_operator/ui/help_and_support/mobile/helper/ticket_widget.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';

class TicketChatMobile extends ConsumerStatefulWidget {
  const TicketChatMobile({required this.ticketModel, Key? key}) : super(key: key);

  final TicketResponseModel? ticketModel;

  @override
  ConsumerState<TicketChatMobile> createState() => _TicketChatMobileState();
}

class _TicketChatMobileState extends ConsumerState<TicketChatMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async{
      final ticketChatWatch = ref.read(ticketChatController);
      final helpAndSupportWatch = ref.read(helpAndSupportController);
      await helpAndSupportWatch.getTicketDetail(context: context,uuid: widget.ticketModel?.uuid);
      ticketChatWatch.disposeController(isNotify:true);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(navigationStackProvider).popUntil(const NavigationStackItem.helpAndSupport());
        return false;
      },
      child: GestureDetector(
        onTap: (){
          hideKeyboard(context);
        },
        child: Scaffold(
          appBar: CommonAppBar(
            title: LocalizationStrings.keySupportAndHelp.localized,
            isLeadingEnable: true,
            isDrawerEnable: false,
          ),
          backgroundColor: AppColors.white,
          body: _bodyWidget(),
        ),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final ticketChatWatch = ref.watch(ticketChatController);
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: helpAndSupportWatch.ticketDetailState.isLoading ? const DialogProgressBar(isLoading: true) : CommonCard(
            child: SingleChildScrollView(
              controller: ticketChatWatch.scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ///Ticket detail widget
                  TicketWidget(
                    elevation: 0,
                    ticket: helpAndSupportWatch.ticketDetailState.success?.data,
                  ),


                  const Divider().paddingOnly(right: 20.w, left: 20.w, bottom: 25.h),

                  ///Displays Chat Widget
                  helpAndSupportWatch.ticketDetailState.success?.data?.acknowledgeComment != null || helpAndSupportWatch.ticketDetailState.success?.data?.resolveComment != null ? AnimatedList(
                    key: ticketChatWatch.listKey,
                    initialItemCount: 1,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    primary: true,
                    itemBuilder: (context, index, Animation<double> animation) {
                      ///Common Chat Widget
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0.2),
                          end: const Offset(0, 0),
                        ).animate(animation),
                        child: ChatCard(
                          chat: ChatModel(message: helpAndSupportWatch.ticketDetailState.success?.data?.resolveComment ?? helpAndSupportWatch.ticketDetailState.success?.data?.acknowledgeComment ?? '', datetime: DateTime.fromMillisecondsSinceEpoch(widget.ticketModel?.resolvedDate ?? widget.ticketModel?.acknowledgedDate ?? widget.ticketModel?.createdAt ?? 0))
                        ).paddingOnly(bottom: 20.h),
                      );
                    },
                  ) : const Offstage()
                ],
              ),
            ),
          ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
        ),

        ///Bottom Widget
        // const TicketChatBottomWidget(),
      ],
    );
  }
}
