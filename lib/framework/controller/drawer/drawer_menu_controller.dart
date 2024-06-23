import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/repository/home/home_menu_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/dispatched_order/dispatched_order.dart';
import 'package:kody_operator/ui/help_and_support/help_and_support.dart';
import 'package:kody_operator/ui/my_order/my_order.dart';
import 'package:kody_operator/ui/my_order/order_home.dart';
import 'package:kody_operator/ui/order_history/order_history.dart';
import 'package:kody_operator/ui/order_management/order_management.dart';
import 'package:kody_operator/ui/product_management/product_management.dart';
import 'package:kody_operator/ui/profile/profile.dart';
import 'package:kody_operator/ui/robot_tray_selection/robot_tray_selection.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/user_management/user_management.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';

final drawerController = ChangeNotifierProvider((ref) => getIt<DrawerController>());

@injectable
class DrawerController extends ChangeNotifier {
  ///Update Selected Screen
  updateSelectedScreen(ScreenName screenName, {bool? isNotify}) {
    selectedScreen = homeMenuList.where((element) => element.screenName == screenName).firstOrNull;
    for (var element in homeMenuList) {
      element.isExpanded = false;
    }
    if (isNotify ?? true) {
      notifyListeners();
    }
  }

  ///Key for drawer
  final GlobalKey<ScaffoldState> key = GlobalKey();

  ///Selected Screen
  HomeMenuOperator? selectedScreen;

  List<HomeMenuOperator> homeMenuList = [
    HomeMenuOperator(
      menuName: LocalizationStrings.keyDashboard.localized,
      strIcon: AppAssets.svgOrderManage,
      isExpanded: false,
      screenName: ScreenName.dashboard,
      parentScreen: ScreenName.dashboard,
      screen: const OrderManagement(),
      item: const NavigationStackItem.home(),
    ),
    HomeMenuOperator(
      menuName: LocalizationStrings.keyRobotAndTraySelection.localized,
      strIcon: AppAssets.svgRobotTraySelection,
      isExpanded: false,
      screenName: ScreenName.robotTraySelection,
      parentScreen: ScreenName.robotTraySelection,
      screen: const RobotTraySelection(),
      item: const NavigationStackItem.robotTraySelection(),
    ),
    HomeMenuOperator(
      menuName: LocalizationStrings.keyOrderDispatched.localized,
      strIcon: AppAssets.svgOrderManage,
      isExpanded: false,
      screenName: ScreenName.dispatchOrder,
      parentScreen: ScreenName.dispatchOrder,
      screen: const DispatchedOrder(),
      item: const NavigationStackItem.dispatchOrder(),
    ),
    HomeMenuOperator(
      menuName: LocalizationStrings.keyOrder.localized,
      strIcon: AppAssets.svgOrderHome,
      isExpanded: false,
      screenName: ScreenName.orderHome,
      parentScreen: ScreenName.orderHome,
      screen: const OrderHome(),
      item: const NavigationStackItem.orderHome(),
    ),
    HomeMenuOperator(
      menuName: LocalizationStrings.keyMyOrder.localized,
      strIcon: AppAssets.svgMyOrder,
      isExpanded: false,
      screenName: ScreenName.myOrder,
      parentScreen: ScreenName.myOrder,
      screen: const MyOrder(),
      item: const NavigationStackItem.myOrder(),
    ),
    HomeMenuOperator(
      menuName: LocalizationStrings.keyMyTray.localized,
      strIcon: AppAssets.svgMyTray,
      isExpanded: false,
      screenName: ScreenName.tray,
      parentScreen: ScreenName.tray,
      screen: const OrderHome(),
      item: const NavigationStackItem.myTray(),
    ),
    HomeMenuOperator(
      menuName: LocalizationStrings.keyUsers.localized,
      strIcon: AppAssets.svgUsers,
      isExpanded: false,
      screenName: ScreenName.users,
      parentScreen: ScreenName.users,
      screen: const UserManagement(),
      item: const NavigationStackItem.users(),
    ),

    ///Do not Remove this code
    /*HomeMenuOperator(
      menuName: LocalizationStrings.keyServices.localized,
      dropDownList: [
        HomeMenuSubScreen(
          title: LocalizationStrings.keyAnnouncement.localized,
          item: const NavigationStackItem.announcement(),
          screenName: ScreenName.announcement,
        ),
        HomeMenuSubScreen(
          title: LocalizationStrings.keyRecycleService.localized,
          item: const NavigationStackItem.recycling(),
          screenName: ScreenName.recycle,
        ),
        HomeMenuSubScreen(
          title: LocalizationStrings.keyReceiveService.localized,
          item: const NavigationStackItem.sendService(isSendService: false),
          screenName: ScreenName.receiveService,
        ),
        HomeMenuSubScreen(
          title: LocalizationStrings.keySendService.localized,
          item: const NavigationStackItem.sendService(isSendService: true),
          screenName: ScreenName.sendService,
        )
      ],
      strIcon: AppAssets.svgService,
      isExpanded: false,
      screenName: ScreenName.services,
      parentScreen: ScreenName.services,
      screen: const Services(),
      item: const NavigationStackItem.services(),
    ),*/
    HomeMenuOperator(
      menuName: LocalizationStrings.keyProducts.localized,
      strIcon: AppAssets.svgProductManage,
      isExpanded: false,
      screenName: ScreenName.products,
      parentScreen: ScreenName.products,
      screen: const ProductManagement(),
      item: const NavigationStackItem.productManagement(),
    ),
    HomeMenuOperator(
      menuName: LocalizationStrings.keyHistory.localized,
      strIcon: AppAssets.svgHistory,
      isExpanded: false,
      screenName: ScreenName.history,
      parentScreen: ScreenName.history,
      screen: const OrderHistory(),
      item: const NavigationStackItem.history(orderType: OrderType.products),
    ),
    HomeMenuOperator(
      menuName: LocalizationStrings.keySupportAndHelp.localized,
      strIcon: AppAssets.svgDrawerSelectedHns,
      isExpanded: false,
      screenName: ScreenName.helpSupport,
      parentScreen: ScreenName.helpSupport,
      screen: const HelpAndSupport(),
      item: const NavigationStackItem.helpAndSupport(),
    ),
    // HomeMenuOperator(
    //   menuName: 'Coffee Selection',
    //   strIcon: AppAssets.svgProductManage,
    //   isExpanded: false,
    //   screenName: ScreenName.coffeeSelection,
    //   parentScreen: ScreenName.coffeeSelection,
    //   screen: const SelectCoffeeScreen(),
    //   item: const NavigationStackItem.coffeeSelection(),
    // ),
    HomeMenuOperator(
      menuName: LocalizationStrings.keyProfile.localized,
      strIcon: AppAssets.svgProfileUser,
      isExpanded: false,
      screenName: ScreenName.profile,
      parentScreen: ScreenName.profile,
      screen: const Profile(),
      item: const NavigationStackItem.profile(),
    ),
  ];

