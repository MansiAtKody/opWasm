import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/product_management/product_management_controller.dart';
import 'package:kody_operator/ui/product_management/web/helper/product_management_right_widget.dart';
import 'package:kody_operator/ui/product_management/web/helper/shimmer_product_management_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class ProductManagementWeb extends ConsumerStatefulWidget {
  final ProductType? productType;

  const ProductManagementWeb({Key? key, this.productType}) : super(key: key);

  @override
  ConsumerState<ProductManagementWeb> createState() => _ProductManagementWebState();
}

class _ProductManagementWebState extends ConsumerState<ProductManagementWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final productManagementWatch = ref.read(productManagementController);
      productManagementWatch.disposeController(isNotify: true);
      productManagementWatch.getCategoryListApi(context).then((value) {
        productManagementWatch.getProductListApi(context, pageNumber: 1, isWeb: true);
      });
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final productManagementWatch = ref.watch(productManagementController);
    return productManagementWatch.getCategoryListState.isLoading || productManagementWatch.getProductListState.isLoading ? const ShimmerProductManagementWeb() : const ProductManagementRightWidget();
  }
}
