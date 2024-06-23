import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/anim/animation_extension.dart';

class SlideVerticalTransition extends StatefulWidget {
  final Widget child;
  final int? delay;
  final int? duration;
  final bool isUpSlide;
  final Function(AnimationController? animationController)? getAnimationController;

  const SlideVerticalTransition({super.key, required this.child, this.delay, this.duration, required this.isUpSlide, this.getAnimationController});

  @override
  State<SlideVerticalTransition> createState() => _SlideVerticalTransitionState();
}

class _SlideVerticalTransitionState extends State<SlideVerticalTransition> with TickerProviderStateMixin {
  AnimationController? _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 200));
    if (_animController != null) {
      final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animController ?? AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 200)));
      if (widget.isUpSlide) {
        _animOffset = Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero).animate(curve);
      } else {
        _animOffset = Tween<Offset>(begin: const Offset(0.0, -0.5), end: const Offset(0.0, 0.0)).animate(curve);
      }
      widget.getAnimationController?.call(_animController);
      if (mounted) {
        Future.delayed(Duration(milliseconds: widget.delay ?? 0), () {
          if (!(_animController?.isDisposed ?? false)) {
            _animController?.forward();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _animController?.dispose();
    _animController == null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _animController != null
        ? FadeTransition(
            opacity: _animController!,
            child: SlideTransition(
              position: _animOffset,
              child: widget.child,
            ),
          )
        : const Offstage();
  }
}
