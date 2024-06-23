import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/ui/auth/web/helper/common_background_container.dart';
import 'package:kody_operator/ui/auth/web/helper/otp_verification_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class OtpVerificationWeb extends ConsumerStatefulWidget {
  final String email;
  final FromScreen fromScreen;
  const OtpVerificationWeb({Key? key, required this.email, required this.fromScreen}) : super(key: key);

  @override
  ConsumerState<OtpVerificationWeb> createState() => _OtpVerificationWebState();
}

class _OtpVerificationWebState extends ConsumerState<OtpVerificationWeb> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final otpVerificationMobileWatch = ref.watch(otpVerificationController);
      otpVerificationMobileWatch.counter?.cancel();
      otpVerificationMobileWatch.startCounter();
      otpVerificationMobileWatch.disposeController(isNotify: true);
    });
  }
  //
  // /// Dispose Override
  // @override
  // void dispose() {
  //   final otpVerificationMobileWatch = ref.watch(otpVerificationController);
  //   otpVerificationMobileWatch.counter?.cancel();
  //   super.dispose();
  // }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return CommonBackGroundContainer(
      child: OtpVerificationHelperWeb(email: widget.email, fromScreen: widget.fromScreen),
    );
  }
}
