import 'package:kody_operator/ui/utils/theme/theme.dart';

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 10, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = AppColors.red.withOpacity(0.4)
      ..strokeWidth = 0.6;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}