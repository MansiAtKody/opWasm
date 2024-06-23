import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/help_and_support/contract/help_and_support_repository.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/add_ticket_request_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/add_ticket_response_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/ticket_reason_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final createTicketController = ChangeNotifierProvider(
  (ref) => getIt<CreateTicketController>(),
);

@injectable
class CreateTicketController extends ChangeNotifier {
  ///Form Key For Create Ticket Form
  final createTicketFormKey = GlobalKey<FormState>();
  final createTicketDescriptionController = TextEditingController();

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isAllFieldsValid = false;
    selectedReason = null;
    createTicketDescriptionController.clear();
    if (isNotify) {
      notifyListeners();
    }
  }

  void disposeFormKey() {
    createTicketFormKey.currentState?.reset();
  }
  void clearControllers() {
    createTicketDescriptionController.clear();
    isAllFieldsValid = false;
    notifyListeners();
  }

  ///For enabling and disabling button
  bool isAllFieldsValid = false;

  String? selectedReason;

  void updateReasonDropDownValue(String? selectedReason) {
    this.selectedReason = selectedReason;
    notifyListeners();
  }


  ///Form Validation
  void validateCreateTicketForm() {
    isAllFieldsValid = (selectedReason?.isNotEmpty ?? false) && (validateText(createTicketDescriptionController.text, LocalizationStrings.keyDescriptionIsRequired.localized) == null);
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  CreateTicketController(this.helpAndSupportRepository);
  HelpAndSupportRepository helpAndSupportRepository;

  UIState<AddTicketResponseModel> addTicketResponseState = UIState<AddTicketResponseModel>();
  /// GET Ticket Reason List API
  Future<void> addTicketApi(TicketReasonResponseModel selectedReasonModel,BuildContext context) async {
    addTicketResponseState.isLoading = true;
    addTicketResponseState.success = null;
    notifyListeners();

    AddTicketRequestModel requestModel = AddTicketRequestModel(ticketReasonUuid: selectedReasonModel.uuid,description: createTicketDescriptionController.text);
    final String request = addTicketRequestModelToJson(requestModel);

    final ApiResult result = await helpAndSupportRepository.addTicketApi(request: request);

    result.when(
      success: (success) {
        addTicketResponseState.success = success;
        notifyListeners();
      },
      failure: (error) {
        String errorMsg = NetworkExceptions.getErrorMessage(error);
         showCommonErrorDialog(context: context, message: errorMsg);

      },
    );
    addTicketResponseState.isLoading = false;
    notifyListeners();
  }

}
