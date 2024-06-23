import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/ui/order_management/web/helper/ongoing_order_list_web.dart';
import 'package:kody_operator/ui/order_management/web/helper/past_order_list_web.dart';
import 'package:kody_operator/ui/order_management/web/helper/upcoming_order_list_web.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';

final homeController = ChangeNotifierProvider(
  (ref) => getIt<HomeController>(),
);

@injectable
class HomeController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    selectedTabIndex = 0;
    if (isNotify) {
      notifyListeners();
    }
  }

  final GlobalKey<ScaffoldState> key = GlobalKey();

  int selectedTabIndex = 0;

  updateSelectedTabIndex({int? selectedTabIndex}) {
    this.selectedTabIndex = selectedTabIndex ?? 0;
    notifyListeners();
  }

  List<Widget> orderTypeList = [
    const UpcomingOrderListWeb(),
    // const SelectCoffeeScreen(),
    const OngoingOrderList(), const PastOrderList()];
  List<String> orderTypeNameList = [LocalizationStrings.keyUpcoming, LocalizationStrings.keyAccepted, LocalizationStrings.keyPrepared];

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

}
