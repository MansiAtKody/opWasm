import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class HomeMenuOperator<T> {
  final String menuName;
  final String? strIcon;
  bool isExpanded;
  final ScreenName? screenName;
  final ScreenName? parentScreen;
  Widget screen;
  final List<HomeMenuSubScreen>? dropDownList;
  NavigationStackItem item;

  HomeMenuOperator({
    required this.menuName,
    this.strIcon,
    this.screenName,
    this.parentScreen,
    this.isExpanded = false,
    this.dropDownList,
    required this.item,
    required this.screen,
  });
}

class HomeMenuSubScreen {
  String title;
  ScreenName screenName;
  NavigationStackItem item;

  HomeMenuSubScreen({required this.screenName, required this.item, required this.title});
}
