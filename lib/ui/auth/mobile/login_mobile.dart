import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/login_controller.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/auth/mobile/helper/login_bottom_widget.dart';
import 'package:kody_operator/ui/auth/mobile/helper/login_form.dart';
import 'package:kody_operator/ui/auth/mobile/helper/top_widget.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class LoginMobile extends ConsumerStatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends ConsumerState<LoginMobile> {
  ///Init
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final loginWatch = ref.read(loginController);
      loginWatch.disposeController(isNotify : true);
    });
  }

  ///Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.clrEAE9E4,
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: Stack(
          children: [
            TopWidget(
              fromScreen: FromScreen.login,
              strTitle: LocalizationStrings.keyLoginToDasher.localized,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)), color: AppColors.white),
                    height: context.height * 0.4,
                    child: const SingleChildScrollView(child: LoginForm()),
                  ),
                  Container(
                    color: AppColors.white,
                    child: const LoginBottomWidget(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
