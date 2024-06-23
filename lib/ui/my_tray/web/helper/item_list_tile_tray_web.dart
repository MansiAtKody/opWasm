import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/frequenlty_bought_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ItemListTileTrayWeb extends StatelessWidget with BaseStatelessWidget {
  final int index;
  final bool? isFromMyTray;
  final ProductDetail productInfo;

  const ItemListTileTrayWeb(
      {super.key,
      required this.index,
      this.isFromMyTray = false,
      required this.productInfo});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return SizedBox(
        height: 199.h,
        child: Stack(
          children: [
            CommonCard(
              elevation: 4,
              margin: EdgeInsets.zero,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipOval(
                      child: CacheImage(
                        height: 80.h,
                        width: 80.h,
                        imageURL: productInfo.image ?? '',
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CommonText(
                      title: productInfo.productName ?? '',
                      textStyle:
                          TextStyles.regular.copyWith(color: AppColors.black),
                    )
                  ],
                ).paddingOnly(bottom: 20.h, top: 15.h),
              ),
            ).paddingOnly(bottom: 40.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: CommonButton(
                height: 40.h,
                width: 100.w,
                onTap: () {
                  hideKeyboard(context);
                  ref.read(navigationStackProvider).push(NavigationStackItem.orderCustomization(fromScreen: FromScreen.frequentlyBought, productUuid: productInfo.uuid??''));
                //   trayAddedBottomSheet(context);
                },
                isButtonEnabled:true,
                buttonTextColor: AppColors.white,
                buttonEnabledColor: AppColors.black,
                borderColor: AppColors.black,
                buttonText: '+${LocalizationStrings.keyAdd.localized}',
              ).paddingOnly(bottom: 20.h),
            )
          ],
        ),
      );
    });
  }
}
