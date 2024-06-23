import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/profile/mobile/helper/otp_verification_continue_button_profile.dart';
import 'package:kody_operator/ui/profile/mobile/helper/otp_verification_form_profile.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';

class OtpVerificationProfileModuleMobile extends ConsumerStatefulWidget {
  final String email;
  final FromScreen fromScreen;
  final String? currentPassword;
  const OtpVerificationProfileModuleMobile( {Key? key,required this.email,required this.fromScreen ,this.currentPassword}) : super(key: key);

  @override
  ConsumerState<OtpVerificationProfileModuleMobile> createState() =>
      _OtpVerificationProfileModuleMobileState();
}

class _OtpVerificationProfileModuleMobileState
    extends ConsumerState<OtpVerificationProfileModuleMobile>  with BaseConsumerStatefulWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final otpVerificationMobileWatch = ref.read(otpVerificationController);
      otpVerificationMobileWatch.startCounter();
      otpVerificationMobileWatch.disposeController(isNotify : true);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: (){
        hideKeyboard(context);
      },
      child: Scaffold(
        appBar:CommonAppBar(
          title: LocalizationStrings.keyOtpVerification.localized,
          isLeadingEnable: true,
        ),
        body: _bodyWidget(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final otpVerificationMobileWatch = ref.watch(otpVerificationController);
    return Stack(
      children: [
        CommonWhiteBackground(
          child: Column(
            children:[ Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OtpVerificationFormProfile(email: widget.email, fromScreen: widget.fromScreen,)
                  ],
                )
              ),
            ),
               OtpVerificationProfileBottomButtons(fromScreen: widget.fromScreen, email: widget.email,password: widget.currentPassword??'',).paddingOnly(bottom: buttonBottomPadding)
            ],
          ).paddingSymmetric(horizontal: 20.w),

        ),
        DialogProgressBar(isLoading: otpVerificationMobileWatch.resendOtpState.isLoading,
        forPagination: false)
      ],
    );
  }

}
