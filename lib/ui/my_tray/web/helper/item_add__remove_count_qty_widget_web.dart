import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ItemAddRemoveCountQtyWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  final CartDtoList? trayModel;
  const ItemAddRemoveCountQtyWidgetWeb({super.key, required this.trayModel});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context,ref,widget) {
        final myTrayWatch = ref.watch(myTrayController);
        return Row(
          children: [
            InkWell(
                onTap: ()async{
                  if(trayModel?.qty==1) {
                    ///Dialog
                    showConfirmationDialogWeb(context: context, title: LocalizationStrings.keyAreYouWantToRemoveItemFromCart.localized, message: '',
                        dialogWidth: context.width / 3,
                        didTakeAction: (isPositive) async {
                          if (isPositive) {
                            myTrayWatch.decrementQty(trayModel!);
                            await myTrayWatch.updateCartQtyApi(context, trayModel?.uuid??'', trayModel?.qty??1);
                            await myTrayWatch.cartCountApi(context);
                            await  myTrayWatch.cartListApi(context);
                          }
                        });
                  }
                  else{
                    myTrayWatch.decrementQty(trayModel!);
                    await myTrayWatch.updateCartQtyApi(context, trayModel?.uuid??'', trayModel?.qty??1);
                  }
                },
                child: (trayModel?.qty ?? 1) < 2 ?
                Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: AppColors.black171717,
                    ),
                    child: const Icon(Icons.delete_outlined, color: AppColors.white,)) : CommonSVG(strIcon: AppAssets.svgRemove,height: 44.h,width: 44.h,)),

            Container(
              alignment: Alignment.center,
              width: 60.w,
              child: (myTrayWatch.updateCartQtyState.isLoading && (trayModel?.uuid == myTrayWatch.selectedProductUuid)) ? LoadingAnimationWidget.waveDots(
                color: AppColors.black,
                size: 34.h,
              ).paddingSymmetric(horizontal: 15.w) : CommonText(
                title: (trayModel?.qty??0).toString(),
                fontSize: 15.sp,
              ).paddingSymmetric(horizontal: 15.w),
            ),
            InkWell(
                onTap: ()async{
                  myTrayWatch.incrementQty(trayModel!);
                  await myTrayWatch.updateCartQtyApi(context, trayModel?.uuid??'', trayModel?.qty??1);
                },
                child:  CommonSVG(strIcon: AppAssets.svgAdd,height: 44.h,width: 44.h,)),
          ],
        );
      }
    );
  }
}
