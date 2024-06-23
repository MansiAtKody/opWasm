// ignore_for_file: use_build_context_synchronously
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/help_and_support/web/helper/no_tickets_widget.dart';
import 'package:kody_operator/ui/help_and_support/web/helper/ticket_chat_widget.dart';
import 'package:kody_operator/ui/help_and_support/web/helper/ticket_list_widget.dart';
import 'package:kody_operator/ui/help_and_support/web/helper/top_right_button.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class HelpAndSupportWeb extends ConsumerStatefulWidget {
  final String? ticketId;

  const HelpAndSupportWeb({Key? key, this.ticketId}) : super(key: key);

  @override
  ConsumerState<HelpAndSupportWeb> createState() => _HelpAndSupportWebState();
}

class _HelpAndSupportWebState extends ConsumerState<HelpAndSupportWeb>
    with
        BaseConsumerStatefulWidget,
        TickerProviderStateMixin,
        BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final helpAndSupportWatch = ref.read(helpAndSupportController);
      helpAndSupportWatch.disposeController(isNotify: true);
      await helpAndSupportWatch.getTicketList(context: context);
      if (widget.ticketId != null && widget.ticketId?.trim() != "") {
        await helpAndSupportWatch.getTicketDetail(
            context: context, uuid: widget.ticketId);
      }
      _getTicketListApi();
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Column(
              children: [
                /// support and help text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonText(
                      title: LocalizationStrings
                          .keySupportAndHelp.localized,
                      textStyle: TextStyles.regular.copyWith(
                          fontSize: 24.sp, color: AppColors.black),
                    ),

                    /// Top Right Button
                    const TopRightButton()
                  ],
                ).paddingSymmetric(horizontal: context.width * 0.03),
                if (helpAndSupportWatch.ticketListState.isLoading) ...{
                  Column(
                    children: [
                      SizedBox(
                        height: context.height * 0.25,
                        width: double.infinity,
                      ),
                      const CircularProgressIndicator(),
                      SizedBox(
                        height: context.height * 0.25,
                        width: double.infinity,
                      ),
                    ],
                  ),
                } else ...{
                  if (helpAndSupportWatch.tickets.isNotEmpty) ...{
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Left Ticket List Widget
                          const Expanded(
                              flex: 5, child: TicketListWidget()),

                          /// Right Chat Widget
                          Expanded(
                            flex: 7,
                            child: helpAndSupportWatch.selectedTicket ==
                                null
                                ? const EmptyStateWidget(
                              title: 'Ticket is not Selected',
                            )
                                : TicketChatWidget(
                              selectedTicket: helpAndSupportWatch
                                  .selectedTicket,
                            ),
                          )
                        ],
                      ).paddingSymmetric(
                          horizontal: context.width * 0.02,
                          vertical: 20.h),
                    )
                  } else ...{
                    /// No Tickets Available Widget
                    const NoTicketsAvailable(),
                  }
                }
              ],
            ).paddingSymmetric(vertical: 20.h),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 30.w,vertical: 20.h);
  }

  Future<void> _getTicketListApi() async {
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    helpAndSupportWatch.scrollController.addListener(
      () {
        if (mounted) {
          if (helpAndSupportWatch.scrollController.position.pixels >=
              (helpAndSupportWatch.scrollController.position.maxScrollExtent)) {
            if (helpAndSupportWatch.ticketListState.success?.hasNextPage ??
                false) {
              helpAndSupportWatch.updatePageNumber();
              helpAndSupportWatch.getTicketList(context: context);
            }
          }
        }
      },
    );
  }
}
