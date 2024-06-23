import 'package:kody_operator/framework/controller/my_tray/additional_note_controller.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_tray/web/helper/additional_note_bottom_widget.dart';
import 'package:kody_operator/ui/my_tray/web/helper/additional_note_widget.dart';
import 'package:kody_operator/ui/my_tray/web/helper/common_more_item.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class AddMoreAdditionalNoteWidget extends ConsumerWidget with BaseConsumerWidget {
  const AddMoreAdditionalNoteWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    final myTrayWatch = ref.watch(myTrayController);
    final additionalNoteWatch = ref.watch(additionalNoteController);
    return Row(
      children: [
        CommonText(
          title:  LocalizationStrings.keyTray.localized,
          textStyle: TextStyles.regular.copyWith(
            fontSize: 24.sp,
            color: AppColors.black
          ),
        ),
        const Spacer(flex: 4,),


        myTrayWatch.additionalNoteText.isEmpty?CommonMoreItem(
            icon: AppAssets.svgAdditionalNote,
            title: LocalizationStrings.keyAdditionalNote.localized,
            onTap: (){
              showCommonWebDialog2(
                  context: context,
                  topText: LocalizationStrings.keyAdditionalNote.localized,
                  widget: const AdditionalNoteWidget(),
                  buttonWidget: const AdditionalNoteBottomWidget(),
                  onTapCrossIconButton: (){
                    additionalNoteWatch.disposeController(isNotify: true);
                    Navigator.of(context).pop();
                  }
              );
            }
        ): const Offstage(),

        SizedBox(width: 20.w,),


        CommonMoreItem(
            icon: AppAssets.svgAddMore,
            title: LocalizationStrings.keyAddMoreItems.localized,
            onTap: (){
              ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.orderHome());
            }
        ),
      ],
    ).paddingSymmetric(horizontal: 20.w,vertical: 20.h);
  }
}
