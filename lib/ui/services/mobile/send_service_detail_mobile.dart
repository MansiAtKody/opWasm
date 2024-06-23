import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_detail_controller.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/mobile/helper/appbar_bottom_widget_send_service_details_mobile.dart';
import 'package:kody_operator/ui/services/mobile/helper/bottom_widget_send_service_details_mobile.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_sliver_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class SendServiceDetailMobile extends ConsumerStatefulWidget {
  final bool isSendService;
  final ProfileModel profileModel;

  const SendServiceDetailMobile({
    Key? key,
    required this.profileModel,
    required this.isSendService,
  }) : super(key: key);

  @override
  ConsumerState<SendServiceDetailMobile> createState() => _SendServiceDetailMobileState();
}

class _SendServiceDetailMobileState extends ConsumerState<SendServiceDetailMobile> with BaseConsumerStatefulWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final sendServiceDetailWatch = ref.read(sendServiceDetailController);
      sendServiceDetailWatch.disposeController(isNotify: true);
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
    return Scaffold(
      body: CommonSliverAppBar(
        isBorderRadiusEnable: false,
        title: widget.isSendService ? LocalizationStrings.keySendService.localized : LocalizationStrings.keyReceiveService.localized,
        appBarWidget: AppbarBottomWidgetSendServiceDetailsMobile(profileModel: widget.profileModel).paddingOnly(top: 70.h, left: 20.w, right: 20.w),
        expandedHeight: 220.h,
        bodyWidget: GestureDetector(onTap: (){ hideKeyboard(context);}, child: CommonWhiteBackground(child: _bodyWidget())),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final sendServiceDetailWatch = ref.watch(sendServiceDetailController);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: sendServiceDetailWatch.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Removed title field because of design change
                  // SlideLeftTransition(
                  //   delay: 150,
                  //   child: CommonInputFormField(
                  //     backgroundColor: AppColors.transparent,
                  //     textEditingController: sendServiceDetailWatch.titleCtr,
                  //     maxLines: 1,
                  //     textInputType: TextInputType.text,
                  //     textInputAction: TextInputAction.next,
                  //     hintText: LocalizationStrings.keyTitle.localized,
                  //   ).paddingOnly(top: 20.h, right: 20.w, left: 20.w),
                  // ),
                  SlideLeftTransition(
                    delay: 200,
                    child: CommonInputFormField(
                      backgroundColor: AppColors.transparent,
                      textEditingController: sendServiceDetailWatch.msgCtr,
                      maxLines: 5,
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      validator: (value) {
                        return validateText(value, LocalizationStrings.keyMessageMustBeRequired.localized);
                      },
                      onChanged: (value) {
                        sendServiceDetailWatch.checkIfAllFieldsValid();
                      },
                      hintText: LocalizationStrings.keyMessageWithAsterisk.localized,
                    ).paddingOnly(top: 20.h, right: 20.w, left: 20.w),
                  ),
                ],
              ),
            ),
          ),
        ),
        /// Bottom Widget
        BottomWidgetSendServiceDetailsMobile(profileModel: widget.profileModel),
      ],
    );
  }
}
