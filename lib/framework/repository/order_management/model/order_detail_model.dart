import 'package:kody_operator/ui/utils/theme/theme.dart';

class OrderDetail {
  /// Order detail info
  final String orderTitle;
  final String orderInfo;
  bool isCancel = true;
  final String? orderImage;

  OrderDetail({
    required this.orderTitle,
    required this.orderInfo,
    this.orderImage = AppAssets.svgChai,
    required this.isCancel,
  });
}
