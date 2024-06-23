import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/change_password_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class ChangePasswordForm extends ConsumerWidget with BaseConsumerWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget buildPage(BuildContext context,ref) {
    final changePasswordWatch = ref.watch(changePasswordController);
    return Form(
      key: changePasswordWatch.formKey,
      child: Column(
        children: [

        /// Current Password
        SlideLeftTransition(
        delay: 100,
        child: CommonInputFormField(
          obscureText: !changePasswordWatch.isShowCurrentPassword,
          textEditingController: changePasswordWatch.currentPasswordController,
          maxLength: 16,
          hintText: LocalizationStrings.keyCurrentPassword.localized,
          labelText: LocalizationStrings.keyCurrentPassword.localized,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (password){
            FocusScope.of(context).nextFocus();
            FocusScope.of(context).nextFocus();
          },
          textInputFormatter: [
            FilteringTextInputFormatter.deny(RegExp('[ ]')),
          ],
          validator: (password) {
            return validatePassword(password);
          },
          onChanged: (password) {
            changePasswordWatch.checkIfAllFieldsValid();
          },
          suffixWidget: IconButton(
            onPressed: () {
              changePasswordWatch.changeCurrentPasswordVisibility();
            },
            icon: CommonSVG(
              strIcon: changePasswordWatch.isShowCurrentPassword ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
            ),
          ),
        ),
      ).paddingOnly(bottom: 30.h),

      /// New Password
      SlideLeftTransition(
        delay: 150,
        child: CommonInputFormField(
          obscureText: !changePasswordWatch.isShowNewPassword,
          textEditingController: changePasswordWatch.newPasswordController,
          maxLength: 16,
          hintText: LocalizationStrings.keyNewPassword.localized,
          labelText:LocalizationStrings.keyNewPassword.localized,
          textInputAction: TextInputAction.next,
          textInputFormatter: [
            FilteringTextInputFormatter.deny(RegExp('[ ]')),
          ],
          onFieldSubmitted: (password){
            FocusScope.of(context).nextFocus();
            FocusScope.of(context).nextFocus();
          },
          validator: (password) {
            if (password != null && password.length > 7 && password == changePasswordWatch.currentPasswordController.text) {
              return LocalizationStrings.keyNewPasswordValidation.localized;
            }
            return validateNewPassword(password);
          },
          onChanged: (password) {
            changePasswordWatch.checkIfAllFieldsValid();
          },
          suffixWidget: IconButton(
            onPressed: () {
              changePasswordWatch.changeNewPasswordVisibility();
            },
            icon: CommonSVG(
              strIcon: changePasswordWatch.isShowNewPassword ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
            ),
          ),
        ),
      ).paddingOnly(bottom: 30.h),

      /// Confirm Password
      SlideLeftTransition(
        delay: 200,
        child: CommonInputFormField(
          obscureText: !changePasswordWatch.isShowConfirmPassword,
          textEditingController: changePasswordWatch.confirmPasswordController,
          maxLength: 16,
          hintText: LocalizationStrings.keyConfirmPassword.localized,
          labelText: LocalizationStrings.keyConfirmPassword.localized,
          textInputAction: TextInputAction.done,
          textInputFormatter: [
            FilteringTextInputFormatter.deny(RegExp('[ ]')),
          ],
          onFieldSubmitted: (value){
            hideKeyboard(context);
          },
          validator: (password) {

              return validateConfirmPassword(password,changePasswordWatch.newPasswordController.text);
          },
          onChanged: (password) {
            changePasswordWatch.checkIfAllFieldsValid();
          },
          suffixWidget: IconButton(
            onPressed: () {
              changePasswordWatch.changeConfirmPasswordVisibility();
            },
            icon: CommonSVG(
              strIcon: changePasswordWatch.isShowConfirmPassword ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
            ),
          ),
        ),),

        ],
      ),
    );
  }
}
