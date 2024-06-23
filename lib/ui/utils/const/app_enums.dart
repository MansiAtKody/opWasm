import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';

enum ProductStatusEnum { available, unAvailable }

enum SeeCustomisationEnum { smallMilk, mediumMilk, largeMilk, withoutMilk, almondMilk, soyaMilk, withoutSugar, singleSugar, doubleSugar }

/// From Screen
enum FromScreen { login, resetPassword, forgotPassword ,changeEmail,changeMobile,orderHome,orderCart,myOrder,myTray,none,frequentlyBought, otpVerification}


///cms enum
enum CMSType { termsCondition, privacyPolicy, about,faq, none }


///Enum for empty state
enum EmptyStateFor { orderList, trayList , orderUserDetailsList}

enum UserStatus { active, inactive }

enum AnnouncementsTypeEnum { general, birthdayCelebration, workAnniversary }

enum ScreenName { dashboard, users, services, products, history, recycle, sendService, receiveService, announcement, settings, map, profile, robotTraySelection, helpSupport, coffeeSelection, myOrder,orderHome,tray ,dispatchOrder}

enum OrderType { all, products, services,order,favourite,current,past}

enum RobotAssigned { operator, services }

enum ProductType { all, drinks, snacks }

enum ErrorType { error403, error404, noInternet }

enum DateFilterEnum{ today, yesterday, lastWeek, lastMonth}


enum OrderCustomisationEnum { smallMilk, mediumMilk, largeMilk, withoutMilk, almondMilk, soyaMilk, withoutSugar, singleSugar, doubleSugar }

///Order Statues
enum OrderStatusEnum { PENDING, ACCEPTED, PREPARED, DISPATCH, PARTIALLY_DELIVERED, DELIVERED, REJECTED, CANCELED, IN_TRAY, NONE, OPERATOR_CANCELED , ROBOT_CANCELED}

enum ModuleStatus {notification}

final orderStatusEnumValues = EnumValues({
  OrderStatusEnum.PENDING.name: OrderStatusEnum.PENDING,
  OrderStatusEnum.ACCEPTED.name: OrderStatusEnum.ACCEPTED,
  OrderStatusEnum.PREPARED.name: OrderStatusEnum.PREPARED,
  OrderStatusEnum.DISPATCH.name: OrderStatusEnum.DISPATCH,
  OrderStatusEnum.PARTIALLY_DELIVERED.name: OrderStatusEnum.PARTIALLY_DELIVERED,
  OrderStatusEnum.DELIVERED.name: OrderStatusEnum.DELIVERED,
  OrderStatusEnum.REJECTED.name: OrderStatusEnum.REJECTED,
  OrderStatusEnum.CANCELED.name: OrderStatusEnum.CANCELED,
  OrderStatusEnum.IN_TRAY.name: OrderStatusEnum.IN_TRAY,
  OrderStatusEnum.ROBOT_CANCELED.name: OrderStatusEnum.ROBOT_CANCELED,
  OrderStatusEnum.NONE.name: OrderStatusEnum.NONE,
});


enum TicketStatus { all, pending, resolved, acknowledged }

final ticketStatusString = EnumValues({
  'PENDING': TicketStatus.pending,
  'ACKNOWLEDGED': TicketStatus.acknowledged,
  'RESOLVED': TicketStatus.resolved,
});

final orderEnumValues = EnumValues({
  'products': OrderType.products,
  'services': OrderType.services,
});

final dateFilterEnumValues = EnumValues({
   LocalizationStrings.keyYesterday.localized: DateFilterEnum.yesterday,
   LocalizationStrings.keyToday.localized: DateFilterEnum.today,
  LocalizationStrings.keyLastWeek.localized: DateFilterEnum.lastWeek,
  LocalizationStrings.keyLastMonth.localized: DateFilterEnum.lastMonth
});

final productEnumValues = EnumValues({
  'all': ProductType.all,
  'drinks': ProductType.drinks,
  'snacks': ProductType.snacks,
});

final announcementScreens = EnumValues({
  'General': AnnouncementsTypeEnum.general,
  'Birthday Celebration': AnnouncementsTypeEnum.birthdayCelebration,
  'Work Anniversary': AnnouncementsTypeEnum.workAnniversary,
});


enum RobotTrayStatusEnum { AVAILABLE, PAUSE, SERVING, UNAVAILABLE, IN_CHARGING, EMERGENCY_STOP }

/// Robot Tray Selection Status
final robotTrayStatusValues = EnumValues({
  RobotTrayStatusEnum.AVAILABLE.name : RobotTrayStatusEnum.AVAILABLE,
  RobotTrayStatusEnum.PAUSE.name : RobotTrayStatusEnum.PAUSE,
  RobotTrayStatusEnum.SERVING.name : RobotTrayStatusEnum.SERVING,
  RobotTrayStatusEnum.UNAVAILABLE.name : RobotTrayStatusEnum.UNAVAILABLE,
  RobotTrayStatusEnum.IN_CHARGING.name : RobotTrayStatusEnum.IN_CHARGING,
  RobotTrayStatusEnum.EMERGENCY_STOP.name : RobotTrayStatusEnum.EMERGENCY_STOP,
});

final cmsTypeString = EnumValues({
  'ABOUT_US': CMSType.about,
  'TERMS_AND_CONDITION': CMSType.termsCondition,
  'PRIVACY_POLICY': CMSType.privacyPolicy,
  'FAQ': CMSType.faq,
});

String getStringFromEnumCMS(CMSType cmsType){
  cmsTypeString.reverse;
  return cmsTypeString.reverseMap[cmsType] ?? '';
}

final productStatusValues = EnumValues({
  'Available': ProductStatusEnum.available,
  'Unavailable': ProductStatusEnum.unAvailable,
});

final moduleStatusEnumValues = EnumValues({
  'Notification': ModuleStatus.notification,
});
enum WidgetPropertyEnum {
  widget,
  languageUuid,
  date,
  imageBytes,
  imageUrl,
  selectedValue,
  textEditingController,
  htmlValue,
  htmlEditorController,
}

enum SampleItem { itemOne }

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
