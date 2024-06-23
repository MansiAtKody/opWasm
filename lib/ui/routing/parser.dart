import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/repository/service/service_request_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/navigation_stack_keys.dart';
import 'package:kody_operator/ui/routing/route_manager.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/widgets/socket_manager.dart';

@injectable
class MainRouterInformationParser extends RouteInformationParser<NavigationStack> {
  WidgetRef ref;
  BuildContext context;
  SocketManager socketManager;

  MainRouterInformationParser(@factoryParam this.ref, @factoryParam this.context, this.socketManager);

  ///Parse Screen from URL
  @override
  Future<NavigationStack> parseRouteInformation(RouteInformation routeInformation) async {
    List<String> queryParam = [];
    List<String> tempUrlList = routeInformation.uri.toString().split('/');
    tempUrlList.removeAt(0);
    List<String> tempPathList = [];
    for (var element in tempUrlList) {
      tempPathList.add(element.split('?').first);
      if (element.split('?').length > 1) {
        queryParam.add(element.split('?').last);
      }
    }
    String mainUrl = '/${tempPathList.join('/')}${queryParam.isNotEmpty ? '?${queryParam.join('&')}' : ''}';
    print('........URL......$mainUrl');
    final Uri uri = Uri.parse(mainUrl);
    final queryParams = uri.queryParameters;
    debugPrint('........queryParams....$queryParams');
    final items = <NavigationStackItem>[];

    ///Will remove all the empty path from segments
    RouteManager.route.removeEmptyPath(uri.pathSegments);

    ///To add error page at the end and return no widget if error is found
    bool hasError = false;

    ///To add error page at the end and return no widget if error is found
    bool isAuthenticated = true;

    ///Will check validation for routes
    await RouteManager.route.checkPathValidation().then(
      (routeValidator) {
        for (var i = 0; i < RouteManager.route.pathSegments.length; i = i + 1) {
          ///To add error page at the end and return no widget if error is found
          hasError = !(routeValidator.isRouteValid);
          isAuthenticated = (routeValidator.isAuthenticated);
          if (isAuthenticated && Session.getUserAccessToken().isNotEmpty) {
            socketManager.startSocket(ref);
          }
          final key = RouteManager.route.pathSegments[i];
          switch (key) {
            case Keys.splash:
              items.add(const NavigationStackItem.splash());
              break;

            case Keys.login:
              items.add(NavigationStackItem.login(hasError: hasError));
              break;

            case Keys.forgotResetPassword:
              items.add(NavigationStackItem.forgotResetPassword(isForgotPassword: true, hasError: hasError));
              // items.add(NavigationStackItem.otpVerification(hasError: hasError));
              break;

            case Keys.otpVerification:
              // items.add(NavigationStackItem.otpVerification(hasError: hasError, email: '', fromScreen: FromScreen.none));
              break;

            ///Help And Support
            case Keys.helpAndSupport:
              String? ticketId = uri.queryParameters['ticketId'] ?? '';
              items.add(NavigationStackItem.helpAndSupport(ticketId: ticketId, hasError: hasError));
              break;
            case Keys.ticketChat:
              items.add(NavigationStackItem.ticketChat(ticketModel: null, hasError: hasError));
              break;
            case Keys.createTicket:
              items.add(NavigationStackItem.createTicket(hasError: hasError));
              break;

            ///Profile
            case Keys.profile:
              items.add(NavigationStackItem.profile(hasError: hasError));
              break;
            case Keys.personalInfo:
              items.add(const NavigationStackItem.personalInformation());
              break;
            case Keys.profileSetting:
              items.add(const NavigationStackItem.profileSetting());
              break;
            case Keys.changeLanguage:
              items.add(const NavigationStackItem.changeLanguage());
              break;
            case Keys.changePassword:
              items.add(const NavigationStackItem.changePassword());
              break;
            case Keys.changeMobile:
              items.add(const NavigationStackItem.changeMobile());
              break;
            case Keys.deletAccount:
              items.add(const NavigationStackItem.deleteAccount());
              break;
            case Keys.otpVerificationProfile:
              items.add(const NavigationStackItem.otpVerificationProfileModule(email: '', fromScreen: FromScreen.none,currentPassword: ''));
              break;

            case Keys.home:
              items.add(NavigationStackItem.home(hasError: hasError));
              break;

            case Keys.users:
              items.add(NavigationStackItem.users(hasError: hasError));
              break;

            case Keys.orderManagement:
              items.add(const NavigationStackItem.orderManagement());
              break;

            case Keys.setting:
              items.add(NavigationStackItem.setting(hasError: hasError));
              break;

            case Keys.services:
              items.add(NavigationStackItem.services(hasError: hasError));
              break;

            case Keys.deskcleaning:
              items.add(const NavigationStackItem.deskcleaning());
              break;

            case Keys.sendService:
              items.add(NavigationStackItem.sendService(isSendService: true, hasError: hasError));
              break;

            case Keys.receiveService:
              items.add(NavigationStackItem.sendService(isSendService: false, hasError: hasError));
              break;

            case Keys.recycling:
              items.add(NavigationStackItem.recycling(hasError: hasError));
              break;

            case Keys.sendServiceDetail:
              items.add(NavigationStackItem.sendServiceDetail(isSendService: false, profileModel: ProfileModel(name: 'John', department: 'Jr. Consultant', id: 0)));
              break;

            case Keys.announcement:
              items.add(NavigationStackItem.announcement(hasError: hasError));
              break;

            case Keys.requestSentAnnouncement:
              items.add(const NavigationStackItem.requestSentAnnouncement());
              break;

            case Keys.announcementGetDetails:
              items.add(const NavigationStackItem.announcementGetDetails(announcementsGetDetails: AnnouncementsTypeEnum.general));
              break;

            case Keys.serviceHistory:
              items.add(NavigationStackItem.serviceHistory(model: ProfileModel(name: 'name', department: 'department', id: 0), isSendService: true));

            case Keys.serviceStatus:
              items.add(NavigationStackItem.serviceStatus(
                  request: ServiceRequestModel(
                      subject: 'Subject',
                      message: 'Message',
                      orderId: '#123456',
                      fromPerson: 'John Smith',
                      toPerson: 'William Sky',
                      itemType: 'Document',
                      orderStatus: 'Deliverd',
                      requestDate: DateTime.now(),
                      trayNumber: 01),
                  model: ProfileModel(name: 'John', department: 'Jr. Consultant', id: 0),
                  isSendService: true));
              break;
            case Keys.addSubOperator:
              items.add(NavigationStackItem.addSubOperator(hasError: hasError, operatorData: null, uuid: null));
              break;

            ///Notification
            case Keys.notification:
              items.add(const NavigationStackItem.notification());
              break;

            case Keys.coffeeSelection:
              items.add(const NavigationStackItem.coffeeSelection());
              break;

            /// CMS
            case Keys.cms:
              CMSType? cmsType = cmsTypeString.map[uri.queryParameters['type'] ?? ''];
              items.add(NavigationStackItem.cms(cmsType: cmsType ?? CMSType.none));
              break;


            case Keys.requestSent:
              items.add(const NavigationStackItem.requestSent());
              break;

            case Keys.history:
              OrderType? orderType = orderEnumValues.map[uri.queryParameters['historyType'] ?? ''];
              items.add(NavigationStackItem.history(hasError: hasError, orderType: orderType));
              break;

            case Keys.map:
              items.add(NavigationStackItem.map(hasError: hasError));
              break;

            case Keys.productManagement:
              ProductType? productType = productEnumValues.map[uri.queryParameters['productType'] ?? ''];

              items.add(NavigationStackItem.productManagement(hasError: hasError, productType: productType));
              break;

            /// Robot Tray Selection
            case Keys.robotTraySelection:
              items.add(const NavigationStackItem.robotTraySelection());
              break;

          /// Dispatch Order
            case Keys.dispatchOrder:
              items.add(const NavigationStackItem.dispatchOrder());
              break;

            /// Faq
            case Keys.faq:
              items.add(const NavigationStackItem.faq());
              break;

            ///   Order
            case Keys.orderSuccessful:
              items.add(NavigationStackItem.orderSuccessful(hasError: hasError, fromScreen: FromScreen.none));
              break;
            case Keys.selectLocationDialog:
              items.add(NavigationStackItem.selectLocationDialog(hasError: hasError));
              break;

            case Keys.myOrder:
              OrderType? orderType = orderEnumValues.map[uri.queryParameters['type'] ?? ''];
              items.add(NavigationStackItem.myOrder(hasError: hasError, fromScreen: null, type: orderType));
              break;
            case Keys.orderFlowStatus:
              items.add(NavigationStackItem.orderFlowStatus(hasError: false, orderId: uri.queryParameters['orderId'] ?? ''));
              break;
            case Keys.orderCustomization:
              items.add(NavigationStackItem.orderCustomization(hasError: hasError, fromScreen: FromScreen.none,productUuid: queryParams['id'] ?? '',uuid:''));
              break;
            case Keys.orderDetails:
              if (context.isMobileScreen) {
                items.add(NavigationStackItem.orderDetails(hasError: hasError, orderId: uri.queryParameters['orderId'] ?? ''));
              }
              break;
            case Keys.myTray:
              items.add(NavigationStackItem.myTray(hasError: hasError, popCallBack: null));
              break;
            case Keys.additionalNote:
              items.add(NavigationStackItem.additionalNote(additionalNote: '', hasError: hasError));
              break;

            case Keys.orderHome:
              items.add(NavigationStackItem.orderHome(hasError: hasError));
              break;

            default:
              items.add(NavigationStackItem.error(key: key, errorType: ErrorType.error404));
              break;
          }
        }
      },
    );

    ///If have error then add 404 without passing any key so the path will not be shown in url
    if (hasError) {
      items.add(const NavigationStackItem.error(errorType: ErrorType.error404));
    } else if (!(isAuthenticated)) {
      items.add(const NavigationStackItem.error(errorType: ErrorType.error403));
    }

    if (items.isEmpty) {
      const fallback = NavigationStackItem.splash();
      if (items.isNotEmpty && items.first is NavigationStackItemSplash) {
        items[0] = fallback;
      } else {
        items.insert(0, fallback);
      }
    }

    return NavigationStack(items);
  }

