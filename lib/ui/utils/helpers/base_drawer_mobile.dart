import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/ui/drawer/drawer_menu.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/blur_background.dart';

mixin BaseDrawerPageWidgetMobile<Page extends StatefulWidget> on State<Page> {
  @override
  Widget build(BuildContext context) {
    
    return Consumer(builder: (context, ref, child) {
      final myOrderWatch = ref.watch(myOrderController);
      bool blurBackground = myOrderWatch.isMenuEnable;
      final drawerWatch = ref.watch(drawerController);
      return Scaffold(
        key: drawerWatch.key,
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20.r), bottomRight: Radius.circular(20.r)),
          child: Drawer(
            elevation: 5.h,
            backgroundColor: AppColors.white,
            shadowColor: AppColors.transparent,
            width: context.width * 0.9,
            child: const DrawerMenu(),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: BlurBackground(blurBackground: blurBackground,
            blurColor: AppColors.grey7E7E7E,child: buildPage(context)),
      );
    });
  }

  Widget buildPage(BuildContext context);
}