  // initHomeMenuList() {
  //   homeMenuList = [
  //     HomeMenuOperator(
  //       menuName: LocalizationStrings.keyDashboard.localized,
  //       strIcon: AppAssets.svgOrderManage,
  //       isExpanded: false,
  //       screenName: ScreenName.dashboard,
  //       parentScreen: ScreenName.dashboard,
  //       screen: const OrderManagement(),
  //       item: const NavigationStackItem.home(),
  //     ),
  //     HomeMenuOperator(
  //       menuName: LocalizationStrings.keyUsers.localized,
  //       strIcon: AppAssets.svgUsers,
  //       isExpanded: false,
  //       screenName: ScreenName.users,
  //       parentScreen: ScreenName.users,
  //       screen: const UserManagement(),
  //       item: const NavigationStackItem.users(),
  //     ),
  //     HomeMenuOperator(
  //       menuName: LocalizationStrings.keyServices.localized,
  //       dropDownList: [
  //         HomeMenuSubScreen(
  //           title: LocalizationStrings.keyAnnouncement.localized,
  //           item: const NavigationStackItem.announcement(),
  //           screenName: ScreenName.announcement,
  //         ),
  //         HomeMenuSubScreen(
  //           title: LocalizationStrings.keyRecycleService.localized,
  //           item: const NavigationStackItem.recycling(),
  //           screenName: ScreenName.recycle,
  //         ),
  //         HomeMenuSubScreen(
  //           title: LocalizationStrings.keyReceiveService.localized,
  //           item: const NavigationStackItem.sendService(isSendService: false),
  //           screenName: ScreenName.receiveService,
  //         ),
  //         HomeMenuSubScreen(
  //           title: LocalizationStrings.keySendService.localized,
  //           item: const NavigationStackItem.sendService(isSendService: true),
  //           screenName: ScreenName.sendService,
  //         )
  //       ],
  //       strIcon: AppAssets.svgService,
  //       isExpanded: false,
  //       screenName: ScreenName.services,
  //       parentScreen: ScreenName.services,
  //       screen: const Services(),
  //       item: const NavigationStackItem.services(),
  //     ),
  //     HomeMenuOperator(
  //       menuName: LocalizationStrings.keyProducts.localized,
  //       strIcon: AppAssets.svgProductManage,
  //       isExpanded: false,
  //       screenName: ScreenName.products,
  //       parentScreen: ScreenName.products,
  //       screen: const ProductManagement(),
  //       item: const NavigationStackItem.productManagement(),
  //     ),
  //     HomeMenuOperator(
  //       menuName: LocalizationStrings.keyHistory.localized,
  //       strIcon: AppAssets.svgHistory,
  //       isExpanded: false,
  //       screenName: ScreenName.history,
  //       parentScreen: ScreenName.history,
  //       screen: const OrderHistory(),
  //       item: const NavigationStackItem.history(),
  //     ),
  //     HomeMenuOperator(
  //       menuName: LocalizationStrings.keyRobotAndTraySelection.localized,
  //       strIcon: AppAssets.svgRobotTraySelection,
  //       isExpanded: false,
  //       screenName: ScreenName.robotTraySelection,
  //       parentScreen: ScreenName.robotTraySelection,
  //       screen: const RobotTraySelection(),
  //       item: const NavigationStackItem.robotTraySelection(),
  //     ),
  //     HomeMenuOperator(
  //       menuName: LocalizationStrings.keySupportAndHelp.localized,
  //       strIcon: AppAssets.svgDrawerSelectedHns,
  //       isExpanded: false,
  //       screenName: ScreenName.helpSupport,
  //       parentScreen: ScreenName.helpSupport,
  //       screen: const HelpAndSupport(),
  //       item: const NavigationStackItem.helpAndSupport(),
  //     ),
  //   ];
  //   notifyListeners();
  // }

  ///Update expanded menu
  expandingList(int index, [bool? isExpand]) {
    homeMenuList[index].isExpanded = isExpand ?? !homeMenuList[index].isExpanded;
    notifyListeners();
  }

  ///selected drawer index for mobile
  int selectedDrawerIndex = 0;

  ///Update drawer for mobile
  void updateDrawer(int index) {
    selectedDrawerIndex = index;
    notifyListeners();
  }

  bool isExpanded = true;

  ///hide Tray Button
  Future<void> hideSideMenu() async {
    isExpanded = !isExpanded;
    notifyListeners();
  }
}
