import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/order_home_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/category_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CategoriesListTile extends ConsumerWidget with BaseConsumerWidget{
  final CategoryData? categoriesModel;
  final void Function()? onTap;
  final Color? unSelectedColor;
  final bool isSelected;

  const CategoriesListTile({this.categoriesModel, this.onTap, required this.isSelected,this.unSelectedColor, super.key,});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final homeWatch = ref.watch(orderHomeController);
    return  GestureDetector(
      onTap: onTap ?? () {
        homeWatch.updateSelectedCategory(selectedCategory: categoriesModel,context: context);
      },
      child: CommonCard(
        margin: EdgeInsets.zero,
        elevation: !isSelected ? 0 : 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: isSelected ? AppColors.black171717 : unSelectedColor ?? AppColors.lightPinkF7F7FC,
          ),
          child: CommonText(
            title: categoriesModel?.name ?? '',
            textStyle: TextStyles.regular.copyWith(color: isSelected ? AppColors.white : AppColors.grey626262),
          ).paddingSymmetric(horizontal: 20.w,vertical: 10.h),
        ),
      ),
    ).paddingOnly(right: 10.w);
  }
}
