import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:kody_operator/ui/routing/delegate.dart';
import 'package:kody_operator/ui/routing/parser.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/notification_manager.dart';
import 'package:kody_operator/ui/utils/theme/theme_style.dart';
import 'package:kody_operator/ui/widgets/no_thumb_scroll_indicator.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() async {
  await HiveProvider.init();
  await Hive.openBox('userBox');
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureMainDependencies(environment: Env.dev);

  setPathUrlStrategy();

  /// Initialize firebase app
  await Firebase.initializeApp(
      options: setFirebaseOption()
  );


  /// onBackground message
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi'), Locale('fr'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

/// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Hey  I am getting notification data in background mode ${message.data}');
}
class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      globalRef = ref;
      /// Notification setup method
      FirebasePushNotificationManager.instance.setupInteractedMessage(ref);
    });
  }


  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeStyle.themeData(context),
      routerDelegate: getIt<MainRouterDelegate>(param1: ref.read(navigationStackProvider)),
      routeInformationParser: getIt<MainRouterInformationParser>(param1: ref, param2: context),
    );
  }
}

/// Firebase option set up
setFirebaseOption() {
  if (!kIsWeb) {
    return const FirebaseOptions(
        apiKey: 'AIzaSyAi6Jvm4ewpOXS5_9qDrZj0W_8IZH1teaY', // client api key
        appId: '1:125348210814:android:df1ee1e8adbe286fa5102f', // mobile_sdk_app_id
        messagingSenderId: '125348210814', // project number
        projectId: 'dasher-9a393', //project id
        storageBucket: 'dasher-9a393.appspot.com'
    );
  }
  else {
     return const FirebaseOptions(
      apiKey: 'AIzaSyCtVNdV_9z3OgdesH6ZpDgCcmL7S1AaCZU',
         authDomain: 'dasher-9a393.firebaseapp.com',
        projectId: 'dasher-9a393',
        storageBucket: 'dasher-9a393.appspot.com',
         messagingSenderId: '125348210814',
        appId: '1:125348210814:web:4867a51d80c31f1da5102f',
        measurementId: 'G-VERSXCQPDS'
     );
  }
}