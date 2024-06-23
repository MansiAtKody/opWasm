import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/ticket_chat_controller.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class TicketChatWeb extends ConsumerStatefulWidget {
  const TicketChatWeb({Key? key, required this.ticketModel}) : super(key: key);

  final TicketResponseModel? ticketModel;

  @override
  ConsumerState<TicketChatWeb> createState() => _TicketChatWebState();
}

class _TicketChatWebState extends ConsumerState<TicketChatWeb> with BaseConsumerStatefulWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final ticketChatWatch = ref.read(ticketChatController);
      ticketChatWatch.disposeController();
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold();
    // return Scaffold(
    //   appBar: const CommonAppBarWeb(),
    //   body: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [const TopRightButton().paddingOnly(top: 50.h, right: 100.w)],
    //       ),
    //       Expanded(
    //         child: SingleChildScrollView(
    //           child: CommonCard(
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 TicketWidget(
    //                   elevation: 0,
    //                   ticket: widget.ticketModel,
    //                 ),
    //                 const Divider().paddingOnly(right: 20.w, left: 20.w, bottom: 30.h),
    //
    //                 ///Displays Chat Widget
    //                 ListView.builder(
    //                   itemCount: 1,
    //                   shrinkWrap: true,
    //                   physics: const BouncingScrollPhysics(),
    //                   primary: true,
    //                   itemBuilder: (context, index) {
    //                     ///Common Chat Widget
    //                     return ChatCard(
    //                       chat: ChatModel(message: 'Support Request is Recieved.\nOur Executive will reach to you in a brief time.', datetime: DateTime.now()),
    //                     ).paddingOnly(bottom: 20.h);
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
    //         ),
    //       ),
    //
    //       ///Bottom Widget
    //        const TicketChatBottomWidget(),
    //     ],
    //   ),
    // );
  }
}
