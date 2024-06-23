
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class AdditionalNoteWidget extends StatelessWidget with BaseStatelessWidget {
  final String additionalNote;
  const AdditionalNoteWidget({super.key, required this.additionalNote});

  @override
  Widget buildPage(BuildContext context) {
    return additionalNote.isNotEmpty ?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          title: LocalizationStrings.keyAdditionalNote.localized,
          fontSize: 12.sp,
          clrfont: AppColors.grey7E7E7E,
        ),

        SizedBox(height: 10.h,),

        // CommonContainer(
        //   color: AppColors.lightPinkF7F7FC,
        //   child: CommonText(
        //     title: additionalNote,
        //     fontSize: 12.sp,
        //     maxLines: 50,
        //     clrfont: AppColors.black171717,
        //   ).paddingAll(20.h),
        // )
        CommonText(
            title: additionalNote,
            fontSize: 12.sp,
            maxLines: 50,
            clrfont: AppColors.black171717,
          ).paddingAll(20.h),


      ],
    ).paddingOnly(top: 20.h) : const Offstage();
  }
}
