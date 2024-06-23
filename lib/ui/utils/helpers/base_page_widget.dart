import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/drawer/expanded_drawer_web.dart';
import 'package:kody_operator/ui/widgets/drawer/small_drawer_web.dart';

mixin BaseDrawerPageWidget<Page extends StatefulWidget> on State<Page> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final drawerWatch = ref.watch(drawerController);
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.black,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: (drawerWatch.isExpanded) ? 2 : 1,
              child:

                  ///Left Widget
                  (drawerWatch.isExpanded) ? const ExpandedDrawerWeb() : const SmallDrawerWeb(),
            ),

            ///Right Widget
            Expanded(
              flex: 12,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r), color: AppColors.lightPink),
                child: buildPage(context),
              ).paddingOnly(left: 11.w, right: 42.w, bottom: 45.h, top: 45.h),
            ),
          ],
        ),
      );
    });
  }

  Widget buildPage(BuildContext context);
}
