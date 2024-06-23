import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_controller.dart';
import 'package:kody_operator/framework/controller/services/service_list_controller.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/web/helper/common_person_list_tile_web.dart';
import 'package:kody_operator/ui/services/web/helper/search_profile_list.dart';
import 'package:kody_operator/ui/services/web/helper/service_search_bar.dart';

import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';

class SendServiceDetailLeftWidget extends StatelessWidget with BaseStatelessWidget {
  const SendServiceDetailLeftWidget({
    super.key,
    required this.model,
    required this.isSendService,
  });

  final ProfileModel model;
  final bool isSendService;

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final serviceListWatch = ref.watch(serviceListController);
        final sendServiceWatch = ref.watch(sendServiceController);
        return Stack(
          children: [
            Column(
              children: [
                ///Search Bar
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.16,
                  child:  ServiceSearchBar(title:isSendService?
                  LocalizationStrings.keySearchReceiverName.localized:
                  LocalizationStrings.keySearchSenderName.localized).paddingOnly(top: 55.h, bottom: 25.h),
                ),
                serviceListWatch.serviceProfiles.isNotEmpty
                    ///Service History List
                    ? Expanded(
                        child: CommonCard(
                          color: AppColors.clrF7F7FC,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Expanded(
                                child: CommonCard(
                                  color: AppColors.clrF7F7FC,
                                  child: ListView.separated(
                                    itemCount: serviceListWatch.serviceProfiles.length,
                                    padding: EdgeInsets.only(
                                      left: 8.w,
                                      right: 8.w,
                                      bottom: 8.h,
                                    ),
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          ref.read(navigationStackProvider)
                                              .pushRemove(NavigationStackItem.sendServiceDetail(
                                                isSendService: isSendService,
                                                profileModel: serviceListWatch.serviceProfiles[index],
                                              ));
                                        },

                                        ///Common Person Tile
                                        child: CommonPersonListTileWeb(
                                          profile: serviceListWatch.serviceProfiles[index],
                                          isSuffixVisible: false,
                                     /*     suffix: CommonText(
                                            title: DateTime.now().dateOnly,
                                            textStyle: TextStyles.regular.copyWith(
                                              fontSize: 12.sp,
                                              color: AppColors.primary2,
                                            ),
                                          ).paddingOnly(bottom: 30.h, right: 15.w),*/
                                        ),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return SizedBox(height:10.h,);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ///No Services
                    : Expanded(
                        child: CommonCard(
                          color: AppColors.clrF7F7FC,
                          child: Column(
                            children: [
                              CommonPersonListTileWeb(
                                profile: model,
                                isSuffixVisible: false,
                              ).paddingOnly(top: 15.h, bottom: 5.h),
                                SizedBox(
                                 height: 10.h,
                               ).paddingSymmetric(horizontal: 15.h),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  height: 46.h,
                ),
              ],
            ),

            ///Show Searched List
            if (sendServiceWatch.profiles.isNotEmpty) SearchProfileList(isSendService: isSendService),
          ],
        );
      },
    );
  }
}
