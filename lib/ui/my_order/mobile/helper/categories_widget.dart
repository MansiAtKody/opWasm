import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/order_home_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/category_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/categories_list_tile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CategoriesWidgetMobile extends ConsumerWidget with BaseConsumerWidget {
  const CategoriesWidgetMobile({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final homeWatch = ref.watch(orderHomeController);
        return Row(
          children: [
            CategoriesListTile(
              categoriesModel:
                  CategoryData(uuid: '', name: 'All Items', active: true),
              isSelected: homeWatch.selectedCategory == null,
              unSelectedColor: AppColors.white,
              onTap: () {
                homeWatch.updateSelectedCategory(
                    selectedCategory: null, context: context);
              },
            ).paddingOnly(left: 20.w,right: 10.w),
            CategoriesListTile(
              categoriesModel: CategoryData(
                  uuid: null, name: 'Other Categories', active: true),
              isSelected: homeWatch.selectedCategory != null,
              unSelectedColor: AppColors.white,
              onTap: () {
                showCommonDialog(
                    context: context,
                    width: context.width * 0.8,
                    dialogBody: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              title:
                                  LocalizationStrings.keyCategories.localized,
                              textStyle: TextStyles.regular.copyWith(
                                fontSize: 18.sp,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CommonSVG(
                                strIcon: AppAssets.svgCrossRounded,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Wrap(
                                children: List.generate(
                                  homeWatch.categoryListState.success?.data
                                          ?.length ??
                                      0,
                                  (index) {
                                    return CategoriesListTile(
                                      categoriesModel: homeWatch.categoryListState.success?.data?[index],
                                      onTap: () {
                                        homeWatch.updateSelectedCategory(selectedCategory: homeWatch.categoryListState.success?.data?[index], context: context);
                                        Navigator.pop(context);
                                      },
                                      isSelected: homeWatch.categoryListState.success?.data?[index] == homeWatch.selectedCategory,
                                    ).paddingOnly(right: 10.w, bottom: 10.w);
                                  },
                                ),
                              ).paddingSymmetric(vertical: 30.h),
                            ],
                          ),
                        )
                      ],
                    ).paddingSymmetric(horizontal: 20.w, vertical: 30.h));
              },
            ),
          ],
        );
      },
    );
  }
}
