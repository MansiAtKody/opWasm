import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class RobotTrayEmptyTraysWidgetMobile extends StatelessWidget with BaseStatelessWidget {
  final EmptyStateFor emptyStateFor;
  final Color? titleColor;
  final Color? subTitleColor;

  const RobotTrayEmptyTraysWidgetMobile({
    super.key,
    required this.emptyStateFor,
    this.titleColor,
    this.subTitleColor,
  });

  @override
  Widget buildPage(BuildContext context) {
    String imgName = '';
    String title = '';
    String subTitle = '';
    switch (emptyStateFor) {
      case EmptyStateFor.orderList:
        imgName = AppAssets.svgEmptyOrder;
        title = LocalizationStrings.keyEmptyQueue.localized;
        subTitle = LocalizationStrings.keyThereIsNoUpcomingOrderInQueue.localized;
        break;
      case EmptyStateFor.trayList:
        imgName = AppAssets.svgEmptyTrays;
        title = LocalizationStrings.keyEmptyTrays.localized;
        subTitle = LocalizationStrings.keyThereIsNoOrdersInAnyTrays.localized;
        break;
      case EmptyStateFor.orderUserDetailsList:
        imgName = AppAssets.svgEmptyTrays;
        title = LocalizationStrings.keyEmptyOrders.localized;
        subTitle = LocalizationStrings.keyThereIsNoUpcomingOrderInQueue.localized;
        break;
      default:
        // imgName = AppAssets.imgNoErrorKnown;
        title = 'Error Title'.localized;
        subTitle = 'Error Sub Title'.localized;
        break;
    }
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        return Container(
          height: context.height / 1.891,
          decoration: BoxDecoration(
              borderRadius: robotTraySelectionWatch.selectedTrayNumber != 1 && robotTraySelectionWatch.selectedTrayNumber != robotTraySelectionWatch.selectedRobotNew?.numberOfTray
                  ? BorderRadius.circular(20.r)
                  : robotTraySelectionWatch.selectedTrayNumber == 1
                      ? BorderRadius.only(bottomLeft: Radius.circular(20.r), bottomRight: Radius.circular(20.r), topRight: Radius.circular(20.r))
                      : robotTraySelectionWatch.selectedTrayNumber == robotTraySelectionWatch.selectedRobotNew?.numberOfTray
                          ? BorderRadius.only(bottomLeft: Radius.circular(20.r), bottomRight: Radius.circular(20.r), topLeft: Radius.circular(20.r))
                          : BorderRadius.zero,
              color: AppColors.white),
          child: Column(
            children: [
              Expanded(
                  child: Opacity(
                opacity: 0.4,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Empty Trays Image
                      CommonSVG(strIcon: imgName),

                      /// Empty Tray Text
                      CommonText(
                        title: title,
                        textStyle: TextStyles.regular.copyWith(fontSize: 20.sp, color: titleColor ?? AppColors.black1F1E1F),
                      ).paddingOnly(top: 26.h, bottom: 18.h),

                      /// Empty Tray Text
                      CommonText(
                        title: subTitle,
                        maxLines: 2,
                        textStyle: TextStyles.regular.copyWith(fontSize: 15.sp, color: subTitleColor ?? AppColors.grey7E7E7E),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ).paddingOnly(left: 12.w, right: 12.w, bottom: 12.h);
      },
    );
  }
}
