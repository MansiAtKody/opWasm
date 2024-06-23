import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/robot_tray_selection/web/helper/order_details_widget.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class RobotTrayDetailsDataWidget extends StatelessWidget with BaseStatelessWidget {
  const RobotTrayDetailsDataWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final robotTraySelectionWatch = ref.watch(robotTraySelectionController);
        /// Add Items Into Tray Button
        return FadeBoxTransition(
          onPopCall: (orderBoxAnimationController) {
            robotTraySelectionWatch.updateOrderBoxAnimationController(orderBoxAnimationController);
          },
          child: const OrderDetailsWidget(),
        ).paddingOnly(left: 30.w, top: 20.h);
      },
    );
  }


}
