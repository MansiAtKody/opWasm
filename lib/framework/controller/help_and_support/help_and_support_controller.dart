import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/help_and_support/contract/help_and_support_repository.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_request_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/ticket_details_response_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/ticket_reason_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final helpAndSupportController = ChangeNotifierProvider(
  (ref) => getIt<HelpAndSupportController>(),
);

@injectable
class HelpAndSupportController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isPopUpMenuOpen = false;
    selectedFilter = issueFilterList[0];
    selectedTicket = null;
    resetPaginationTicketList();
    if (isNotify) {
      notifyListeners();
    }
  }



  void updateSelectedTickets(WidgetRef ref, {int? ticketId}) {
    // selectedTicket = tickets.where((ticket) => ticket.id == ticketId).firstOrNull;
    // selectedTicket ??= tickets[0];
    ref.read(navigationStackProvider).pushAndRemoveAll(NavigationStackItem.helpAndSupport(hasError: false, ticketId: selectedTicket?.uuid ?? ''));
    notifyListeners();
  }

  TicketFilterModel? selectedFilter;
  List<TicketReasonResponseModel> reasons = [];
  List<TicketFilterModel> issueFilterList = [
    TicketFilterModel(
        ticketStatus: TicketStatus.all,
        title: LocalizationStrings.keyAll.localized),
    TicketFilterModel(
        ticketStatus: TicketStatus.pending,
        title: LocalizationStrings.keyPending.localized),
    TicketFilterModel(
        ticketStatus: TicketStatus.acknowledged,
        title: LocalizationStrings.keyAcknowledged.localized),
    TicketFilterModel(
        ticketStatus: TicketStatus.resolved,
        title: LocalizationStrings.keyResolved.localized),
  ];
  bool hasTickets = false;

  List<TicketResponseModel> tickets = [];


  /// Selected Ticket Index
  TicketResponseModel? selectedTicket;

  ///Filter Ticket List based on selected button
  void onRadioSelected(int index,BuildContext context) async  {
    selectedFilter = issueFilterList[index];
    notifyListeners();
  }

  bool isPopUpMenuOpen = false;

  void updateIsPopUpMenuOpen({bool? isPopUpMenuOpen}) {
    this.isPopUpMenuOpen = isPopUpMenuOpen ?? !this.isPopUpMenuOpen;
    notifyListeners();
  }

/*
  /// ---------------------------- Api Integration ---------------------------------///
   */
  HelpAndSupportRepository helpAndSupportRepository;

  HelpAndSupportController(this.helpAndSupportRepository);

  ScrollController scrollController = ScrollController();

  int pageNumber = 1;

  void updatePageNumber(){
    pageNumber++;
    notifyListeners();
  }
  void resetPaginationTicketList() {
    ticketListState.success = null;
    pageNumber = 1;
    tickets.clear();
    notifyListeners();
  }

  UIState<GetTicketListResponseModel> ticketListState = UIState<GetTicketListResponseModel>();
  UIState<TicketReasonListResponseModel> ticketReasonListState = UIState<TicketReasonListResponseModel>();
  UIState<TicketDetailsResponseModel> ticketDetailState = UIState<TicketDetailsResponseModel>();

  /// GET Ticket List API
  Future<void> getTicketList({required BuildContext context}) async {
    if ((pageNumber != 1) && (ticketListState.success?.hasNextPage??false)) {
      ticketListState.isLoadMore=true;
    }
    else{
      pageNumber=1;
      tickets.clear();
      ticketListState.isLoading=true;
    }

    ticketListState.success = null;
    notifyListeners();

    final ticketFilter = selectedFilter?.ticketStatus == TicketStatus.all ? null : selectedFilter;
    GetTicketListRequestModel requestModel = GetTicketListRequestModel(status: ticketFilter?.title.toUpperCase());
    final String request = getTicketListRequestModelToJson(requestModel);

    final ApiResult result = await helpAndSupportRepository.getTicketList(request: request,pageNo: pageNumber);

    result.when(
      success: (success) {
        ticketListState.success = success;
        ticketListState.isLoadMore=false;
        tickets.addAll(ticketListState.success?.data ?? []);
        notifyListeners();
      },
      failure: (error) {
        String errorMsg = NetworkExceptions.getErrorMessage(error);
         showCommonErrorDialog(context: context, message: errorMsg);

      },
    );
    ticketListState.isLoading = false;
    notifyListeners();
  }

  /// GET Ticket Detail API
  Future<void> getTicketDetail({required BuildContext context,String? uuid}) async {
    ticketDetailState.isLoading = true;
    ticketDetailState.success = null;
    notifyListeners();

    final ApiResult result = await helpAndSupportRepository.getTicketDetails(uuid: uuid ?? (selectedTicket?.uuid ?? ''));

    result.when(
      success: (success) {
        ticketDetailState.success = success;
        selectedTicket = ticketDetailState.success?.data;
        notifyListeners();
      },
      failure: (error) {
        String errorMsg = NetworkExceptions.getErrorMessage(error);
         showCommonErrorDialog(context: context, message: errorMsg);

      },
    );
    ticketDetailState.isLoading = false;
    notifyListeners();
  }

  /// GET Ticket Reason List API
  Future<void> getTicketReasonList(BuildContext context) async {
    ticketReasonListState.isLoading = true;
    ticketReasonListState.success = null;
    notifyListeners();

    final ApiResult result = await helpAndSupportRepository.getReasonsList();

    result.when(
      success: (success) {
        ticketReasonListState.success = success;
        reasons = ticketReasonListState.success?.data ?? [];
        notifyListeners();
      },
      failure: (error) {
        String errorMsg = NetworkExceptions.getErrorMessage(error);
         showCommonErrorDialog(context: context, message: errorMsg);
      },
    );
    ticketReasonListState.isLoading = false;
    notifyListeners();
  }
}

class TicketFilterModel {
  TicketStatus ticketStatus;
  String title;

  TicketFilterModel({required this.ticketStatus, required this.title});
}
