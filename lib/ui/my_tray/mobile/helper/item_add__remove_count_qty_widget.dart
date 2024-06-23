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

class ItemAddRemoveCountQtyWidget extends StatelessWidget with BaseStatelessWidget {
  final CartDtoList? trayModel;
  const ItemAddRemoveCountQtyWidget({super.key, required this.trayModel});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context,ref,widget) {
        final myTrayWatch = ref.watch(myTrayController);
        return SizedBox(
          height: 30.h,
          child: Row(
            children: [
              InkWell(
                  onTap: () async{
                    if(trayModel?.qty==1) {
                      ///Dialog
                      showConfirmationDialogWeb(context: context, title: LocalizationStrings.keyAreYouWantToRemoveItemFromCart.localized, message: '',
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
                  child: const CommonSVG(strIcon: AppAssets.svgRemove)),
              Container(
                width: 60.w,
                alignment: Alignment.center,
                child: (myTrayWatch.updateCartQtyState.isLoading && (trayModel?.uuid == myTrayWatch.selectedProductUuid)) ? LoadingAnimationWidget.waveDots(
                  color: AppColors.black,
                  size: 34.h,
                ).paddingSymmetric(horizontal: 10.w): CommonText(
                  title: (trayModel?.qty??0).toString(),
                ).paddingSymmetric(horizontal: 10.w),
              ),
              InkWell(
                  onTap: ()async {
                    myTrayWatch.incrementQty(trayModel!);
                    await myTrayWatch.updateCartQtyApi(context, trayModel?.uuid??'', trayModel?.qty??1);
                  },
                  child: const CommonSVG(strIcon: AppAssets.svgAdd)),
            ],
          ),
        );
      }
    );
  }
}
