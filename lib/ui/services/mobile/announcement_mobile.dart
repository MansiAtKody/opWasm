import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/mobile/helper/common_service_list_tile.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';


class AnnouncementMobile extends ConsumerStatefulWidget {
  const AnnouncementMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<AnnouncementMobile> createState() => _AnnouncementMobileState();
}

class _AnnouncementMobileState extends ConsumerState<AnnouncementMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final announcementWatch = ref.read(announcementController);
      announcementWatch.disposeController(isNotify : true);
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
        appBar: CommonAppBar(
          title: LocalizationStrings.keyAnnouncement.localized,
          isLeadingEnable: true,
        ),
        body: CommonWhiteBackground(height: context.height, child: _bodyWidget()));
  }

  ///Body Widget
  Widget _bodyWidget() {
    final announcementWatch = ref.read(announcementController);
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: announcementWatch.announcementTypesList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = announcementWatch.announcementTypesList[index];

              ///Common List tile for Announcement
              return FadeBoxTransition(
                child: CommonServiceListTile(
                  text: item.announcementTitle,
                  imageAsset: item.announcementSvg,
                  onTap: () {
                    switch (index) {
                      case 0:
                        {
                          /// General Page
                          ref.read(navigationStackProvider).push(const NavigationStackItem.announcementGetDetails(announcementsGetDetails: AnnouncementsTypeEnum.general));
                        }
                        break;
                      case 1:
                        {
                          ///Birthday Celebration Page
                          ref.read(navigationStackProvider).push(const NavigationStackItem.announcementGetDetails(announcementsGetDetails: AnnouncementsTypeEnum.birthdayCelebration));
                        }
                        break;
                      case 2:
                        {
                          ///Work Anniversary Page
                          ref.read(navigationStackProvider).push(const NavigationStackItem.announcementGetDetails(announcementsGetDetails: AnnouncementsTypeEnum.workAnniversary));
                        }
                        break;
                      default:
                        break;
                    }
                  },
                  index: index,
                ).paddingOnly(bottom: 20.h),
              );
            },
          )
        ],
      ),
    ).paddingSymmetric(horizontal: 8.w, vertical: 12.h);
  }
}
