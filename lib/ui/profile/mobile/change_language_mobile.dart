import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/change_language_controller.dart';
import 'package:kody_operator/framework/controller/profile/language_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/profile/mobile/helper/shimmer_change_language_mobile.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/ui/widgets/radio_button/common_radio_button.dart';

class ChangeLanguageMobile extends ConsumerStatefulWidget {
  const ChangeLanguageMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangeLanguageMobile> createState() => _ChangeLanguageMobileState();
}

class _ChangeLanguageMobileState extends ConsumerState<ChangeLanguageMobile>
    with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final changeLanguageWatch = ref.read(changeLanguageController);
      changeLanguageWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(seconds: 3), () {
        changeLanguageWatch.updateLoadingStatus(false);
      });
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
    final changeLanguageWatch = ref.watch(changeLanguageController);
    return Scaffold(
      appBar: CommonAppBar(
        isLeadingEnable: true,
        title: LocalizationStrings.keyChangeLanguage.localized,
      ),
      body: changeLanguageWatch.isLoading
          ? const ShimmerChangeLanguageMobile()
          : _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final languageWatch = ref.watch(languageController);
    return CommonWhiteBackground(
      child: Column(
        children: [
          ///Main Content
          Container(
            decoration: BoxDecoration(
                color: AppColors.lightPink,
                borderRadius: BorderRadius.circular(20.r)),
            child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return SlideLeftTransition(
                        delay: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// Change Language Radio Buttons
                            CommonRadioButton(
                              value: languageWatch.languages[index].name,
                              groupValue: languageWatch.selectedLanguage?.name,
                              icon: AppAssets.svgLanguage,
                              iconColor:
                                  languageWatch.languages[index] ==
                                          languageWatch.selectedLanguage
                                      ? AppColors.blue009AF1
                                      : AppColors.black,
                              onTap: () {
                                languageWatch.changeLanguage(context, index);
                                },

                            ).paddingSymmetric(vertical: 17.h),
                          ],
                        ).paddingSymmetric(horizontal: 20.w),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider().paddingSymmetric(horizontal: 20.w),
                    itemCount: languageWatch.languages.length,
                ).paddingSymmetric(vertical: 10.h),
          ).paddingAll(12.h),
        ],
      ),
    );
  }
}
