import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/services/mobile/helper/bottom_widget_announcement_get_details.dart';
import 'package:kody_operator/ui/services/mobile/helper/center_widget_announcement_get_details.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class AnnouncementGetDetailsMobile extends ConsumerStatefulWidget {
  final AnnouncementsTypeEnum appBarTitle;

  const AnnouncementGetDetailsMobile({
    Key? key,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  ConsumerState<AnnouncementGetDetailsMobile> createState() =>
      _AnnouncementGetDetailsMobileState();
}

class _AnnouncementGetDetailsMobileState
    extends ConsumerState<AnnouncementGetDetailsMobile>
    with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final announcementGetDetailsWatch =
          ref.read(announcementGetDetailsController);
      announcementGetDetailsWatch.disposeController(isNotify: true);
      Future.delayed(const Duration(milliseconds: 100), () {
        announcementGetDetailsWatch.disposeFormKey();
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(
        title: announcementScreens.reverse[widget.appBarTitle]!,
        isLeadingEnable: true,
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: _bodyWidget()),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return CommonWhiteBackground(
      child: Column(
        children: [
          ///Center Widget
          Expanded(
              child: SingleChildScrollView(
                  child: CenterWidgetAnnouncementGetDetails(
                          appBarTitle: widget.appBarTitle)
                      .paddingOnly(left: 20.w, right: 20.w, bottom: 36.h))),

          ///bottom widget
          BottomWidgetAnnouncementGetDetails(appBarTitle: widget.appBarTitle)
        ],
      ),
    );
  }
}
