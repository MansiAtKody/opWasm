import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_controller.dart';
import 'package:kody_operator/framework/controller/services/service_list_controller.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/web/helper/common_person_list_tile_web.dart';
import 'package:kody_operator/ui/services/web/helper/search_profile_list.dart';
import 'package:kody_operator/ui/services/web/helper/service_search_bar.dart';
import 'package:kody_operator/ui/utils/anim/slide_vertical_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SendServiceLeftWidget extends ConsumerWidget with BaseConsumerWidget {
  final bool isSendService;
  final ProfileModel? model;

  const SendServiceLeftWidget({
    super.key,
    this.isSendService = false,
    this.model,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    ScrollController serviceHistoryUserListController = ScrollController();
    final sendServiceWatch = ref.watch(sendServiceController);
    final serviceListWatch = ref.watch(serviceListController);
    return Column(
      children: [
        SizedBox(
          width: context.width * 0.2,
          height: context.height * 0.09,
          child: ServiceSearchBar(title: isSendService ? LocalizationStrings.keySearchReceiverName.localized : LocalizationStrings.keySearchSenderName.localized).paddingOnly(bottom: 25.h),
        ),
        Expanded(
          child: Stack(
            children: [
              if (serviceListWatch.serviceProfiles.isNotEmpty)
                SizedBox(
                  height: context.height * 0.6,
                  width: context.width * 0.2,
                  child: CommonCard(
                    child: ListView.separated(
                      controller: serviceHistoryUserListController,
                      itemCount: serviceListWatch.serviceProfiles.length,
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SlideVerticalTransition(
                          delay: 50,
                          isUpSlide: serviceHistoryUserListController.position.userScrollDirection == ScrollDirection.reverse,
                          child: InkWell(
                            onTap: () {
                              serviceListWatch.updateSelectedProfile(serviceListWatch.serviceProfiles[index]);
                            },

                            ///Common Person Tile
                            child: CommonPersonListTileWeb(
                              profile: serviceListWatch.serviceProfiles[index],
                              isSuffixVisible: true,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10.h,
                        );
                      },
                    ),
                  ),
                )
              else
                SizedBox(
                  height: context.height * 0.6,
                  width: context.width * 0.2,
                  child: CommonCard(
                    color: AppColors.clrF7F7FC,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonSVG(
                          strIcon: AppAssets.svgNoServices,
                          width: MediaQuery.sizeOf(context).height * 0.25,
                          height: MediaQuery.sizeOf(context).height * 0.25,
                        ),
                        SizedBox(
                          height: 25.h,
                          width: double.infinity,
                        ),
                        CommonText(
                          title: LocalizationStrings.keyNoDataFound.localized,
                          textAlign: TextAlign.center,
                          textStyle: TextStyles.regular.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.clr272727,
                          ),
                        ).paddingOnly(bottom: 16.h),
                        CommonText(
                          title: sendServiceWatch.searchCtr.text.isNotEmpty ? LocalizationStrings.keyThereIsNoPerson.localized : LocalizationStrings.keyThereIsNoPreviousRequest.localized,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          textStyle: TextStyles.regular.copyWith(
                            color: AppColors.clr272727,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ///List To Be Displayed When Searched
              if (sendServiceWatch.profiles.isNotEmpty) SearchProfileList(isSendService: isSendService),
            ],
          ),
        )
      ],
    );
  }
}
