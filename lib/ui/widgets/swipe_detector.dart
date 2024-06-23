import 'package:kody_operator/ui/utils/theme/theme.dart';

class SwipeDetector extends StatefulWidget {
  final Widget child;
  final Function(SwipeDetectedDirection direction) onSwipeDetected;

  const SwipeDetector({super.key, required this.child, required this.onSwipeDetected});

  @override
  State<SwipeDetector> createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  bool hasSwiped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (direction) {
        double localDirection = direction.localPosition.dx;
        double deltaDirection = direction.delta.dx;
        ///Swipe Left
        if (localDirection > 50 && (deltaDirection <= -5 && deltaDirection >= -100) && !hasSwiped) {
          widget.onSwipeDetected.call(SwipeDetectedDirection.left);
        } else if (localDirection < 100 && (deltaDirection >= 0 && deltaDirection <= 100) && !hasSwiped) {
          widget.onSwipeDetected.call(SwipeDetectedDirection.right);
        }
        hasSwiped = true;
      },
      onHorizontalDragEnd: (direction) {
        hasSwiped = false;
      },
      child: widget.child,
    );
  }
}

enum SwipeDetectedDirection { left, right }
