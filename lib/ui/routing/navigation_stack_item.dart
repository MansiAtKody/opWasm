import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/repository/service/service_request_model.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';

part 'navigation_stack_item.freezed.dart';

@freezed
class NavigationStackItem with _$NavigationStackItem {
  const factory NavigationStackItem.splash() = NavigationStackItemSplash;

  ///Auth
  const factory NavigationStackItem.login({bool? hasError}) = NavigationStackItemLogin;
  const factory NavigationStackItem.forgotResetPassword({required bool isForgotPassword, bool? hasError}) = NavigationStackItemForgotResetPassword;
  const factory NavigationStackItem.otpVerification({bool? hasError,required String email,required FromScreen fromScreen}) = NavigationStackItemOtpVerification;

  ///Profile
  const factory NavigationStackItem.profile({bool? hasError}) = NavigationStackItemDashBoard;
  const factory NavigationStackItem.personalInformation() = NavigationStackItemPersonalInformation;
  const factory NavigationStackItem.profileSetting() = NavigationStackItemProfileSetting;
  const factory NavigationStackItem.changeLanguage() = NavigationStackItemChangeLanguage;
  const factory NavigationStackItem.changeEmail() = NavigationStackItemChangeEmail;
  const factory NavigationStackItem.changeMobile() = NavigationStackItemChangeMobile;
  const factory NavigationStackItem.changePassword() = NavigationStackItemChangePassword;
  const factory NavigationStackItem.deleteAccount() = NavigationStackItemDeleteAccount;
  const factory NavigationStackItem.otpVerificationProfileModule({required String email,required FromScreen fromScreen,String? currentPassword}) = NavigationStackItemOtpVerificationProfileModule;

  ///Home
  const factory NavigationStackItem.home({bool? hasError}) = NavigationStackItemHome;

  /// Help and Support
  const factory NavigationStackItem.helpAndSupport({bool? hasError, String? ticketId}) = NavigationStackItemHelpAndSupport;
  const factory NavigationStackItem.createTicket({bool? hasError}) = NavigationStackItemCreateticket;
  const factory NavigationStackItem.ticketChat({bool? hasError,TicketResponseModel? ticketModel}) = NavigationStackItemTicketChat;

  ///Order Management
  const factory NavigationStackItem.orderManagement() = NavigationStackItemOrderManagement;

  ///Setting
  const factory NavigationStackItem.setting({bool? hasError}) = NavigationStackItemSetting;

  ///Map
  const factory NavigationStackItem.map({bool? hasError}) = NavigationStackItemMap;

  ///Services
  const factory NavigationStackItem.services({bool? hasError}) = NavigationStackItemServices;
  const factory NavigationStackItem.sendService({required bool isSendService, bool? hasError}) = NavigationStackItemSendService;
  const factory NavigationStackItem.sendServiceDetail({required bool isSendService, required ProfileModel profileModel}) = NavigationStackItemSendServiceDetail;
  const factory NavigationStackItem.serviceHistory({required ProfileModel model,required bool isSendService}) = NavigationStackItemServiceHistory;
  const factory NavigationStackItem.serviceStatus({required ServiceRequestModel? request,required ProfileModel? model,required bool isSendService}) = NavigationStackItemServiceStatus;
  const factory NavigationStackItem.deskcleaning() = NavigationStackItemDeskCleaning;
  const factory NavigationStackItem.productManagement({bool? hasError, ProductType? productType}) = NavigationStackItemProductManagement;


  /// CMS
  const factory NavigationStackItem.cms({required CMSType cmsType}) = NavigationStackItemCms;

  ///Faq
  const factory NavigationStackItem.faq() = NavigationStackItemFaq;

  ///Notification
  const factory NavigationStackItem.notification() = NavigationStackItemNotification;


  ///Announcement
  const factory NavigationStackItem.announcement({bool? hasError}) = NavigationStackItemAnnouncement;

  const factory NavigationStackItem.requestSentAnnouncement() = NavigationStackItemRequestSentAnnouncement;

  const factory NavigationStackItem.requestSent() = NavigationStackItemRequestSent;

  const factory NavigationStackItem.announcementGetDetails({required AnnouncementsTypeEnum announcementsGetDetails}) = NavigationStackItemAnnouncementGetDetails;

  const factory NavigationStackItem.recycling({bool? hasError}) = NavigationStackItemRecycling;
  /// Robot Tray Selection Module
  const factory NavigationStackItem.robotTraySelection() = NavigationStackItemRobotTraySelection;

  const factory NavigationStackItem.history({bool? hasError, OrderType? orderType}) = NavigationStackItemHistory;

  const factory NavigationStackItem.users({bool? hasError}) = NavigationStackItemUsers;

  ///Error
  const factory NavigationStackItem.error({String? key, ErrorType? errorType}) = NavigationStackItemError;

  const factory NavigationStackItem.addSubOperator({bool? hasError,SubOperatorData? operatorData,String? uuid}) = NavigationStackItemAddSubOperator;
  const factory NavigationStackItem.coffeeSelection({bool? hasError}) = NavigationStackItemCoffeeSelection;

  /// Order
  const factory NavigationStackItem.additionalNote({bool? hasError,required String additionalNote}) = NavigationStackItemAdditionalNote;
  const factory NavigationStackItem.orderHome({bool? hasError}) = NavigationStackItemOrderHome;
  const factory NavigationStackItem.orderSuccessful({bool? hasError,required FromScreen fromScreen}) = NavigationStackItemOrderSuccessful;
  const factory NavigationStackItem.myOrder({bool? hasError,FromScreen? fromScreen, OrderType? type}) = NavigationStackItemMyOrder;
  const factory NavigationStackItem.orderDetails({bool? hasError, String? orderId}) = NavigationStackItemOrderDetails;
  const factory NavigationStackItem.orderCustomization({bool? hasError,required FromScreen fromScreen,required String productUuid,String? uuid}) = NavigationStackItemOrderCustomization;
  const factory NavigationStackItem.orderFlowStatus({bool? hasError, String? orderId}) = NavigationStackItemOrderFlowStatus;
  /// Location
  const factory NavigationStackItem.selectLocationDialog({bool? hasError,String? buttonText,void Function()? onButtonPressed,}) = NavigationStackItemSelectLocationDialog;
 /// Tray
  const factory NavigationStackItem.myTray({bool? hasError, Function? popCallBack}) = NavigationStackItemMyTray;

  ///Dispatched order
  const factory NavigationStackItem.dispatchOrder() = NavigationStackItemDispatchOrder;

}
