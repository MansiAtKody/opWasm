import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/controller/home/home_controller.dart';
import 'package:kody_operator/ui/drawer/drawer_menu.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class HomeMobile extends ConsumerStatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends ConsumerState<HomeMobile> {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final homeWatch = ref.watch(homeController);
      //homeWatch.disposeController(isNotify : true);
    });
  }

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final homeWatch = ref.watch(homeController);
      final drawerMenuWatch = ref.watch(drawerController);
      return Scaffold(
        key: homeWatch.key,
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
        body: drawerMenuWatch.selectedScreen?.screen,
      );
    });
  }
}
