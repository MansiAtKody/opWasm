import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/product_management/product_management_controller.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/get_category_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class TabTileList extends StatelessWidget with BaseStatelessWidget {
  final GetCategoryListResponseData? selectedProductType;

  const TabTileList({super.key, required this.selectedProductType});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final productManagementWatch = ref.watch(productManagementController);
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(74.r), color: productManagementWatch.selectedCategory?.uuid == selectedProductType?.uuid ? AppColors.blue009AF1 : AppColors.whiteF7F7FC),
          alignment: Alignment.center,
          child: CommonText(
            title: selectedProductType?.name ?? '',
            fontSize: 18.sp,
            clrfont: productManagementWatch.selectedCategory?.uuid == selectedProductType?.uuid ? AppColors.white : AppColors.grey626262,
          ).paddingSymmetric(horizontal: 42.w),
        ) /*.paddingOnly(left: index == 0 ? 20.h : 0,right: index == 2 ? 20.h : 0)*/;
      },
    );
  }
}
