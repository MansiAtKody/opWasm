import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/language_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/profile/web/helper/change_language_tile.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class ChangeLanguage extends ConsumerWidget with BaseConsumerWidget {
  const ChangeLanguage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final languageWatch = ref.watch(languageController);
    return FadeBoxTransition(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightPinkF7F7FC,
          borderRadius: BorderRadius.circular(20.r),
          shape: BoxShape.rectangle,
        ),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return SlideUpTransition(
              delay: (index * 50) + 250,
              child: ChangeLanguageRadioTile(
                groupValue: languageWatch.selectedLanguage,
                value: languageWatch.languages[index],
                onTap: () {
                  languageWatch.changeLanguage(context, index);
                },
              ),
            );
          },
          padding: EdgeInsets.symmetric(horizontal: 43.w),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20.h,
            );
          },
          itemCount: languageWatch.languages.length,
        ).paddingOnly(top: 45.h, bottom: 40.h),
      ),
    );
  }
}
