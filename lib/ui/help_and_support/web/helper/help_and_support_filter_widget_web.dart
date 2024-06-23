import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class HelpAndSupportFilterWidgetWebIcon extends ConsumerWidget {
  const HelpAndSupportFilterWidgetWebIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helpAndSupportWatch = ref.watch(helpAndSupportController);
    return Consumer(
      builder: (context, ref, child) {
        return PopupMenuButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.expand(
            width: context.width * 0.15,
            height: context.height * 0.3,
          ),
          clipBehavior: Clip.hardEdge,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              ...List<PopupMenuItem>.generate(
                helpAndSupportWatch.issueFilterList.length,
                (index) => PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      helpAndSupportWatch.updateIsPopUpMenuOpen(isPopUpMenuOpen: false);
                      helpAndSupportWatch.onRadioSelected(index,context);
                      helpAndSupportWatch.resetPaginationTicketList();
                      helpAndSupportWatch.getTicketList(context: context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                  ),
                ),
              ),
            ];
          },
          offset: Offset(-1.w, 60.h),
          child: CommonSVG(
            strIcon: AppAssets.svgFilterWithBg,
            height: 50.h,
          ),
        );
      },
    );
  }
}
