import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/language_controller.dart';
import 'package:kody_operator/framework/controller/splash/splash_controller.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:rive/rive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashMobile extends ConsumerStatefulWidget {
  const SplashMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashMobile> createState() => _SplashMobileState();
}

class _SplashMobileState extends ConsumerState<SplashMobile> with BaseConsumerStatefulWidget {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final splashWatch = ref.watch(splashController);
      splashWatch.disposeController(isNotify: true);
      splashWatch.initRive();
      ref.read(languageController).updateInitLanguage(context);

      ///  Notification permission and fcm token generation
      if(!kIsWeb){
        await checkPermissions(context, permission: Permission.notification);
      }
      String? fcmToken;
        try{
          fcmToken = await FirebaseMessaging.instance.getToken();
          if(fcmToken != null){
            await Session.saveLocalData(keyNewFCMToken, fcmToken);
            print('**************This is fcm token:$fcmToken *********');
            print('NEW Token Saved:${Session.getNewFCMToken()} ');

          }
        }catch(e){}

      Future.delayed(const Duration(seconds: 3), (){
        setNavigationRedirection();
      });
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
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
                  Positioned(
                    bottom: 35.h,
                    child: CommonText(
                      title: LocalizationStrings.keyPoweredByKodyTechnolab.localized,
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                ],
              )
            : const Offstage();
      },
    );
  }

  void setNavigationRedirection() {
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

  Future checkPermissions(BuildContext context, {required Permission permission}) async {
    if (await permission.status != PermissionStatus.granted) {
      await permission.request();
    }
  }
}
