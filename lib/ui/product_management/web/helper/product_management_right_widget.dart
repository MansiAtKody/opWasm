import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/product_management/product_management_controller.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/get_category_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/product_management/web/helper/product_list_tile.dart';
import 'package:kody_operator/ui/user_management/web/helper/table_header_text_widget.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_form_field_dropdown.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ProductManagementRightWidget extends StatelessWidget with BaseStatelessWidget {
  const ProductManagementRightWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final productManagementWatch = ref.watch(productManagementController);
        return Column(
          children: [
            /// App Bar Top Widget
            // const CommonAppBarWeb(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FadeBoxTransition(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: AppColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              title: LocalizationStrings.keyProductManagement.localized,
                              textStyle: TextStyles.regular.copyWith(
                                color: AppColors.black,
                                fontSize: 22.sp,
                              ),
                            ),

                            SizedBox(height: context.height * 0.04),

                            /// Product Tab bar
                            // const ProductTypeTabWidget(),

                            ///Category Dropdown widget
                            Row(
                              children: [
                                Expanded(
                                  child: CommonDropdownInputFormField<GetCategoryListResponseData>(
                                    height: context.height * 0.05,
                                    hintText: LocalizationStrings.keyCategories.localized,
                                    validator: (GetCategoryListResponseData? value) => null,
                                    menuItems: productManagementWatch.categoryList,
                                    defaultValue: productManagementWatch.selectedCategory,
                                    items: (productManagementWatch.categoryList)
                                        .map(
                                          (item) => DropdownMenuItem<GetCategoryListResponseData>(
                                            value: item,
                                            child: Text((item.name ?? '').capsFirstLetterOfSentence, style: TextStyles.medium.copyWith(color: AppColors.black)),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (GetCategoryListResponseData? selectedCategory) async {
                                      await productManagementWatch.updateSelectedCategory(context, selectedCategory);
                                    },
                                  ),
                                ),
                                const Spacer(),
                                CommonText(
                                  title: '${productManagementWatch.getProductListState.success?.totalCount.toString().padLeft(2,"0")} ${LocalizationStrings.keyProducts.localized}',
                                  textStyle: TextStyles.regular.copyWith(fontSize: 20.sp),
                                ).paddingOnly(right: 40.w),
                              ],
                            ),

                            SizedBox(height: context.height * 0.04),

                            /// Product Name, Category & Product Status
                            Table(
                              textDirection: TextDirection.ltr,
                              columnWidths: {
                                0: FlexColumnWidth(2.w), /// status
                                1: FlexColumnWidth(3.w), /// product name
                                2: FlexColumnWidth(3.w), /// categories
                                3: FlexColumnWidth(6.5.w), ///  product status
                                4: FlexColumnWidth(3.w), /// See customization
                              },
                              children: [
                                TableRow(children: [
                                  TableHeaderTextWidget(text: LocalizationStrings.keyStatus.localized, textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.grey8D8C8C)).paddingOnly(left: 10.w),
                                  TableHeaderTextWidget(text: LocalizationStrings.keyProductName.localized, textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.grey8D8C8C)),
                                  TableHeaderTextWidget(text: LocalizationStrings.keyCategories.localized, textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.grey8D8C8C)),
                                  TableHeaderTextWidget(text: LocalizationStrings.keyProductStatus.localized, textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.grey8D8C8C)),
                                  Container()
                                ]),
                              ],
                            ),

                            ///Product List Tile Widget
                            const Expanded(
                              child: ProductListTile(),
                            ),
                          ],
                        ).paddingOnly(left: 20.w, right: 20.w, top: 20.h),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ).paddingOnly(left: 15.w, right: 15.w, top: 10.h),
            ),
          ],
        );
      },
    );
  }
}
