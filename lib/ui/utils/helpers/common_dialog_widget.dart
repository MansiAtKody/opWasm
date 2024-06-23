import 'dart:ui';

import 'package:kody_operator/ui/utils/theme/theme.dart';

class CommonDialogWidget extends StatelessWidget {
  final Widget child;

  const CommonDialogWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: child,
      ),
    );
  }
}
