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

class FrequentlyBoughtItemListTile extends ConsumerWidget with BaseConsumerWidget {
  final int index;
  final bool? isFromMyTray;
  final ProductDetail productInfo;
  final bool? fromGuest;


  const FrequentlyBoughtItemListTile({super.key, required this.index, this.isFromMyTray = false,required this.productInfo,this.fromGuest = false});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CommonCard(
          color: AppColors.whiteF7F7FC,
          elevation: 4,
          margin: EdgeInsets.zero,
          child: SizedBox(
            width: context.width,
            height: context.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: CacheImage(
                    height: 96.h,
                    width: 96.h,
                    imageURL: productInfo.image ?? '',
                  ),
                ),
                SizedBox(height: 10.h),
                CommonText(
                  title: productInfo.productName ?? '',
                  textStyle: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 14.sp),
                )
              ],
            ).paddingOnly(bottom: 20.h),
          ),
        ).paddingOnly(bottom: 40.h),
        Positioned(
          bottom: 20.h,
          child: CommonButton(
            height: 40.h,
            width: context.width * 0.2,
            onTap: () {
              hideKeyboard(context);

              ref.read(navigationStackProvider).push(NavigationStackItem.orderCustomization(fromScreen: FromScreen.frequentlyBought,productUuid: productInfo.uuid ?? ''));
              // trayAddedBottomSheet(context);
            },
            buttonTextColor: AppColors.white,
            isButtonEnabled: true,
            buttonEnabledColor: AppColors.black171717,
            borderColor: AppColors.primary,
            buttonText: '+${LocalizationStrings.keyAdd.localized}',
          ),
        )
      ],
    );
  }
}
