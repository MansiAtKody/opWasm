import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/profile/mobile/helper/delete_account_form_widget.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/framework/controller/profile/delete_account_controller.dart';

class DeleteAccountMobile extends ConsumerStatefulWidget {
  const DeleteAccountMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<DeleteAccountMobile> createState() =>
      _DeleteAccountMobileState();
}

class _DeleteAccountMobileState extends ConsumerState<DeleteAccountMobile> with BaseConsumerStatefulWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final deleteAccountWatch = ref.read(deleteAccountController);
      deleteAccountWatch.disposeController(isNotify : true);
      deleteAccountWatch.disposeFormKey();
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
        appBar: CommonAppBar(
          isLeadingEnable: true,
          title: LocalizationStrings.keyDeleteAccount.localized,
        ),
        body: _bodyWidget(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return CommonWhiteBackground(
        child:
        Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: const DeleteAccountFormWidget().paddingOnly(top: 23.h),
        )),
            _bottomWidget()
      ],
    ).paddingSymmetric(horizontal:12.w));
  }

  ///bottom widget
  Widget _bottomWidget() {
    return SlideUpTransition(
      delay: 150,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final deleteAccountWatch = ref.watch(deleteAccountController);
          return CommonButtonMobile(
            onValidateTap: () {
              deleteAccountWatch.formKey.currentState?.validate();
            },
            onTap: () {
              if (deleteAccountWatch.formKey.currentState?.validate() ?? false) {
                Session.sessionLogout(ref);
              }
            },
            buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: deleteAccountWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
            buttonText: LocalizationStrings.keySubmit.localized,
            rightIcon: Icon(Icons.arrow_forward, color: deleteAccountWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
            isButtonEnabled: deleteAccountWatch.isAllFieldsValid,
          ).paddingOnly(bottom: buttonBottomPadding);
        },
      ),
    );
  }

}
