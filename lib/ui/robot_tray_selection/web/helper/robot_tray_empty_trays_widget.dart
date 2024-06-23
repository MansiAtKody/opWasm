import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class RobotTrayEmptyTraysWidget extends StatelessWidget with BaseStatelessWidget {
  final EmptyStateFor emptyStateFor;

  const RobotTrayEmptyTraysWidget({super.key,    required this.emptyStateFor,
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
      default:
      // imgName = AppAssets.imgNoErrorKnown;
        title = 'Error Title'.localized;
        subTitle = 'Error Sub Title'.localized;
        break;
    }
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Opacity(
          opacity: 0.4,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Empty Trays Image
                   CommonSVG(strIcon: imgName),

                  /// Empty Tray Text
                  CommonText(
                    title: title,
                    textStyle: TextStyles.regular.copyWith(fontSize: 20.sp, color: AppColors.black1F1E1F),
                  ).paddingOnly(top: 26.h, bottom: 16.h),

                  /// Empty Tray Text
                  CommonText(
                    title: subTitle,
                    maxLines: 2,
                    textStyle: TextStyles.regular.copyWith(fontSize: 15.sp, color: AppColors.grey7E7E7E),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
