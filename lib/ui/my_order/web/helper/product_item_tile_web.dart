import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/order/model/response/product_list_reponse_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/hover_animation.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';

class ProductItemTileWeb extends ConsumerWidget with BaseConsumerWidget {
  final ProductList? product;

  const ProductItemTileWeb({
    super.key,
    this.product,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return HoverAnimation(
          transformSize: 1.04,
          child: FadeBoxTransition(
            child: InkWell(
              onTap: () {

              },
              child: Stack(
                children: [
                  Positioned(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.93,
                    top: 0,
                    child: CommonCard(
                      elevation: 4,
                      color: AppColors.white,
                      margin: EdgeInsets.zero,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * 0.93,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 30.h),
                            Container(
                              height: context.height * 0.18,
                              width: context.height * 0.18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.black)
                              ),
                              child: ClipOval(
                                child: CacheImage(
                                  height: context.height * 0.18,
                                  width: context.height * 0.18,
                                  imageURL: product?.imageUrl??'',
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              product?.productName ?? '',
                              style: TextStyles.medium.copyWith(
                                color: AppColors.black272727,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: constraints.maxWidth * 0.15,
                    right: constraints.maxWidth * 0.15,
                    bottom: 0,
                    child: CommonButton(
                      height: constraints.maxHeight * 0.15,
                      onTap: () {
                        ref.read(navigationStackProvider).push(NavigationStackItem.orderCustomization(fromScreen:FromScreen.orderHome,productUuid: product?.uuid??''));
                      },
                      buttonTextColor: AppColors.white,
                      buttonTextStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.white),
                      buttonEnabledColor: AppColors.black272727,
                      isButtonEnabled: true,
                      borderColor: AppColors.black272727,
                      buttonText: '+${LocalizationStrings.keyAdd.localized}',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
