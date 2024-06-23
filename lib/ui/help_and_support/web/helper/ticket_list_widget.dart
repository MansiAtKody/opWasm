import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/help_and_support/web/helper/ticket_widget_web.dart';
import 'package:kody_operator/ui/utils/anim/hover_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

///Display Tickets List
class TicketListWidget extends StatelessWidget with BaseStatelessWidget {
  const TicketListWidget({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final helpAndSupportWatch = ref.watch(helpAndSupportController);
        return SizedBox(
          height: context.height * 0.8,
          child: ListView(
            controller: helpAndSupportWatch.scrollController,
            children: [
              Column(
                children: [
                 ... List.generate(
                helpAndSupportWatch.tickets.length,
                      /// Navigate to chat Screen
                          (index) {
                        return HoverAnimation(
                          transformSize: helpAndSupportWatch.selectedTicket == helpAndSupportWatch.tickets[index] ? 1 : 1.01,
                          child: Transform.scale(
                            scale: helpAndSupportWatch.selectedTicket !=
                                helpAndSupportWatch.tickets[index] ? 0.95 : 1,
                            child: InkWell(
                              onTap: () async{
                                await helpAndSupportWatch.getTicketDetail(context: context,uuid: helpAndSupportWatch.tickets[index].uuid ?? '');
                                helpAndSupportWatch.updateSelectedTickets(ref,ticketId:helpAndSupportWatch.tickets[index].id ?? 0);
                              },

                              ///Common Ticket Widget
                              child: TicketWidgetWeb(
                                ticket: helpAndSupportWatch.tickets[index],
                              ),
                            ).paddingOnly(bottom: 20.h),
                          ),
                        );
                      }
                  ),
                  Visibility(
                      visible: helpAndSupportWatch.ticketListState.isLoadMore,
                      child:Center(child: const  CircularProgressIndicator(color: AppColors.blue009AF1,).paddingOnly(top:18.h))),
                ],
              )
            ]
          ).paddingOnly(left: 10.w, bottom: 20.h),
        );
      },
    );
  }
}
