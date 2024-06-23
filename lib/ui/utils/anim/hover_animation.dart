import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kody_operator/ui/utils/helpers/custom_mouse_region.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class HoverAnimation extends StatefulWidget {
  final Widget child;
  final int? duration;
  final double? transformSize;

  const HoverAnimation({
    super.key,
    required this.child,
    this.duration,
    this.transformSize,
  });

  @override
  State<HoverAnimation> createState() => _HoverAnimationState();
}

class _HoverAnimationState extends State<HoverAnimation> with SingleTickerProviderStateMixin {
  // late AnimationController _animController;
  // late Animation<double> _animDouble;

  bool isHovered = false;

  @override
  void initState() {
    super.initState();

    // _animController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 3000));
    // _animDouble = CurvedAnimation(curve: Curves.linearToEaseOut, parent: _animController);
    // _animDouble = curve;
  }

  @override
  void dispose() {
    // _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        return widget.child;
      }
    }
    final hoverTransform = Matrix4.identity()
      ..translate(0, -1, 1)
      ..scale(widget.transformSize ?? 1.1);
    final transform = isHovered ? hoverTransform : Matrix4.identity();
    return CustomMouseRegion(
      onEnter: (pointerEvent) {
        onEntered(true);
      },
      onExit: (pointerEvent) {
        onEntered(false);
      },
      child: AnimatedContainer(
        transform: transform,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }

  onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
