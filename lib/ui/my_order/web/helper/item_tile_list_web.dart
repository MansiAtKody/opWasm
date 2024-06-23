

import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

///Widget to display single items from order
class ItemTileListWeb extends StatelessWidget with BaseStatelessWidget {
  final int index;
  final bool? isShowFavIcon;
  final bool? isFav;
  final OrderItem? orderItem;
  final Function()? onFavIconTap;
  final bool? isProduct;
  final Widget? orderStatusWidget;

  const ItemTileListWeb({
    super.key,
    this.isShowFavIcon = false,
    required this.orderItem,
    this.onFavIconTap,
    required this.index,
    this.isFav = false,
    this.orderStatusWidget,
    this.isProduct,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CacheImage(
            height: 115.h,
            width: 115.h,
            imageURL: orderItem?.itemImage ??'',
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ///Item Name
                Row(
                  children: [
                    CommonText(
                      title: orderItem?.itemName ?? '',
                      fontSize: 20.sp,
                      maxLines: 2,
                      clrfont: AppColors.black171717,
                    ),
                    orderStatusWidget ?? const SizedBox()
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),

                ///Item Description is any
                CommonText(
                  title: orderItem?.description ?? '',
                  fontSize: 18.sp,
                  maxLines: 3,
                  clrfont: AppColors.grey7E7E7E,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 115.h,
            child: Column(
              children: [
                ///Favourite icon
                (isShowFavIcon == true)
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                              margin: EdgeInsets.only(right: 20.w),
                              decoration: BoxDecoration(
                                color: AppColors.clrE5F3FF,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: CommonText(
                                title: isProduct ?? false ? LocalizationStrings.keyProduct.localized : LocalizationStrings.keyService.localized,
                                textStyle: TextStyles.regular.copyWith(color: AppColors.clr0083FC, fontSize: 16.sp),
                              ),
                            ),
                            (isProduct ?? false) ? InkWell(onTap: onFavIconTap, child: CommonSVG(strIcon: isFav! ? AppAssets.svgFavorite : AppAssets.svgUnfavorite)) : const Offstage(),
                          ],
                        ),
                      )
                    : const Offstage(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
