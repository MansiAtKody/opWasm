import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/language_controller.dart';
import 'package:kody_operator/framework/controller/splash/splash_controller.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:rive/rive.dart';

class SplashWeb extends ConsumerStatefulWidget {
  const SplashWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashWeb> createState() => _SplashWebState();
}

class _SplashWebState extends ConsumerState<SplashWeb> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final splashWatch = ref.watch(splashController);
      splashWatch.disposeController(isNotify: true);
      splashWatch.initRive();
      ref.read(languageController).updateInitLanguage(context);
      String? fcmToken;
      try{
        fcmToken = await FirebaseMessaging.instance.getToken();
        if(fcmToken != null){
          await Session.saveLocalData(keyNewFCMToken, fcmToken);
        }
      // ignore: empty_catches
      }catch(e){}
      Future.delayed(const Duration(seconds: 3), () {
        setNavigationRedirection();
      });
    });
  }

  void setNavigationRedirection() async {
    if (mounted) {
      final splashWatch = ref.watch(splashController);
      splashWatch.timer?.cancel();
      if (Session.getUserAccessToken().isNotEmpty) {
        ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
      } else {
        ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.login());
      }
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final splashWatch = ref.watch(splashController);
        return splashWatch.avatar != null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Rive(artboard: splashWatch.avatar!.artBoard),
                ],
              )
            : const Offstage();
      },
    );
  }
}
