import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';

class ServicesOption {
  final String iconName;
  final String title;
  final NavigationStackItem stackItem;
  final ScreenName screenName;

  ServicesOption({
    required this.iconName,
    required this.title,
    required this.screenName,
    required this.stackItem,
  });
}
