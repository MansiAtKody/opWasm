import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/product_management/product_management_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/product_management/web/helper/tab_list_tile.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ProductTypeTabWidget extends StatelessWidget with BaseStatelessWidget {
  const ProductTypeTabWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final productManagementWatch = ref.watch(productManagementController);
      return Column(
        children:[

          /// Product count
        Align(
        alignment: Alignment.centerRight,
        child: CommonText(
          title: '${productManagementWatch.getProductListState.success?.totalCount.toString().padLeft(2,"0")} ${LocalizationStrings.keyProducts.localized}',
          textStyle: TextStyles.regular.copyWith(fontSize: 20.sp),
        ),
      ).paddingOnly(bottom: 20.h),

          ///  Tabs
          SizedBox(
          height: 59.h,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: productManagementWatch.categoryList.length,
            itemBuilder: (context, index) {
              return ListBounceAnimation(
                onTap: (){
                  productManagementWatch.updateSelectedCategory(context, productManagementWatch.categoryList[index]);
                },
                child: TabTileList(selectedProductType: productManagementWatch.categoryList[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 20.w,
              );
            },
          ),
        ),]
      );
    });
  }
}
