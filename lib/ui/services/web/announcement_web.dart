import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_controller.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/web/helper/helper_announcement/announcement_form_web.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar_web.dart';
import 'package:kody_operator/ui/widgets/common_top_back_widget.dart';

class AnnouncementWeb extends ConsumerStatefulWidget {
  const AnnouncementWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<AnnouncementWeb> createState() => _AnnouncementWebState();
}

class _AnnouncementWebState extends ConsumerState<AnnouncementWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final announcementWatch = ref.read(announcementController);
      final announcementGetDetailsWatch = ref.read(announcementGetDetailsController);
      announcementWatch.disposeController(isNotify: true);
      announcementGetDetailsWatch.disposeController(isNotify: true);
      announcementGetDetailsWatch.clearControllers();
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
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Column(
      children: [
        /// Appbar Top Widget
        const CommonAppBarWeb(),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FadeBoxTransition(
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonBackTopWidget(
                          showBackButton: false,
                          title: LocalizationStrings.keyAnnouncementService.localized,
                        ).paddingOnly(left: 38.w, top: 39.h ,bottom: 30.h),
                        Expanded(
                          child: const AnnouncementFormWeb().paddingSymmetric(horizontal: 30.w),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ).paddingOnly(top: 0.h, left: 38.w, right: 38.w, bottom: 38.h),
        ),
      ],
    );
  }
}
