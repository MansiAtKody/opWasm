import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:kody_operator/ui/auth/forgot_reset_password.dart';
import 'package:kody_operator/ui/auth/login.dart';
import 'package:kody_operator/ui/auth/otp_verification.dart';
import 'package:kody_operator/ui/cms/cms.dart';
import 'package:kody_operator/ui/dispatched_order/dispatched_order.dart';
import 'package:kody_operator/ui/error/error.dart';
import 'package:kody_operator/ui/faq/faq.dart';
import 'package:kody_operator/ui/help_and_support/create_ticket.dart';
import 'package:kody_operator/ui/help_and_support/help_and_support.dart';
import 'package:kody_operator/ui/help_and_support/ticket_chat.dart';
import 'package:kody_operator/ui/location/select_location_dialog.dart';
import 'package:kody_operator/ui/map/map.dart';
import 'package:kody_operator/ui/my_order/my_order.dart';
import 'package:kody_operator/ui/my_order/order_details.dart';
import 'package:kody_operator/ui/my_order/order_home.dart';
import 'package:kody_operator/ui/my_order/order_status.dart';
import 'package:kody_operator/ui/my_tray/additional_note.dart';
import 'package:kody_operator/ui/my_tray/my_tray.dart';
import 'package:kody_operator/ui/my_tray/order_customization.dart';
import 'package:kody_operator/ui/my_tray/order_successful.dart';
import 'package:kody_operator/ui/notification/notification_screen.dart';
import 'package:kody_operator/ui/order_history/order_history.dart';
import 'package:kody_operator/ui/order_management/order_management.dart';
import 'package:kody_operator/ui/order_management/web/helper/select_coffee_screeen.dart';
import 'package:kody_operator/ui/product_management/product_management.dart';
import 'package:kody_operator/ui/profile/change_email.dart';
import 'package:kody_operator/ui/profile/change_language.dart';
import 'package:kody_operator/ui/profile/change_mobile_no.dart';
import 'package:kody_operator/ui/profile/change_password.dart';
import 'package:kody_operator/ui/profile/delete_account.dart';
import 'package:kody_operator/ui/profile/otp_verification_profile_module.dart';
import 'package:kody_operator/ui/profile/personal_info.dart';
import 'package:kody_operator/ui/profile/profile.dart';
import 'package:kody_operator/ui/profile/profile_setting.dart';
import 'package:kody_operator/ui/robot_tray_selection/robot_tray_selection.dart';
import 'package:kody_operator/ui/routing/navigation_stack_keys.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/announcement.dart';
import 'package:kody_operator/ui/services/announcement_get_details.dart';
import 'package:kody_operator/ui/services/desk_cleaning.dart';
import 'package:kody_operator/ui/services/mobile/service_history_mobile.dart';
import 'package:kody_operator/ui/services/mobile/service_status_mobile.dart';
import 'package:kody_operator/ui/services/recycling.dart';
import 'package:kody_operator/ui/services/request_sent.dart';
import 'package:kody_operator/ui/services/request_sent_announcement.dart';
import 'package:kody_operator/ui/services/send_service.dart';
import 'package:kody_operator/ui/services/send_service_detail.dart';
import 'package:kody_operator/ui/services/services.dart';
import 'package:kody_operator/ui/setting/setting.dart';
import 'package:kody_operator/ui/splash/splash.dart';
import 'package:kody_operator/ui/user_management/add_operator.dart';
import 'package:kody_operator/ui/user_management/user_management.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/widgets/drawer/no_animation_route.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

