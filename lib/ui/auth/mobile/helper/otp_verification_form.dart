import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/otp_verification_controller.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/show_down_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationForm extends ConsumerWidget with BaseConsumerWidget {
  final String email;
  final FromScreen fromScreen;
  const OtpVerificationForm( {super.key, required this.email,required this.fromScreen,});

  @override
  Widget buildPage(BuildContext context, ref) {
    final otpVerificationWatch = ref.watch(otpVerificationController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        CommonText(
          title: LocalizationStrings.keyVerifyOtpDescription.localized,
          textStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.black),
        ),
        CommonText(
          title: email,
          textStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.black, decoration: TextDecoration.underline),
        ),
        SizedBox(height: 20.h),
        ShowDownTransition(
          child: Form(
            key: otpVerificationWatch.formKey,
            child: PinCodeTextField(
              appContext: context,
              autoDisposeControllers: false,
              cursorColor: AppColors.black,
              length: 6,
              focusNode: otpVerificationWatch.focusNode,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
              controller: otpVerificationWatch.otpController,
              keyboardType: TextInputType.number,
              errorTextSpace: 30.h,
              onChanged: (code) {
                otpVerificationWatch.checkIfAllFieldsValid();
              },
              validator: (v) {
                return validateOtp(v);
              },
              textStyle: TextStyles.regular.copyWith(
                color: AppColors.black,
              ),
              onCompleted: (String? code) {
                otpVerificationWatch.checkIfAllFieldsValid();
                // otpVerificationWatch.verifyOtpApi(context, otp: code).then((value){
                //   if (otpVerificationWatch.verifyOtpState.success?.status == ApiEndPoints.apiStatus_200) {
                //     ref.read(navigationStackProvider).push(NavigationStackItem.resetPassword(otp: otpVerificationWatch.otpController.text, email: otpVerificationWatch.emailAddress));
                //   }
                // });
              },
              pinTheme: PinTheme(
                borderRadius: BorderRadius.circular(4.r),
                shape: PinCodeFieldShape.box,
                activeColor: AppColors.textFieldBorderColor,
                inactiveColor: AppColors.textFieldBorderColor,
                selectedColor: AppColors.black,
                errorBorderColor: AppColors.red,
                activeBorderWidth: 1.w,
                selectedBorderWidth: 1.w,
                inactiveBorderWidth: 1.w,
              ),
            ),
          ),
        ),
        SizedBox(height: 25.h),
        RichText(
          text: TextSpan(text: LocalizationStrings.keyNotYourEmail.localized, style: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.black), children: [
            TextSpan(
                text: LocalizationStrings.keyEdit.localized,
                style: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.primary2, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    ref.read(navigationStackProvider).pop();
                  })
          ]),
        )
      ],
    );
  }
}
