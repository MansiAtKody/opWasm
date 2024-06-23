import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/delegate.dart';
import 'package:kody_operator/ui/routing/navigation_stack_keys.dart';

class RouteManager {
  ///Singleton Class for [RouteManger]
  RouteManager._();

  ///Instance [route] to call methods for [RouteManager]
  static RouteManager route = RouteManager._();

  ///Path Segments to display a path after removing empty paths
  List<String> pathSegments = [];

  ///To remove any empty path after [/] in Path Segments
  removeEmptyPath(List<String> segments) {
    pathSegments = segments.toList();
    pathSegments.removeWhere((element) => element.trim().isEmpty);
  }

  ///To check if the current route is valid
  Future<RouteValidator> checkPathValidation() {
    ///If mobile then always return true
    if (globalNavigatorKey.currentContext?.isMobileScreen ?? false) {
      return Future.value(RouteValidator(isAuthenticated: true, isRouteValid: true));
    }

    ///If empty then always return true
    if (pathSegments.isEmpty) {
      return Future.value(RouteValidator(isAuthenticated: true, isRouteValid: true));
    }

    ///Create a path without any parameters
    String path = pathSegments.join('/');

    ///Will check authentication
    bool isAuthenticated = /*true*/ Session.getUserAccessToken().isNotEmpty;
    /*if(globalNavigatorKey.currentContext?.isMobileScreen ?? false){
      return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: true));
    }*/

    ///Will check validation and return accordingly
    switch (pathSegments.last) {
      case Keys.splash:
        String validationPath = Keys.splash;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: true, isRouteValid: isRouteValid));
      case Keys.login:
        String validationPath = Keys.login;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: true, isRouteValid: isRouteValid));

      case Keys.forgotResetPassword:
        String validationPath = '${Keys.login}/${Keys.forgotResetPassword}';
        String validationPath2 = Keys.forgotResetPassword;
        bool isRouteValid = path == validationPath || path == validationPath2;
        return Future.value(RouteValidator(isAuthenticated: true, isRouteValid: isRouteValid));

      case Keys.otpVerification:
        String validationPath = '${Keys.login}/${Keys.forgotResetPassword}/${Keys.otpVerification}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: true, isRouteValid: isRouteValid));

      case Keys.cms:
        return Future.value(RouteValidator(isAuthenticated: true, isRouteValid: true));

      case Keys.coffeeSelection:
        return Future.value(RouteValidator(isAuthenticated: true, isRouteValid: true));

      case Keys.profile:
        String validationPath = Keys.profile;
        String validationPath1 = '${Keys.home}/${Keys.profile}';
        bool isRouteValid = path == validationPath || path == validationPath1;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.home:
        String validationPath = Keys.home;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.users:
        String validationPath = Keys.users;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.orderManagement:
        bool isRouteValid = false;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.helpAndSupport:
        String validationPath = Keys.helpAndSupport;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.createTicket:
        String validationPath = Keys.createTicket;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.ticketChat:
        String validationPath = Keys.ticketChat;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.orderStatus:
        bool isRouteValid = false;
        return Future.value(RouteValidator(isAuthenticated: false, isRouteValid: isRouteValid));

      case Keys.setting:
        String validationPath = '${Keys.home}/${Keys.setting}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.changeEmail:
        String validationPath = '${Keys.profile}/${Keys.personalInfo}/${Keys.changeEmail}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

        case Keys.changeMobile:
        String validationPath = '${Keys.profile}/${Keys.personalInfo}/${Keys.changeMobile}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.services:
        String validationPath = Keys.services;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.deskcleaning:
        bool isRouteValid = false;
        return Future.value(RouteValidator(isAuthenticated: false, isRouteValid: isRouteValid));

      case Keys.sendService:
        String validationPath = '${Keys.services}/${Keys.sendService}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.receiveService:
        String validationPath = '${Keys.services}/${Keys.receiveService}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.recycling:
        String validationPath = '${Keys.services}/${Keys.recycling}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.sendServiceDetail:
        bool isRouteValid = false;
        return Future.value(RouteValidator(isAuthenticated: false, isRouteValid: isRouteValid));

      case Keys.announcement:
        String validationPath = '${Keys.services}/${Keys.announcement}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.requestSentAnnouncement:
        bool isRouteValid = false;
        return Future.value(RouteValidator(isAuthenticated: false, isRouteValid: isRouteValid));

      case Keys.announcementGetDetails:
        bool isRouteValid = false;
        return Future.value(RouteValidator(isAuthenticated: false, isRouteValid: isRouteValid));

      case Keys.history:
        String validationPath = Keys.history;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.map:
        String validationPath = '${Keys.home}/${Keys.setting}/${Keys.map}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.robotTraySelection:
        String validationPath = Keys.robotTraySelection;
        String validationPath2 = '${Keys.home}/${Keys.robotTraySelection}';
        bool isRouteValid = path == validationPath || path == validationPath2;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.productManagement:
        String validationPath = Keys.productManagement;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.orderHome:
        String validationPath = Keys.orderHome;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.orderCustomization:
        String validationPath = '${Keys.orderHome}/${Keys.orderCustomization}';
        String validationPath2 = '${Keys.myTray}/${Keys.orderCustomization}';
        String validationPath3 = Keys.orderCustomization;
        bool isRouteValid = path == validationPath || path == validationPath2 || path == validationPath3;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));


      case Keys.orderFlowStatus:
        String validationPath = '${Keys.orderHome}/${Keys.orderFlowStatus}';
        String validationPath2 = '${Keys.myOrder}/${Keys.orderFlowStatus}';
        bool isRouteValid = path == validationPath || path == validationPath2;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.myOrder:
        String validationPath = Keys.myOrder;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.orderDetails:
        String validationPath = '${Keys.myOrder}/${Keys.orderDetails}';
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.myTray:
        String validationPath = '${Keys.orderHome}/${Keys.orderCustomization}/${Keys.myTray}';
        String validationPath2 = '${Keys.orderCustomization}/${Keys.myTray}';
        String validationPath3 = Keys.myTray;
        String validationPath4 = '${Keys.orderHome}/${Keys.myTray}';
        bool isRouteValid = path == validationPath || path == validationPath2 || path == validationPath3 || path == validationPath4;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));

      case Keys.dispatchOrder:
        String validationPath = Keys.dispatchOrder;
        bool isRouteValid = path == validationPath;
        return Future.value(RouteValidator(isAuthenticated: isAuthenticated, isRouteValid: isRouteValid));


      default:
        bool isRouteValid = false;
        return Future.value(RouteValidator(isAuthenticated: false, isRouteValid: isRouteValid));
    }
  }
}

class RouteValidator {
  bool isRouteValid;
  bool isAuthenticated;

  RouteValidator({
    this.isRouteValid = false,
    this.isAuthenticated = false,
  });
}
