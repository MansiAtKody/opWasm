import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/additional_note_controller.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/my_tray/web/helper/additional_note_bottom_widget.dart';
import 'package:kody_operator/ui/my_tray/web/helper/additional_note_widget.dart';

class AddedAdditionalNoteWidgetWeb extends ConsumerWidget {
  const AddedAdditionalNoteWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final myTrayWatch = ref.watch(myTrayController);
    final additionalNoteWatch = ref.read(additionalNoteController);
    return  myTrayWatch.additionalNoteText.isNotEmpty
          ? Container(
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.white
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonText(
                  title: LocalizationStrings.keyAdditionalNote.localized,
                  clrfont: AppColors.greyA3A3A3,
                  fontSize: 18.sp,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
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
                  },
                  child: CommonText(
                    title: LocalizationStrings.keyEdit.localized,
                    clrfont: AppColors.primary2,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CommonText(
              title: myTrayWatch.additionalNoteText,
              maxLines: 50,
              fontSize: 16.sp,
            ),
          ],
        ).paddingAll(20.h),
      ).paddingSymmetric(horizontal: 20.w)
          : const Offstage();
    }
}
