import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/login_controller.dart';
import 'package:kody_operator/framework/controller/cms/cms_controller.dart';
import 'package:kody_operator/ui/auth/web/helper/common_background_container.dart';
import 'package:kody_operator/ui/auth/web/helper/common_login_container.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';

class LoginWeb extends ConsumerStatefulWidget {
  const LoginWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends ConsumerState<LoginWeb> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final loginWatch = ref.read(loginController);
      loginWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(milliseconds: 100), () {
        loginWatch.disposeFormKey();
      });
    });
  }

  @override
  void didUpdateWidget(covariant LoginWeb oldWidget) {
    final loginWatch = ref.watch(loginController);
    loginWatch.disposeController(isNotify: true);
    Future.delayed(const Duration(milliseconds: 100), () {
      loginWatch.disposeFormKey();
    });
    super.didUpdateWidget(oldWidget);
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: bodyWidget(),
    );
  }

  ///Body Widget
  Widget bodyWidget() {
    return Stack(
      children: [
        const CommonBackGroundContainer(
          fromScreen: FromScreen.login,
          child: CommonLoginContainer(),
        ),
        DialogProgressBar(isLoading: ref.watch(cmsController).cmsState.isLoading),
      ],
    );
  }
}