  ///THIS IS IMPORTANT: Here we restore the web history
  @override
  RouteInformation? restoreRouteInformation(NavigationStack configuration) {
    final location = configuration.items.fold<String>(
      '',
      (previousValue, element) {
        return previousValue +
            element.when(
              splash: () => '/',
              login: (hasError) => '/${Keys.login}',
              forgotResetPassword: (isForgotPassword, hasError) => '/${Keys.forgotResetPassword}',
              otpVerification: (hasError, email, fromScreen) => '',
              profile: (hasError) => '/${Keys.profile}',
              personalInformation: () => '/${Keys.personalInfo}',
              changeLanguage: () => '/${Keys.changeLanguage}',
              profileSetting: () => '/${Keys.profileSetting}',
              changePassword: () => '/${Keys.changePassword}',
              changeEmail: () => '/${Keys.changeEmail}',
              changeMobile: () => '/${Keys.changeMobile}',
              deleteAccount: () => '/${Keys.deletAccount}',
              coffeeSelection: (hasError) => '/${Keys.coffeeSelection}',
              otpVerificationProfileModule: (email, fromScreen,currentPassword) => '/${Keys.otpVerificationProfile}',

              ///Help And Support
              helpAndSupport: (hasError, ticketId) {
                ref.read(drawerController).updateSelectedScreen(ScreenName.helpSupport, isNotify: false);
                return '/${Keys.helpAndSupport}${ticketId != null ? '?ticketId=$ticketId' : ''}';
              },
              createTicket: (hasError) => '/${Keys.createTicket}',
              ticketChat: (hasError, ticketModel) => '/${Keys.ticketChat}${ticketModel != null ? '?ticketId=${ticketModel.id}' : ''}',

              home: (hasError) {
                ref.read(drawerController).updateSelectedScreen(ScreenName.dashboard, isNotify: false);
                return '/${Keys.home}';
              },
              orderManagement: () => '/${Keys.orderManagement}',
              setting: (hasError) => '/${Keys.setting}',
              services: (hasError) {
                ref.read(drawerController).updateSelectedScreen(ScreenName.services, isNotify: false);
                return '/${Keys.services}';
              },
              deskcleaning: () => '/${Keys.deskcleaning}',
              productManagement: (hasError, productType) {
                ref.read(drawerController).updateSelectedScreen(ScreenName.products, isNotify: false);
                return '/${Keys.productManagement}${productType != null ? '?productType=${productType.name}' : ''}';
              },
              history: (hasError, orderType) {
                ref.read(drawerController).updateSelectedScreen(ScreenName.history, isNotify: false);
                return '/${Keys.history}${orderType != null ? '?historyType=${orderType.name}' : ''}';
              },
              users: (hasError) {
                ref.read(drawerController).updateSelectedScreen(ScreenName.users, isNotify: false);
                return '/${Keys.users}';
              },
              sendService: (isSendService, hasError) => isSendService ? '/${Keys.sendService}' : '/${Keys.receiveService}',
              sendServiceDetail: (isSendService, profileModel) => '/${Keys.sendService}',
              serviceHistory: (profileModel, isSendService) => '/${Keys.serviceHistory}',
              serviceStatus: (request, isSendService, profileModel) => '/${Keys.requestSent}',
              requestSent: () => '/${Keys.requestSent}',

              ///notification
              notification: () => '/${Keys.notification}',

              ///CMS
              cms: (cmsType) => '/${Keys.cms}?type=${getStringFromEnumCMS(cmsType)}',

              /// FAQ
              faq: () => '/${Keys.faq}',
              addSubOperator: (hasError, operatorData, uuid) => uuid != null ? '/${Keys.editSubOperator}?id=$uuid' : '/${Keys.addSubOperator}',

              ///Announcement
              announcement: (hasError) => '/${Keys.announcement}',
              requestSentAnnouncement: () => '/${Keys.requestSentAnnouncement}',
              announcementGetDetails: (announcementGetDetails) => '/${Keys.announcementGetDetails}',
              recycling: (hasError) => '/${Keys.recycling}',
              map: (hasError) => '/${Keys.map}',
              error: (key, errorType) {
                return key == null ? '' : '/$key';
              },

              /// Robot Tray Selection
              robotTraySelection: () {
                ref.read(drawerController).updateSelectedScreen(ScreenName.robotTraySelection, isNotify: false);
                return '/${Keys.robotTraySelection}';
              },

              ///Dispatch order
              dispatchOrder: () {
                ref.read(drawerController).updateSelectedScreen(ScreenName.dispatchOrder, isNotify: false);
                return '/${Keys.dispatchOrder}';
              },

              /// Order
              orderHome: (hasError) {
                ref.read(drawerController).updateSelectedScreen(ScreenName.orderHome, isNotify: false);
                  return '/${Keys.orderHome}';
                },
              myOrder: (hasError, fromScreen, OrderType? type) {
                ref.read(drawerController).updateSelectedScreen(ScreenName.myOrder, isNotify: false);
                return '/${Keys.myOrder}${'?type=${(type ?? OrderType.order).name}'}';
              },
              orderDetails: (hasError, orderId) {
                return '/${Keys.orderDetails}?orderId=$orderId';
              },
              orderFlowStatus: (hasError, orderId) {
                return '/${Keys.orderFlowStatus}?orderId=$orderId';
              },
                orderCustomization: (hasError, fromScreen, productUuid, uuid) {
                  return '/${Keys.orderCustomization}${'?id=$productUuid'}';
                },
              additionalNote: (hasError, additionalNote) => '/${Keys.additionalNote}',
              orderSuccessful: (hasError, fromScreen) => '',
              myTray: (hasError, popCallBack) {

                ref.read(drawerController).updateSelectedScreen(ScreenName.tray, isNotify: false);
               // ref.read(bottomMenuController).updateSelectedScreen(ScreenName.tray, isNotify: false);
                return '/${Keys.myTray}';
              },
              selectLocationDialog: (bool? hasError, String? buttonText, void Function()? onButtonPressed) {
                return '';
              },

            );
      },
    );

    List<String> queryParam = [];
    List<String> tempUrlList = location.toString().split('/');
    tempUrlList.removeAt(0);
    List<String> tempPathList = [];
    for (var element in tempUrlList) {
      tempPathList.add(element.split('?').first);
      if (element.split('?').length > 1) {
        queryParam.add(element.split('?').last);
      }
    }
    String mainUrl = '/${tempPathList.join('/')}${queryParam.isNotEmpty ? '?${queryParam.join('&')}' : ''}';
    Uri routeUrl = Uri.parse(mainUrl);
    return RouteInformation(uri: routeUrl);
  }
}
