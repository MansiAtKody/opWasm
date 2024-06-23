import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/help_and_support/mobile/helper/help_and_support_appbar_actions.dart';
import 'package:kody_operator/ui/help_and_support/mobile/helper/help_and_support_bottom_widget.dart';
import 'package:kody_operator/ui/help_and_support/mobile/helper/ticket_widget.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/blur_background.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class HelpAndSupportMobile extends ConsumerStatefulWidget {
  const HelpAndSupportMobile({super.key});

  @override
  ConsumerState<HelpAndSupportMobile> createState() =>
      _HelpAndSupportMobileState();
}

class _HelpAndSupportMobileState extends ConsumerState<HelpAndSupportMobile>
    with BaseDrawerPageWidgetMobile {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final helpAndSupportWatch = ref.read(helpAndSupportController);
      helpAndSupportWatch.disposeController(isNotify: true);
      await _getTicketListApi();
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    return BlurBackground(
      onTapOutside: () {
        helpAndSupportWatch.updateIsPopUpMenuOpen(isPopUpMenuOpen: false);
      },
      blurBackground: helpAndSupportWatch.isPopUpMenuOpen,
      child: CommonWhiteBackground(
        appBar: CommonAppBar(
          title: LocalizationStrings.keySupportAndHelp.localized,
          isDrawerEnable: true,
          actions: const [
            HelpAndSupportAppBarAction(),
          ],
        ),
        child: (helpAndSupportWatch.ticketListState.isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _bodyWidget(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final helpAndSupportWatch = ref.watch(helpAndSupportController);
        return Column(
          children: [
            Expanded(
              child: (helpAndSupportWatch.tickets.isNotEmpty)
                  ? _ticketList()
                  : _noTicketsAvailable(),
            ),
            const HelpAndSupportBottomWidget()
          ],
        );
      },
    );
  }

  ///To be displayed if no tickets are available
  Widget _noTicketsAvailable() {
    return SlideUpTransition(
      delay: 100,
      child: Consumer(builder: (context, ref, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonSVG(
                strIcon: AppAssets.svgHelpAndSupportBg,
                width: 228.h,
                height: 228.h,
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                LocalizationStrings.keyNoDataFound.localized,
                style: TextStyles.regular.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.grey7E7E7E,
                ),
              ).paddingOnly(bottom: 16.h),
              Text(
                LocalizationStrings.keyYouDontHaveAnyTicketsAvailable.localized,
                style: TextStyles.regular.copyWith(
                  color: AppColors.grey7E7E7E,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  ///Display List of Tickets
  Widget _ticketList() {
    return Consumer(
      builder: (context, ref, child) {
        final helpAndSupportWatch = ref.watch(helpAndSupportController);
        return ListView(
          controller: helpAndSupportWatch.scrollController,
          children: [
            Column(
            children: [
              ...List.generate(
                helpAndSupportWatch.tickets.length,
                ///Navigate to chat Screen
                    (index) {
                  return InkWell(
                    onTap: () {
                      ref.read(navigationStackProvider).push(NavigationStackItem.ticketChat(ticketModel: helpAndSupportWatch.tickets[index]));
                    },

                    ///Common Ticket Widget
                    child: SlideLeftTransition(
                      delay: 100,
                      child: TicketWidget(ticket: helpAndSupportWatch.tickets[index]).paddingOnly(bottom: 20.h),
                    ),
                  );
                },),
              Visibility(
                  visible: helpAndSupportWatch.ticketListState.isLoadMore,
                  child:Center(child: const  CircularProgressIndicator(color: AppColors.blue009AF1,).paddingOnly(top:18.h))),
            ],
          )
          ]
        ).paddingOnly(left: 20.w, right: 20.w, top: 20.h);
      },
    );
  }

  Future<void> _getTicketListApi() async {
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    await helpAndSupportWatch.getTicketList(context:context);
    helpAndSupportWatch.scrollController.addListener(() {
      if(mounted){
        if ((helpAndSupportWatch.scrollController.position.pixels >=
            helpAndSupportWatch.scrollController.position.maxScrollExtent - 100)) {
          if ((helpAndSupportWatch.ticketListState.success?.hasNextPage ?? false) &&
              !(helpAndSupportWatch.ticketListState.isLoadMore)) {
            helpAndSupportWatch.updatePageNumber();
            helpAndSupportWatch.getTicketList(context: context);
          }
        }
      }
    });
    // helpAndSupportWatch.resetPaginationTicketList();
    // helpAndSupportWatch.getTicketList(context: context);
    // helpAndSupportWatch.scrollController.addListener(
    //   () {
    //     if (mounted) {
    //       if (helpAndSupportWatch.scrollController.position.pixels >=
    //           (helpAndSupportWatch.scrollController.position.maxScrollExtent -
    //               300)) {
    //         if (helpAndSupportWatch.ticketListState.success?.hasNextPage ??
    //             false) {
    //           helpAndSupportWatch.updatePageNumber();
    //           helpAndSupportWatch.getTicketList(context: context);
    //         }
    //       }
    //     }
    //   },
    // );
  }
}
