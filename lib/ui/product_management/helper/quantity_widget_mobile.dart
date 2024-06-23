import 'package:flutter/material.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/product_detail_reponse_model.dart';
import 'package:kody_operator/ui/product_management/helper/common_customization_widget_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class QuantityWidgetMobile extends StatelessWidget with BaseStatelessWidget{
  final ProductAttribute? productAttribute;
  const QuantityWidgetMobile({super.key, required this.productAttribute});

  @override
  Widget buildPage(BuildContext context) {
    return CommonCustomizationWidgetMobile(
      productAttribute: productAttribute,
    );
  }
}
