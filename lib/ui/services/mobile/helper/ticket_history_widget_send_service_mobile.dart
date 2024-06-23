import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_controller.dart';
import 'package:kody_operator/framework/controller/services/service_list_controller.dart';
import 'package:kody_operator/framework/utility/extension/datetime_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/mobile/helper/common_person_list_tile.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class TicketHistoryWidgetSendServiceMobile extends StatelessWidget with BaseStatelessWidget {
  final bool isSendService;

  const TicketHistoryWidgetSendServiceMobile({super.key, required this.isSendService});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final serviceListWatch = ref.watch(serviceListController);
        final sendServiceListWatch = ref.watch(sendServiceController);
        return serviceListWatch.serviceProfiles.isNotEmpty

            ///Service History List
            ? SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.separated(
                      itemCount: serviceListWatch.serviceProfiles.length,
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SlideLeftTransition(
                          delay: 100,
                          child: InkWell(
                            onTap: () {
                              ref.read(navigationStackProvider).push(NavigationStackItem.serviceHistory(model: serviceListWatch.serviceProfiles[index], isSendService: isSendService));
                            },

                            ///Common Person Tile
                            child: CommonPersonListTile(
                              backgroundColor: AppColors.white,
                              profile: serviceListWatch.serviceProfiles[index],
                              suffix: CommonText(
                                title: DateTime.now().dateOnly,
                                textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.primary2),
                              ).paddingOnly(bottom: 30.h),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider().paddingSymmetric(horizontal: 10.w);
                      },
                    ).paddingSymmetric(vertical: 10.h),
                  ],
                ),
              )

            ///No Services
            : EmptyStateWidget(
                title: LocalizationStrings.keyNoDataFound.localized,
                titleColor: AppColors.black171717,
                subTitle: sendServiceListWatch.searchCtr.text.isNotEmpty ? LocalizationStrings.keyThereIsNoPersonWithSuchName.localized : LocalizationStrings.keyThereIsNoPreviousRequest.localized,
                // emptyStateFor: EmptyState.noData,
              );
      },
    );
  }
}
