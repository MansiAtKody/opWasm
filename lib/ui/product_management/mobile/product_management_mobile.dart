import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/product_management/product_management_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/product_management/helper/product_list_mobile.dart';
import 'package:kody_operator/ui/product_management/helper/shimmer_product_management_mobile.dart';
import 'package:kody_operator/ui/product_management/web/helper/product_type_tab_widget.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class ProductManagementMobile extends ConsumerStatefulWidget {
  final ProductType? productType;

  const ProductManagementMobile({Key? key, this.productType}) : super(key: key);

  @override
  ConsumerState<ProductManagementMobile> createState() => _ProductManagementMobileState();
}

class _ProductManagementMobileState extends ConsumerState<ProductManagementMobile> with BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final productManagementWatch = ref.read(productManagementController);

      productManagementWatch.disposeController(isNotify: true);
      await productManagementWatch.getCategoryListApi(context).then((value) {
        productManagementWatch.getProductListApi(context, pageNumber: 1, isWeb: false);
      });
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final productManagementWatch = ref.watch(productManagementController);
    return CommonWhiteBackground(
      appBar: const CommonAppBar(
        backgroundColor: AppColors.black,
        customTitleWidget: CommonSVG(strIcon: AppAssets.svgDasher),
        isDrawerEnable: true,
      ),

      /// Shimmer & Body Widget
      child: productManagementWatch.getProductListState.isLoading || productManagementWatch.getCategoryListState.isLoading
          ? const ShimmerProductManagementMobile()
          : RefreshIndicator(
              onRefresh: () async {
                productManagementWatch.disposeController(isNotify: true);
                productManagementWatch.getCategoryListApi(context).then((value) {
                  productManagementWatch.getProductListApi(context, isWeb: false);
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// Product Tab bar
                  const ProductTypeTabWidget(),
                  SizedBox(height: 25.h),

                  ///Product List Tile Widget
                  const Expanded(
                    child: FadeBoxTransition(child: ProductListMobile()),
                  ),
                ],
              ).paddingOnly(left: 16.w, right: 16.w, top: 26.h),
            ),
    );
  }
}
