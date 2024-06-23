import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';

const String keyAppLanguage = 'keyAppLanguage';
const String keyIsOnBoardingShowed = 'keyIsOnBoardingShowed';
const String keyUserAuthToken = 'keyUserAuthToken';
const String keyCoffeeAccessToken = 'keyCoffeeAccessToken';
const String keyUserEmail = 'keyUserEmail';
const String keyUserPassword = 'keyUserPassword';
const String keyDeviceId = 'keyDeviceId';
const String keyUserRefreshToken = 'keyUserRefreshToken';
const String keyDeviceFCMToken = 'keyDeviceFCMToken';
const String keyAppThemeDark = 'keyAppThemeDark';
const String keyLoginResponse = 'keyLoginResponse';
const String keyUserUuid = 'keyUserUuid';
const String keyUuid = 'keyUuid';
const String keyIsOperatorUser = 'keyIsOperatorUser';
const String keyUserEntityId = 'keyUserEntityId';
const String keyUserEntityType = 'keyUserEntityType';
const String keyLocationUuid = 'keyLocationUuid';
const String keyAddedAdditionalNote = 'keyAddedAdditionalNote';
const String keyNewFCMToken = 'keyNewFCMToken';
const String keyOldFCMToken = 'keyOldFCMToken';


class Session {
  Session._();

  static var userBox = Hive.box('userBox');

  static String getUserAccessToken() => (userBox.get(keyUserAuthToken) ?? '');

  static String getCoffeeAccessToken() => (userBox.get(keyCoffeeAccessToken) ?? '');

  static String getOperatorType() => (userBox.get(keyIsOperatorUser) ?? '');

  static String getAppLanguage() => (userBox.get(keyAppLanguage) ?? 'en');

  static bool getIsOnBoardingShowed() => (userBox.get(keyIsOnBoardingShowed) ?? false);

  static String getDeviceID() => (userBox.get(keyDeviceId) ?? '');

  static String getDeviceFCMToken() => (userBox.get(keyDeviceFCMToken) ?? '123456');

  static String getUserEmail() => (userBox.get(keyUserEmail) ?? '');

  static bool? getIsAppThemeDark() => (userBox.get(keyAppThemeDark));

  static String getLoginResponse() => (userBox.get(keyLoginResponse) ?? '');

  static String getUserPassword() => (userBox.get(keyUserPassword) ?? '');

  static String getUserUuid() => (userBox.get(keyUserUuid) ?? '');

  static String getUuid() => (userBox.get(keyUuid) ?? '');

  static int? getUserEntityId() => (userBox.get(keyUserEntityId));

  static String getUserEntityType() => (userBox.get(keyUserEntityType) ?? '');

  static String getLocationUuid() => (userBox.get(keyLocationUuid) ?? '');

  static String getAddedAdditionalNote() => (userBox.get(keyAddedAdditionalNote) ?? '');

  static String getNewFCMToken() => (userBox.get(keyNewFCMToken) ?? '');

  static String getOldFCMToken() => (userBox.get(keyOldFCMToken) ?? '');

  ///Save Local Data
  static saveLocalData(String key, value) {
    userBox.put(key, value);
  }

  ///Save Local Data
  static setIsThemeModeDark(value) {
    userBox.put(keyAppThemeDark, value);
  }

  ///Save Login Response
  static setLoginResponse(value) {
    userBox.put(keyLoginResponse, value);
  }

  ///Session Logout
  static Future sessionLogout(WidgetRef ref) async {
    // String appLanguage = getAppLanguage();
    // String isOnBoarding = getIsOnBoardingShowed();
    // String deviceToken = getDeviceFCMToken();

    await ref.read(profileController).deleteDeviceTokenApi();
    await Session.userBox.clear().then((value) async {
      await Session.saveLocalData(keyIsOnBoardingShowed, true);
       Session.saveLocalData(keyOldFCMToken, '');
      // Session.saveLocalData(showLanguageScreen, false);
      // saveLocalData(KEY_APP_LANGUAGE, appLanguage);
      // saveLocalData(KEY_IS_ONBOARDING_SHOWED, isOnBoarding);
      // saveLocalData(KEY_FCM_DEVICE_TOKEN, deviceToken);
      debugPrint('===========================YOU LOGGED OUT FROM THE APP==============================');
      ref.watch(orderStatusController).socketManager.socket?.disconnect();
      ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.login());
    });
  }
}
