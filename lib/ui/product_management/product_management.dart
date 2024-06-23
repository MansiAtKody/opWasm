import 'package:flutter/material.dart';
import 'package:kody_operator/ui/product_management/mobile/product_management_mobile.dart';
import 'package:kody_operator/ui/product_management/web/product_management_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductManagement extends StatelessWidget with BaseStatelessWidget {
  final ProductType? productType;

  const ProductManagement({Key? key, this.productType}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return  ProductManagementMobile(productType: productType);
      },
      desktop: (BuildContext context) {
        return ProductManagementWeb(productType: productType);
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.landscape ? ProductManagementWeb(productType: productType) : const ProductManagementMobile();
        });
      },
    );
  }
}
