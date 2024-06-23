import 'package:flutter/material.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/product_detail_reponse_model.dart';
import 'package:kody_operator/ui/product_management/web/helper/common_customization_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class QuantityWidget extends StatelessWidget with BaseStatelessWidget{
  final ProductAttribute? productAttribute;
  const QuantityWidget({super.key,required this.productAttribute});

  @override
  Widget buildPage(BuildContext context) {
    return CommonCustomizationWidget(
      productAttribute: productAttribute,
    );
  }
}
