import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_tray/mobile/helper/customization_widget.dart';
import 'package:kody_operator/ui/my_tray/mobile/shimmer/shimmer_order_customization_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/controller/my_tray/order_customization_controller.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';

class OrderCustomizationMobile extends ConsumerStatefulWidget {
  final FromScreen fromScreen;
  final String productUuid;
  final String? uuid;

  const OrderCustomizationMobile({Key? key, required this.fromScreen,required this.productUuid,this.uuid}) : super(key: key);

  @override
  ConsumerState<OrderCustomizationMobile> createState() => _OrderCustomizationMobileState();
}

class _OrderCustomizationMobileState extends ConsumerState<OrderCustomizationMobile> with TickerProviderStateMixin, BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final orderCustomizationWatch = ref.read(orderCustomizationController);
      final myTrayWatch = ref.read(myTrayController);
      orderCustomizationWatch.disposeController(isNotify: true);
      await orderCustomizationWatch.productDetailApi(context, widget.productUuid).then((value) {
        if(orderCustomizationWatch.productDetailState.success?.status == ApiEndPoints.apiStatus_200){
          for(int i = 0; i<(orderCustomizationWatch.productDetailState.success?.data!.productAttributes?.length??0); i++){
            orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[i].isValidate = (orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[i].isMandatory == false)? true : false;
            orderCustomizationWatch.updateUi();
          }
        }
      });
      if(widget.fromScreen==FromScreen.myTray){
        await myTrayWatch.cartDetailApi(context, webSideUDID: widget.uuid??'').then((value) {
          myTrayWatch.cartDetailState.success?.data?.cartDtoList?.forEach((element) {
            orderCustomizationWatch.qty=element.qty??1;
            element.cartAttributeDtoList?.forEach((value) {
              orderCustomizationWatch.selectedAttributeList.add(CartAttributeDataDtoList(attributeUuid: value.attributeUuid,attributeNameUuid: value.attributeNameUuid));
            });
          });
          myTrayWatch.notify();
        });
      }
      orderCustomizationWatch.updateUi();
    });
  }
  callBackApi() async {
    final myTrayWatch = ref.watch(myTrayController);
    final orderCustomizationWatch = ref.watch(orderCustomizationController);
    await orderCustomizationWatch.productDetailApi(context, myTrayWatch.productUDID).then((value) {

      if(orderCustomizationWatch.productDetailState.success?.status == ApiEndPoints.apiStatus_200){
        return myTrayWatch.cartDetailApi(context).then((value) {
          if(myTrayWatch.cartDetailState.success?.status == ApiEndPoints.apiStatus_200){
            myTrayWatch.cartDetailState.success?.data?.cartDtoList?.forEach((element) {
              orderCustomizationWatch.qty=element.qty??1;
              element.cartAttributeDtoList?.forEach((value) {
                orderCustomizationWatch.selectedAttributeList.add(CartAttributeDataDtoList(attributeUuid: value.attributeUuid,attributeNameUuid: value.attributeNameUuid));
              });
            });
            print('List : ${orderCustomizationWatch.selectedAttributeList.length}');
            myTrayWatch.notify();
            print('List : ${orderCustomizationWatch.selectedAttributeList.length}');
          }
        });

      }
    });


  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final orderCustomizationWatch = ref.watch(orderCustomizationController);
    return Scaffold(
      backgroundColor: AppColors.servicesScaffoldBgColor,
      body: orderCustomizationWatch.productDetailState.isLoading ? const ShimmerOrderCustomizationMobile() : _bodyWidget(),
      bottomNavigationBar: orderCustomizationWatch.productDetailState.isLoading ? const ShimmerOrderCustomizationBottomNavigationBarWidget() : _bottomWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final orderCustomizationWatch = ref.watch(orderCustomizationController);
    return SingleChildScrollView(
      child: orderCustomizationWatch.productDetailState.isLoading ? DialogProgressBar(isLoading: orderCustomizationWatch.productDetailState.isLoading) :  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _productDetailsWidget(),
        _verticalSpace(),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
            itemCount: orderCustomizationWatch.productDetailState.success?.data?.productAttributes?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return  CustomizationWidget(
                isMandatory: orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].isMandatory??false,
                customizationItems:orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].productAttributeNames,
                title: orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].attributeName??'',
                onTap: (attributeNameIndex) {

                  /// Add attribute selection in list
                  orderCustomizationWatch.updateAttributeSelection(orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].attributeUuid??'', orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].productAttributeNames?[attributeNameIndex].attributeNameUuid??'');
                },
              ).paddingOnly(bottom: 30.h);
            }),
        _verticalSpace(),
      ]).paddingAll(20.h),
    );
  }

  _verticalSpace() {
    return SizedBox(
      height: 20.h,
    );
  }

  _productDetailsWidget() {
    final orderCustomizationWatch = ref.watch(orderCustomizationController);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 181.h,
                  width: 181.h,
                  child: ClipOval(
                    child: CacheImage(
                      imageURL: orderCustomizationWatch.productDetailState.success?.data?.productImageUrl ?? '',
                      height: 181.h,
                      width: 181.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CommonText(
                        title: orderCustomizationWatch.productDetailState.success?.data?.productName ?? '',
                        fontSize: 18.sp,
                        maxLines: 2,
                      ),
                    ),
                    /*SizedBox(
                      width: 10.w,
                    ),*/
                    /*SizedBox(
                      height: 25.h,
                      width: 25.h,
                      child: InkWell(
                        onTap: () {
                          orderCustomizationWatch.updatedFav(homeWatch: ref.watch(homeController));
                        },
                        child: CommonSVG(
                          strIcon: (orderCustomizationWatch.product?.isFavourite ?? false) ? AppAssets.svgFavorite : AppAssets.svgUnfavorite,
                        ).paddingAll(2.h),
                      ),
                    )*/
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonText(
                    title: orderCustomizationWatch.productDetailState.success?.data?.categoryName ?? '',
                    maxLines: 5,
                    clrfont: AppColors.grey7E7E7E,
                  ).paddingOnly(right: 5.w),
                )
              ],
            ).paddingAll(20.h),
            Positioned(
              left: 15.h,
              top: 15.h,
              child: InkWell(
                onTap: () {
                  if (ref.read(navigationStackProvider).items.length > 1) {
                    ref.read(navigationStackProvider).pop();
                  }
                },
                child: const CommonSVG(
                  strIcon: AppAssets.svgBackScaffoldBg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _widgetRememberCustomization(OrderCustomizationController orderCustomizationWatch) {
    return InkWell(
      onTap: () => orderCustomizationWatch.updateRememberCustomize(),
      child: Row(
        children: [
          Icon(orderCustomizationWatch.isRememberCustomization ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: CommonText(
              title: LocalizationStrings.keyRememberCustomization.localized,
            ),
          )
        ],
      ),
    );
  }

  _bottomWidget() {
    final orderCustomizationWatch = ref.watch(orderCustomizationController);
    final myTrayWatch = ref.watch(myTrayController);
    return SizedBox(
      height: 90.h,
      child: CommonCard(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _widgetQtyButton(isPlus: false, orderCustomizationWatch: orderCustomizationWatch),
            Container(
              width: 40.w,
              alignment: Alignment.center,
              child: CommonText(
                title: orderCustomizationWatch.qty.toString(),
                fontSize: 16.sp,
              ),
            ),
            _widgetQtyButton(isPlus: true, orderCustomizationWatch: orderCustomizationWatch),
            SizedBox(
              width: 20.w,
            ),
            Flexible(
              child: CommonButton(
                  width: 176.w,
                  isLoading: myTrayWatch.addCartState.isLoading || myTrayWatch.validateItemState.isLoading || myTrayWatch.updateCartQtyState.isLoading,
                  buttonText: LocalizationStrings.keyGoToTray.localized,
                  buttonEnabledColor: AppColors.blue009AF1,
                  isButtonEnabled:true,
                  rightIcon: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                  ),
                  rightIconLeftPadding: 5.w,
                onTap: () async {
                  if (widget.fromScreen == FromScreen.orderHome || widget.fromScreen == FromScreen.frequentlyBought) {
                    await myTrayWatch.validateItemApi(context,orderCustomizationWatch.productDetailState.success?.data?.uuid ?? '' , orderCustomizationWatch.qty,orderCustomizationWatch.selectedAttributeList);
                    if(context.mounted && myTrayWatch.validateItemState.success?.status == ApiEndPoints.apiStatus_200){
                      if(myTrayWatch.validateItemState.success?.data?.productPresent ?? false){
                        orderCustomizationWatch.addItemCount(myTrayWatch.validateItemState.success?.data?.qty??0);
                        showConfirmationDialogWeb(
                          dialogWidth: context.width * 0.35,
                          context: context,
                          title: LocalizationStrings.keyItemMsg.localized,
                          message: '',
                          didTakeAction: (isPositive) async {
                            if (isPositive) {
                              await myTrayWatch.updateCartQtyApi(context, myTrayWatch.validateItemState.success?.data?.uuid??'',  orderCustomizationWatch.sameItemQyt);
                              if(myTrayWatch.updateCartQtyState.success?.status==ApiEndPoints.apiStatus_200 && context.mounted){
                                ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.myTray());
                                await myTrayWatch.cartListApi(context);
                              }
                            }
                          },
                        );
                      }
                      else{
                        await myTrayWatch.addCartApi(context, widget.productUuid, orderCustomizationWatch.qty, orderCustomizationWatch.selectedAttributeList);
                        if(myTrayWatch.addCartState.success?.status == ApiEndPoints.apiStatus_200 && context.mounted){
                          ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.myTray());
                          await myTrayWatch.cartListApi(context);
                        }
                      }
                    }
                  }
                  else {
                    await myTrayWatch.addCartApi(context, widget.productUuid, orderCustomizationWatch.qty, orderCustomizationWatch.selectedAttributeList, isFromEdit: true, uuid: widget.uuid);
                    if (myTrayWatch.addCartState.success?.status == ApiEndPoints.apiStatus_200 && context.mounted) {
                      ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.myTray());
                      await myTrayWatch.cartListApi(context);
                    }
                  }
                },
              ).paddingSymmetric(horizontal: 20.w),
            )
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }

  _widgetQtyButton({required bool isPlus, required OrderCustomizationController orderCustomizationWatch}) {
    return InkWell(
      onTap: () {
        orderCustomizationWatch.updateQty(isPlus: isPlus);
      },
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(shape: BoxShape.circle, color: isPlus == false && orderCustomizationWatch.qty ==  1?AppColors.greyF9F9F9.withOpacity(0.8):AppColors.greyF9F9F9),
        alignment: Alignment.center,
        child: Icon(
          isPlus ? Icons.add : Icons.remove,
          color: isPlus == false && orderCustomizationWatch.qty ==  1?AppColors.black.withOpacity(0.5):AppColors.black,

        ),
      ),
    );
  }
}
