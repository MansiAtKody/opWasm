import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_top_back_widget.dart';

class MapWidget extends ConsumerWidget with BaseConsumerWidget{
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        /// Top Back widget
        CommonBackTopWidget(
          title: LocalizationStrings.keyMap.localized,
          onTap: () {
            ref.read(navigationStackProvider).pop();
          },
        ).paddingOnly(bottom: 30.h),

        ///Map
        Expanded(
          child: Container(
            width: context.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r), color: AppColors.white),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.mapBgColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Image.asset(
                AppAssets.icMap,
              )
            ),
          ).paddingOnly(bottom: 38.h),
        ),
      ],
    ).paddingOnly(top: 38.h, left: 38.w, right: 38.w);
  }
}
