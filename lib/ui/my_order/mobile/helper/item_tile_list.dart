
import 'package:kody_operator/framework/repository/order/model/order_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

///Widget to display single items from order
class ItemTileList extends StatelessWidget with BaseStatelessWidget {
  final int index;
  final bool? isShowFavIcon;
  final bool? isFav;
  final bool isProduct;
  final OrderItem? orderItem;
  final Function()? onFavIconTap;

  const ItemTileList({
    super.key,
    this.isShowFavIcon = false,
    required this.orderItem,
    this.onFavIconTap,
    required this.index,
    this.isProduct = false,
    this.isFav = false,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CacheImage(
            height: 115.h,
            width: 115.h,
            imageURL: orderItem?.itemImage ?? '',
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: SizedBox(
            height: context.height * 0.15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Favourite icon
                (isShowFavIcon == true)
                    ? Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: onFavIconTap,
                          child: CommonSVG(strIcon: isFav! ? AppAssets.svgFavorite : AppAssets.svgUnfavorite),
                        ),
                      )
                    : const Offstage(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///Item Name
                      CommonText(
                        title: orderItem?.itemName ?? '',
                        fontSize: 16.sp,
                        maxLines: 2,
                        clrfont: AppColors.black,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),

                      ///Item Description is any
                      CommonText(
                        title: orderItem?.description ?? '',
                        fontSize: 12.sp,
                        maxLines: 2,
                        clrfont: AppColors.grey7E7E7E,
                      ),
                      SizedBox(height: context.height * 0.01),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: AppColors.clrE5F3FF,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: CommonText(
                          title: isProduct ? LocalizationStrings.keyProduct.localized : LocalizationStrings.keyService.localized,
                          textStyle: TextStyles.regular.copyWith(color: AppColors.clr0083FC, fontSize: 13.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
