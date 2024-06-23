import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_bubble_widgets.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class HelpAndSupportFilterWidget extends ConsumerWidget with BaseConsumerWidget {
  const HelpAndSupportFilterWidget({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    return GestureDetector(
      onTap: (){
        helpAndSupportWatch.updateIsPopUpMenuOpen(isPopUpMenuOpen: false);
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.grey7E7E7E.withOpacity(0.2),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.h),
            Container(
              margin: EdgeInsets.only(left: 20.w),
              alignment: Alignment.topRight,
              child: Hero(
                tag: filterHero,
                child: CommonSVG(
                  strIcon: AppAssets.svgTicketFilter,
                  width: 35.h,
                  height: 35.h,
                ).paddingLTRB(0.0, 10.h, 20.w, 0.0),
              ),
            ),
            SizedBox(height: 10.h),
            helpAndSupportWatch.isPopUpMenuOpen ? CommonBubbleWidget(
              positionFromTop: 0.015.sh,
              width: 0.8.sw,
              borderRadius: 20.r,
              height: 0.22.sh,
              positionFromRight: 20.w,
              isBubbleFromLeft: false,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0.025.sh, bottom: 0.025.sh),
                itemCount: helpAndSupportWatch.issueFilterList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      helpAndSupportWatch.updateIsPopUpMenuOpen(isPopUpMenuOpen: false);
                      helpAndSupportWatch.onRadioSelected(index,context);
                      helpAndSupportWatch.resetPaginationTicketList();
                      helpAndSupportWatch.getTicketList(context: context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonSVG(
                          strIcon: helpAndSupportWatch.issueFilterList[index] == helpAndSupportWatch.selectedFilter ? AppAssets.svgRadioSelected : AppAssets.svgRadioUnselected,
                        ).paddingOnly(right: 8.w, top: 2.h),
                        Text(
                          helpAndSupportWatch.issueFilterList[index].title,
                          style: TextStyles.regular,
                        ),
                      ],
                    ).paddingOnly(bottom: 0.02.sh),
                  );
                },
              ).paddingOnly(left: 30.w, right: 30.w, top: 10.h, bottom: 10.h),
            ) : const Offstage(),
          ],
        ),
      ),
    );
  }
}
