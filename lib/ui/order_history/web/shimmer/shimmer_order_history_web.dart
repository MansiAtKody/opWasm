import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/order_history/web/shimmer/shimmer_center_widget.dart';
import 'package:kody_operator/ui/order_history/web/shimmer/shimmer_top_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class ShimmerOrderHistoryWeb extends StatelessWidget with BaseStatelessWidget {
  const ShimmerOrderHistoryWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return const Column(
      children: [
        /// Shimmer Top Widget
        ShimmerTopWidget(),
        Expanded(
          child: ShimmerCenterWidget(),
        ),
      ],
    ).paddingOnly(left: 38.w, top: 34.h, right: 35.w);
  }
}