@injectable
class MainRouterDelegate extends RouterDelegate<NavigationStack> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final NavigationStack stack;

  @override
  void dispose() {
    stack.removeListener(notifyListeners);
    super.dispose();
  }

  MainRouterDelegate(@factoryParam this.stack) : super() {
    stack.addListener(notifyListeners);
  }

  @override
  final navigatorKey = globalNavigatorKey;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Navigator(
        key: navigatorKey,
        pages: _pages(ref),

        /// callback when a page is popped.
        onPopPage: (route, result) {
          /// let the OS handle the back press if there was nothing to pop
          if (!route.didPop(result)) {
            return false;
          }

          /// if we are on root, let OS close app
          if (stack.items.length == 1) return false;

          /// if we are on root, let OS close app
          if (stack.items.isEmpty) return false;

          /// otherwise, pop the stack and consume the event
          stack.pop();
          return true;
        },
      );
    });
  }

  List<Page> _pages(WidgetRef ref) => stack.items
      .mapIndexed((e, i) => e.when(
            splash: () => const MaterialPage(child: Splash(), key: ValueKey(Keys.splash)),
            login: (hasError) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: Login(), key: ValueKey(Keys.login)),
            forgotResetPassword: (isForgotPassword, hasError) => (hasError ?? false)
                ? const NoAnimationPage(child: Offstage())
                : NoAnimationPage(
                    child: ForgotResetPassword(
                      isForgotPassword: isForgotPassword,
                    ),
                    key: const ValueKey(Keys.forgotResetPassword)),
            otpVerification: (hasError, email, fromScreen) => (hasError ?? false)
                ? const NoAnimationPage(child: Offstage())
                : NoAnimationPage(
                    child: OtpVerification(email: email, fromScreen: fromScreen),
                    key: const ValueKey(Keys.otpVerification),
                  ),

            ///Profile
            profile: (hasError) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: Profile(), key: ValueKey(Keys.profile)),

            personalInformation: () => const MaterialPage(child: PersonalInfo(), key: ValueKey(Keys.personalInfo)),
            profileSetting: () => const MaterialPage(child: ProfileSetting(), key: ValueKey(Keys.profileSetting)),
            changeLanguage: () => const MaterialPage(child: ChangeLanguage(), key: ValueKey(Keys.changeLanguage)),
            changeEmail: () => const MaterialPage(child: ChangeEmail(), key: ValueKey(Keys.changeEmail)),
            changeMobile: () => const MaterialPage(child: ChangeMobileNo(), key: ValueKey(Keys.changeMobile)),
            changePassword: () => const MaterialPage(child: ChangePassword(), key: ValueKey(Keys.changePassword)),
            deleteAccount: () => const MaterialPage(child: DeleteAccount(), key: ValueKey(Keys.deletAccount)),
            otpVerificationProfileModule: (email, fromScreen,currentPassword) => MaterialPage(
              child: OtpVerificationProfileModule(
                email: email,
                fromScreen: fromScreen,
              currentPassword: currentPassword,),
              key: const ValueKey(Keys.otpVerificationProfile),
            ),

            ///home
            home: (hasError) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: OrderManagement(), key: ValueKey(Keys.home)),

            ///Help And Support
            helpAndSupport: (hasError, ticketId) {
              return (hasError ?? false)
                  ? const NoAnimationPage(child: Offstage())
                  : NoAnimationPage(
                      child: HelpAndSupport(ticketId: ticketId),
                      key: const ValueKey(Keys.helpAndSupport),
                    );
            },
            createTicket: (hasError) => (hasError ?? false)
                ? const NoAnimationPage(child: Offstage())
                : const NoAnimationPage(
                    child: CreateTicket(),
                    key: ValueKey(Keys.createTicket),
                  ),
            ticketChat: (hasError, ticketModel) => (hasError ?? false)
                ? const NoAnimationPage(child: Offstage())
                : NoAnimationPage(
                    child: TicketChat(ticketModel: ticketModel),
                    key: const ValueKey(Keys.ticketChat),
                  ),

            ///Order management
            orderManagement: () => const MaterialPage(child: OrderManagement(), key: ValueKey(Keys.orderManagement)),

            coffeeSelection: (hasError) => const MaterialPage(child: SelectCoffeeScreen(), key: ValueKey(Keys.coffeeSelection)),

            recycling: (hasError) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: Recycling(), key: ValueKey(Keys.recycling)),

            ///setting
            setting: (hasError) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: Setting(), key: ValueKey(Keys.setting)),

            ///Map
            map: (hasError) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: MapScreen(), key: ValueKey(Keys.map)),

            ///services
            services: (hasError) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: Services(), key: ValueKey(Keys.services)),
            deskcleaning: () => const NoAnimationPage(child: DeskCleaning(), key: ValueKey(Keys.deskcleaning)),

            ///Product Management
            productManagement: (hasError, productType) => (hasError ?? false)
                ? const MaterialPage(child: Offstage())
                : NoAnimationPage(child: ProductManagement(productType: productType), key: const ValueKey(Keys.productManagement)),

            ///History
            history: (hasError, orderType) =>
                (hasError ?? false) ? const MaterialPage(child: Offstage()) : NoAnimationPage(child: OrderHistory(orderType: orderType), key: const ValueKey(Keys.history)),

            faq: () => const MaterialPage(
              child: Faq(),
              key: ValueKey(Keys.faq),
            ),

            ///Users
            users: (hasError) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: UserManagement(), key: ValueKey(Keys.users)),

            sendService: (isSendService, hasError) => (hasError ?? false)
                ? const MaterialPage(child: Offstage())
                : NoAnimationPage(child: SendService(isSendService: isSendService), key: const ValueKey(Keys.sendService)),
            sendServiceDetail: (isSendService, profileModel) => NoAnimationPage(
              child: SendServiceDetail(
                isSendService: isSendService,
                profileModel: profileModel,
              ),
              key: const ValueKey(Keys.sendServiceDetail),
            ),

            ///cms
            cms: (cmsType) => MaterialPage(
              child: Cms(cmsType: cmsType),
              key: const ValueKey(Keys.cms),
            ),

            notification: () => const MaterialPage(
              child: NotificationScreen(),
            ),

            /// Services
            announcement: (hasError) =>
                (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: Announcement(), key: ValueKey(Keys.announcement)),

            requestSentAnnouncement: () => const MaterialPage(child: RequestSentAnnouncement(), key: ValueKey(Keys.requestSentAnnouncement)),

            requestSent: () => const MaterialPage(child: RequestSent(), key: ValueKey(Keys.requestSent)),

            announcementGetDetails: (announcementGetDetails) =>
                MaterialPage(child: AnnouncementGetDetails(appBarTitle: announcementGetDetails), key: const ValueKey(Keys.announcementGetDetails)),

            serviceHistory: (profileModel, isSendService) =>
                MaterialPage(child: ServiceHistoryMobile(profileModel: profileModel, isSendService: isSendService), key: const ValueKey(Keys.serviceHistory)),

            serviceStatus: (request, profileModel, isSendService) =>
                MaterialPage(child: ServiceStatusMobile(request: request, isSendService: isSendService, model: profileModel), key: const ValueKey(Keys.serviceStatus)),

            /// Robot Tray Selection
            robotTraySelection: () => const NoAnimationPage(child: RobotTraySelection(), key: ValueKey(Keys.robotTraySelection)),

            ///Robot dispatched order
            dispatchOrder: () => const NoAnimationPage(child: DispatchedOrder(), key: ValueKey(Keys.dispatchOrder)),

            ///error
            error: (key, errorType) => NoAnimationPage(child: Error(errorType: errorType), key: const ValueKey(Keys.error404)),

            addSubOperator: (hasError, operatorData, uuid) => (hasError ?? false)
                ? const MaterialPage(child: Offstage())
                : NoAnimationPage(child: AddOperator(operatorData: operatorData, uuid: uuid), key: const ValueKey(Keys.addSubOperator)),

            /// Order
            orderHome: (hasError) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : const NoAnimationPage(child: OrderHome(), key: ValueKey(Keys.orderHome)),
            myOrder: (hasError, fromScreen, type) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : NoAnimationPage(child: MyOrder(fromScreen: fromScreen, orderType: type ?? orderEnumValues.map[HiveProvider.get('type')],), key: const ValueKey(Keys.myOrder),),
            orderDetails: (bool? hasError, String? orderId)=> (hasError ?? false) ? const MaterialPage(child: Offstage()) : NoAnimationPage(child: OrderDetails(orderId: orderId), key: const ValueKey(Keys.orderDetails),),
           orderFlowStatus: (hasError, orderId) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : NoAnimationPage(child: OrderFlowStatus(orderId: orderId), key: const ValueKey(Keys.orderFlowStatus),),
           orderCustomization: (hasError, fromScreen, productUuid, uuid) => (hasError ?? false)? const MaterialPage(child: Offstage()) : NoAnimationPage(child: OrderCustomization(fromScreen: fromScreen, productUuid: productUuid, uuid: uuid), key: const ValueKey(Keys.orderCustomization),),
           additionalNote: (hasError, additionalNote) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : MaterialPage(child: AdditionalNote(additionalNote: additionalNote), key: const ValueKey(Keys.additionalNote), fullscreenDialog: true),
          orderSuccessful: (hasError, fromScreen,) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : NoAnimationPage(child: OrderSuccessful(fromScreen: fromScreen), key: const ValueKey(Keys.orderSuccessful),),
        myTray: (hasError, popCallBack) => (hasError ?? false) ? const MaterialPage(child: Offstage()) : NoAnimationPage(child: MyTray(popCallBack: popCallBack,),

    ),
    selectLocationDialog: (bool? hasError, String? buttonText, void Function()? onButtonPressed)=>NoAnimationPage(child: SelectLocationDialog(buttonText: buttonText, onButtonPressed: onButtonPressed,), key: const ValueKey(Keys.selectLocationDialog)),

  ))
      .toList();

  @override
  NavigationStack get currentConfiguration => stack;

  @override
  Future<void> setNewRoutePath(NavigationStack configuration) async {
    stack.items = configuration.items;
  }
}

extension _IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
