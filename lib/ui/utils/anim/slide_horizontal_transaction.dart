import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/anim/animation_extension.dart';

class SlideHorizontalTransition extends StatefulWidget {
  final Widget child;
  final int? delay;
  final int? duration;
  final bool isRightSlide;
  final bool? showFade;
  final double? startAnimation;

  const SlideHorizontalTransition({super.key, required this.child, this.delay, this.duration, required this.isRightSlide, this.showFade, this.startAnimation});

  @override
  State<SlideHorizontalTransition> createState() => _SlideHorizontalTransitionState();
}

class _SlideHorizontalTransitionState extends State<SlideHorizontalTransition> with TickerProviderStateMixin {
  AnimationController? _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 300));
    if (_animController != null) {
      final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animController ?? AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 300)));
      if (widget.isRightSlide) {
        _animOffset = Tween<Offset>(begin: const Offset(-0.45, 0.0), end: Offset.zero).animate(curve);
      } else {
        _animOffset = Tween<Offset>(begin: const Offset(0.45, 0.0), end: Offset.zero).animate(curve);
      }

      if (mounted) {
        Future.delayed(Duration(milliseconds: widget.delay ?? 100), () {
          if (!(_animController?.isDisposed ?? false)) {
            _animController?.forward(from: widget.startAnimation);
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
        ? widget.showFade ?? false
            ? FadeTransition(
                opacity: _animController!,
                child: SlideTransition(
                  position: _animOffset,
                  child: widget.child,
                ),
              )
            : FadeTransition(
                opacity: _animController!,
                child: SlideTransition(
                  position: _animOffset,
                  child: widget.child,
                ),
              )
        : const Offstage();
  }
}
