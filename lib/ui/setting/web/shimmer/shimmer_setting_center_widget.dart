import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/setting/web/shimmer/shimmer_left_button_widget.dart';
import 'package:kody_operator/ui/setting/web/shimmer/shimmer_right_button_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerSettingCenterWidget extends ConsumerWidget with BaseConsumerWidget {
  const ShimmerSettingCenterWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///Left buttons
        Expanded(
            flex: 3,
            child: const ShimmerLeftButtonsWidget().paddingOnly(
              left: 48.w,
            )),

        const Spacer(flex: 1),

        ///Emergency stop button
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.center,
            child: CommonShimmer(
              height: context.height * 0.3,
              width: context.height * 0.3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.black
              ),
            ),
          ),
        ),

        const Spacer(flex: 1),

        ///Right buttons
        Expanded(
          flex: 3,
          child: const ShimmerRightButtonsWidget().paddingOnly(
            right: 48.w,
          ),
        ),
      ],
    );
  }
}
