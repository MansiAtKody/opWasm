import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class ProfileItem {
  final String svgAsset;
  final String tileTitle;
  final Widget? screen;
  final bool? isSelected;
  final NavigationStackItem? stackItem;

  const ProfileItem({
    required this.tileTitle,
    this.stackItem,
    this.isSelected = false,
    required this.svgAsset,
    this.screen,
  });
}
