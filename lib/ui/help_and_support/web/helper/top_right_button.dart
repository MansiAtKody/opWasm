// ignore_for_file: use_build_context_synchronously

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/create_ticket_controller.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/help_and_support/web/helper/create_ticket_form_web.dart';
import 'package:kody_operator/ui/help_and_support/web/helper/help_and_support_filter_widget_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class TopRightButton extends ConsumerWidget with BaseConsumerWidget {
  const TopRightButton({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final createTicketWatch = ref.read(createTicketController);

    /// Top Right Button
    return Row(
      children: [
        CommonButton(
          buttonText: LocalizationStrings.keyCreateTicket.localized,
          height: 50.h,
          width: context.width * 0.12,
          isButtonEnabled: true,
          onTap: () async {
            ref.watch(helpAndSupportController).getTicketReasonList(context);
            /// Show Create Ticket Dialog
            if(context.mounted){
              showHelpAndSupportDialog(
                context: context,
                widget: ref.watch(helpAndSupportController).ticketReasonListState.success?.data?.isNotEmpty ?? false
                    ? const CreateTicketFormWeb()
                    : EmptyStateWidget(title: LocalizationStrings.keyNoDataFound.localized, subTitle: LocalizationStrings.keyYouDontHaveAnyTicketReasons.localized,) ,
                topText: LocalizationStrings.keyCreateTicket.localized,
                onTapCrossIconButton: () {
                  createTicketWatch.createTicketDescriptionController.clear();
                  Navigator.pop(context);
                },

                /// Dialog Bottom Button
                buttonWidget: ref.watch(helpAndSupportController).ticketReasonListState.success?.data?.isNotEmpty ?? false
                    ? Consumer(
                  builder: (BuildContext context, WidgetRef ref,
                      Widget? child) {
                    final createTicketWatch = ref.watch(createTicketController);
                    final helpAndSupportWatch = ref.watch(helpAndSupportController);
                    if(helpAndSupportWatch.ticketReasonListState.isLoading){
                      return const Offstage();
                    }
                    else{
                     return  CommonButton(
                        buttonText: LocalizationStrings.keySubmit.localized,
                        isButtonEnabled: createTicketWatch.isAllFieldsValid,
                        height: 50.h,
                        buttonTextStyle: TextStyles.regular.copyWith(
                            fontSize: 18.sp,
                            color: createTicketWatch.isAllFieldsValid ? AppColors
                                .white : AppColors.textFieldLabelColor),
                        borderColor: createTicketWatch.isAllFieldsValid
                            ? null
                            : AppColors.grey8F8F8F,
                        rightIcon: Icon(Icons.arrow_forward,
                            color: createTicketWatch.isAllFieldsValid ? AppColors
                                .white : AppColors.textFieldLabelColor),
                        isLoading: createTicketWatch.addTicketResponseState.isLoading,
                        onTap: () async {
                          if (((createTicketWatch.createTicketFormKey.currentState?.validate()) ?? false) && !(createTicketWatch.addTicketResponseState.isLoading)) {
                            final selectedReasonModel = helpAndSupportWatch.reasons.where((element) => element.reason == createTicketWatch.selectedReason).toList()[0];
                            if(context.mounted){
                              helpAndSupportWatch.resetPaginationTicketList();
                              await createTicketWatch.addTicketApi(selectedReasonModel,context);
                              helpAndSupportWatch.getTicketList(context: context);
                              createTicketWatch.clearControllers();
                              Navigator.pop(context);
                            }
                          }
                        },
                      );
                    }
                  },
                )
                    : const Offstage(),
              );
            }
          }
        ),
        SizedBox(width: context.width * 0.02),
        const HelpAndSupportFilterWidgetWebIcon(),
      ],
    );
  }
}
