import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_detail_controller.dart';
import 'package:kody_operator/framework/controller/services/service_list_controller.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/repository/service/service_request_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';

class BottomWidgetSendServiceDetailsMobile extends StatelessWidget with BaseStatelessWidget{
  final ProfileModel profileModel;
  const BottomWidgetSendServiceDetailsMobile({super.key, required this.profileModel});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final sendServiceWatch = ref.watch(sendServiceDetailController);

      ///Send Service Button
      return SlideUpTransition(
        delay: 100,
        child: CommonButtonMobile(
          buttonText: LocalizationStrings.keySendRequest.localized,
          buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: sendServiceWatch.isAllFieldsValid ? AppColors.white : AppColors.textFieldLabelColor),
          isButtonEnabled: sendServiceWatch.isAllFieldsValid,
          onTap: () {
            if (sendServiceWatch.formKey.currentState!.validate()) {
              // profileModel.addRequest(
              //   ServiceRequestModel(
              //     subject: sendServiceWatch.titleCtr.text,
              //     message: sendServiceWatch.msgCtr.text,
              //     orderId: '#13435435',
              //     fromPerson: profileModel.name,
              //     toPerson: 'William Sky',
              //     itemType: 'Document',
              //     orderStatus: 'Delivered',
              //     requestDate: DateTime.now(),
              //     trayNumber: 01,
              //   ),
              // );
              hideKeyboard(context);
              ref.read(serviceListController).addRequest(
                ServiceRequestModel(
                  subject: sendServiceWatch.titleCtr.text,
                  message:sendServiceWatch. msgCtr.text,
                  orderId: '#13435435',
                  fromPerson: profileModel.name,
                  toPerson: 'William Sky',
                  itemType: 'Document',
                  orderStatus: 'Delivered',
                  requestDate: DateTime.now(),
                  trayNumber: 01,
                ),
              );
              ref.read(sendServiceDetailController).disposeController();
              showCommonSuccessDialogMobile(
                  context: context,
                  anim: AppAssets.animSendDocument,
                  onButtonTap: (){
                    ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.services());
                  }
              );
            }
          },
          rightIcon: Icon(
            Icons.arrow_forward,
            color: sendServiceWatch.isAllFieldsValid
                ? AppColors.white
                : AppColors.textFieldLabelColor,
          ),
        ).paddingAll(10.h),
      );
    },
      
    );
  }
}
