import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_detail_controller.dart';
import 'package:kody_operator/framework/controller/services/service_list_controller.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/repository/service/service_request_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';

class CreateRequestButtonWeb extends ConsumerWidget with BaseConsumerWidget {
  const CreateRequestButtonWeb({
    super.key,
    required this.profile,
  });

  final ProfileModel? profile;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return CommonButton(
      buttonText: LocalizationStrings.keyCreateRequest.localized,
      buttonEnabledColor: AppColors.clr009AF1,
      isButtonEnabled: true,
      height: 50.h,
      buttonTextStyle: TextStyles.regular.copyWith(color: AppColors.white, fontSize: 14.sp),
      width: context.width * 0.1,
      onTap: () async {
        final sendServiceDetailWatch = ref.watch(sendServiceDetailController);
        sendServiceDetailWatch.disposeController(isNotify: true);
        await showAnimatedDialog(
          context,
          onPopCall: (animationController) {
            sendServiceDetailWatch.updateAnimationController(animationController);
          },
          onCloseTap: () {
            sendServiceDetailWatch.animationController?.reverse(from: 0.3);
            Navigator.pop(context);
          },
          heightPercentage: 70,
          widthPercentage: 50,
          title: LocalizationStrings.keyCreateRequest.localized,
          child: _createTicketDialog(),
        );
      },
    );
  }

  Widget _createTicketDialog() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final sendServiceDetailWatch = ref.watch(sendServiceDetailController);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonInputFormField(
                backgroundColor: AppColors.transparent,
                textEditingController: sendServiceDetailWatch.titleCtr,
                maxLines: 1,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                hintText: LocalizationStrings.keyTitle.localized,
                hasLabel: true,
              ),
              CommonInputFormField(
                backgroundColor: AppColors.transparent,
                textEditingController: sendServiceDetailWatch.msgCtr,
                maxLines: 10,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  hideKeyboard(context);
                },
                validator: (value) {
                  return validateText(value, LocalizationStrings.keyMessageMustBeRequired.localized);
                },
                onChanged: (value) {
                  sendServiceDetailWatch.checkIfAllFieldsValid();
                },
                hintText: LocalizationStrings.keyMessageWithAsterisk.localized,
                hasLabel: true,
              ).paddingSymmetric(vertical: 20.h),
              Consumer(
                builder: (context, ref, child) {
                  final sendServiceDetailWatch = ref.watch(sendServiceDetailController);
                  final serviceListWatch = ref.watch(serviceListController);
                  return CommonButton(
                    height: context.height * 0.07,
                    buttonEnabledColor: AppColors.clr009AF1,
                    buttonDisabledColor: AppColors.white,
                    buttonText: LocalizationStrings.keyCreate.localized,
                    buttonTextStyle: TextStyles.regular.copyWith(
                      fontSize: 16.sp,
                      color: sendServiceDetailWatch.isAllFieldsValid ? AppColors.white : AppColors.clr272727,
                    ),
                    isButtonEnabled: sendServiceDetailWatch.isAllFieldsValid,
                    onTap: () {
                      ServiceRequestModel requestModel = ServiceRequestModel(
                        subject: sendServiceDetailWatch.titleCtr.text,
                        message: sendServiceDetailWatch.msgCtr.text,
                        orderId: '#13435435',
                        fromPerson: profile?.name ?? '',
                        toPerson: 'William Sky',
                        itemType: 'Document',
                        orderStatus: 'Delivered',
                        requestDate: DateTime.now(),
                        trayNumber: 01,
                      );
                      serviceListWatch.addRequest(requestModel);
                      if (context.mounted) {
                        showRequestSendDialogWeb(
                          context: context,
                          onButtonTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
