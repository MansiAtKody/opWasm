import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/ui/routing/delegate.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/show_notification_snackbar.dart';


/// Server Key
///AAAAHS9V6H4:APA91bHzP1uOsoQUl9OdFNJYfJvOasfg-pBFWcaUZbGLt3fqYbJsp9oJLvndLSwuyWAbjBUR3tS3Lqv92RO-AOSv67f4KVeX3VQ6hk45lA5nyYmNUxWVHIbysGdHfHcQqYrYPqlKg7if
class FirebasePushNotificationManager {
  FirebasePushNotificationManager._privateConstructor();

  static final FirebasePushNotificationManager instance = FirebasePushNotificationManager._privateConstructor();

  factory FirebasePushNotificationManager() {
    return instance;
  }

  /// Initial code for main.dart void main
  Future<void> setupInteractedMessage(WidgetRef ref) async {

    //enableIOSNotifications();
    await registerNotificationListeners(ref);


  }

  Future<void> registerNotificationListeners(WidgetRef ref) async {
    /// Flutter Local Notification
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Android Setup
    final AndroidNotificationChannel channel = androidNotificationChannel();

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    /// Add Notification app icon
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings(
        'ic_notification_icon');

    // /// Sound and other permissions for IOS Side
    // const DarwinInitializationSettings iOSSettings = DarwinInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );

    /// Initialize Notification for both platform
    const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
    //
    flutterLocalNotificationsPlugin.initialize(initSettings, onDidReceiveNotificationResponse: (payload) async {
      Map<String, dynamic> data = jsonDecode(payload.payload ?? '');
      onReceiveNotification(data, ref);
    });

    ///Received Notification click event after App killed state
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      print('....getInitialMessage from terminated state.....data...........${json.encode(message?.data)}');
      onReceiveNotification(message?.data??{},ref);
    });

    ///Received Notification click event after background notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('....onMessageOpenedApp from background.state...data...........${json.encode(message.data)}');
      onReceiveNotification(message.data,ref);
    });

    /// onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {

      final RemoteNotification? notification = message!.notification;
      final AndroidNotification? android = message.notification?.android;
      final WebNotification? webNotification = message.notification?.web;
      /// If `onMessage` is triggered with a notification, construct our own
      /// local notification to show to users using the created channel.

      if (notification != null && android != null) {
        /// Show customizable Notification Code
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: 'ic_notification_icon',
                  color: Colors.blue,
                sound: const RawResourceAndroidNotificationSound('buzzer_duzzy'),
              ),
            ),
            payload: jsonEncode(message.data));

      }
      else if(notification != null && webNotification!=null){
        print("Web notification we got:$webNotification");
        if(globalNavigatorKey.currentState!.context.isWebScreen){
          showNotificationSnackBar(
              globalNavigatorKey.currentState!.context,
              padding: EdgeInsets.only(left: globalNavigatorKey.currentState!.context.width*0.6,right: globalNavigatorKey.currentState!.context.width*0.04,bottom: globalNavigatorKey.currentState!.context.height*0.05),
              notificationTitle:message.notification?.title , notificationBody: message.notification?.body);
        }else{
          showNotificationSnackBar(globalNavigatorKey.currentState!.context, notificationTitle:message.notification?.title , notificationBody: message.notification?.body);
        }
      }
      print('Hey Hafiza I am getting notification in forground mode ${message.data}');
    });
  }


  /// Android
  AndroidNotificationChannel androidNotificationChannel() =>  const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,

  );

  // Future<void> enableIOSNotifications() async {
  //   await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);
  //
  //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, // Required to display a heads up notification
  //     badge: true,
  //     sound: true,
  //   );
  //   // FirebaseMessaging.
  // }


  void onReceiveNotification(Map<String, dynamic> message, WidgetRef ref) async {
    var module = message['module'] as String?; // Use type annotation to handle null
    String id = message['orderUuid'] as String? ?? '';

    print('---Module from notification json-----$module');
    print('---Orderid from notification json-----$id');

    onMessageNavigation(module??'', ref, id);
  }
  void onMessageNavigation(String moduleName, WidgetRef ref, String? orderUuid, {bool? fromNotificationScreen}) async {
    ModuleStatus? status = moduleStatusEnumValues.map[moduleName];
    switch(status) {
      case ModuleStatus.notification:
        ref.watch(drawerController).updateSelectedScreen(ScreenName.dashboard);
        ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home(),);
        ref.watch(drawerController).key.currentState?.closeDrawer();
        ref.read(navigationStackProvider).push(const NavigationStackItem.notification());
      case null:
        break;

    }

  }
}