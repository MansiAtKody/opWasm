import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/additional_note_controller.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class AdditionalNoteMobile extends ConsumerStatefulWidget {
  final String additionalNote;
  const AdditionalNoteMobile({Key? key,required this.additionalNote}) : super(key: key);

  @override
  ConsumerState<AdditionalNoteMobile> createState() =>
      _AdditionalNoteMobileState();
}

class _AdditionalNoteMobileState extends ConsumerState<AdditionalNoteMobile> with BaseConsumerStatefulWidget{

  TextEditingController additionalNoteCtr = TextEditingController();

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final additionalNoteWatch = ref.read(additionalNoteController);
      if(widget.additionalNote.isNotEmpty){
        additionalNoteCtr.text = widget.additionalNote;
      }
      additionalNoteWatch.disposeController(isNotify : true);
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
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.servicesScaffoldBgColor,
        appBar: CommonAppBar(
          leftImage: CommonSVG(
            strIcon: AppAssets.svgDropDown,
            height: 44.h,
            width: 44.w,
          ).paddingOnly(left: 2.w, right: 2.w, top: 6.h, bottom: 5.h),
          title: LocalizationStrings.keyAdditionalNote.localized,
        ),
        body: _bodyWidget(),
        // bottomNavigationBar: _bottomButton(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: CommonInputFormField(
                textEditingController: additionalNoteCtr,
                hintText: null,
                label: CommonText(title: LocalizationStrings.keyNote.localized,fontSize: 14.sp,clrfont:AppColors.textFieldBorderColor,fontWeight: TextStyles.fwMedium,),
                maxLines: 15,
                textAlignVertical: TextAlignVertical.top,
            ).paddingAll(20.h),
          ),
        ),
        _bottomButton()
      ],
    );
  }

  Widget _bottomButton() {
    final myTrayWatch = ref.watch(myTrayController);
    return CommonButton(
      width: context.width,
      buttonText: LocalizationStrings.keySubmit.localized,
      isButtonEnabled: true,
      rightIcon: const Icon(Icons.arrow_forward,color: AppColors.white,),
      rightIconLeftPadding: 5.w,
      onTap: (){
        hideKeyboard(context);
        myTrayWatch.updateAdditionalNoteText(additionalNoteCtr.text.toString());
        Session.saveLocalData(keyAddedAdditionalNote, additionalNoteCtr.text.toString());
        ref.read(navigationStackProvider).pop();
      },
    ).paddingSymmetric(horizontal: 20.w,vertical: 20.h);
  }


}
