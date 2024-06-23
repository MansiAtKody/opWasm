import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/create_ticket_controller.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/help_and_support/mobile/helper/create_ticket_form.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class CreateTicketMobile extends ConsumerStatefulWidget {
  const CreateTicketMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateTicketMobile> createState() => _CreateTicketMobileState();
}

class _CreateTicketMobileState extends ConsumerState<CreateTicketMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final createTicketWatch = ref.read(createTicketController);
      createTicketWatch.disposeController(isNotify: true);
      await ref.read(helpAndSupportController).getTicketReasonList(context);
      Future.delayed(const Duration(milliseconds: 100), () {
        createTicketWatch.disposeFormKey();
      });
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
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: Scaffold(
        ///Common App Bar
        appBar: CommonAppBar(
          title: LocalizationStrings.keyCreateTicket.localized,
          isLeadingEnable: true,
          isDrawerEnable: false,
        ),
        backgroundColor: AppColors.white,
        body: helpAndSupportWatch.ticketReasonListState.isLoading ?  const Center(child: CircularProgressIndicator(),) : _bodyWidget(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    return helpAndSupportWatch.ticketReasonListState.success?.data?.isNotEmpty ??false ? Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Expanded(
          child: SingleChildScrollView(
            ///Create Ticket Form
            child: CreateTicketForm(),
          ),
        ),
        Consumer(builder: (context, ref, child) {
          final createTicketWatch = ref.watch(createTicketController);
          final helpAndSupportWatch = ref.watch(helpAndSupportController);

          ///Common Button
          return SlideUpTransition(
            delay: 100,
            child: CommonButtonMobile(
              width: double.infinity,
              buttonText: LocalizationStrings.keySubmit.localized,
              isButtonEnabled: createTicketWatch.isAllFieldsValid,
              buttonTextColor: createTicketWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor,
              rightIcon: Icon(Icons.arrow_forward, color: createTicketWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
              onValidateTap: () {
                createTicketWatch.createTicketFormKey.currentState?.validate();
              },
              isLoading: createTicketWatch.addTicketResponseState.isLoading,
              onTap: () async {
                if (((createTicketWatch.createTicketFormKey.currentState?.validate()) ?? false) && !(createTicketWatch.addTicketResponseState.isLoading)) {
                  final selectedReasonModel = helpAndSupportWatch.reasons.where((element) => element.reason == createTicketWatch.selectedReason).toList()[0];
                  helpAndSupportWatch.resetPaginationTicketList();
                  if(context.mounted){
                    await createTicketWatch.addTicketApi(selectedReasonModel, context).then((value) => helpAndSupportWatch.getTicketList(context: context));
                  }

                  ///Navigate to Ticket Chat
                  ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.helpAndSupport());
                }
              },
            ).paddingSymmetric(horizontal: 25.w,vertical: 15.h),
          );
        }),
      ],
    ) : EmptyStateWidget(title: LocalizationStrings.keyNoDataFound.localized, subTitle: LocalizationStrings.keyYouDontHaveAnyTicketReasons.localized,);
  }
}
