import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/controller/my_tray/order_customization_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_tray/mobile/helper/customization_widget.dart';
import 'package:kody_operator/ui/my_tray/web/shimmer/shimmer_order_customization_web.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderCustomizationWeb extends ConsumerStatefulWidget {
  final FromScreen fromScreen;
  final String productUuid;
  final String? uuid;

  const OrderCustomizationWeb({Key? key, required this.fromScreen,required this.productUuid, this.uuid}) : super(key: key);

  @override
  ConsumerState<OrderCustomizationWeb> createState() => _OrderCustomizationWebState();
}

class _OrderCustomizationWebState extends ConsumerState<OrderCustomizationWeb> with TickerProviderStateMixin, BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final orderCustomizationWatch = ref.read(orderCustomizationController);
      final myTrayWatch = ref.read(myTrayController);
      orderCustomizationWatch.disposeController(isNotify: true);
      await orderCustomizationWatch.productDetailApi(context, widget.productUuid);
      if(context.mounted){
        if (widget.fromScreen == FromScreen.myTray) {
          myTrayWatch.cartDetailApi(context, webSideUDID: widget.uuid ?? '');
          if(context.mounted){
            myTrayWatch.cartDetailState.success?.data?.cartDtoList?.forEach((element) {
              orderCustomizationWatch.qty = element.qty ?? 1;
              element.cartAttributeDtoList?.forEach((value) {
                orderCustomizationWatch.selectedAttributeList.add(CartAttributeDataDtoList(attributeUuid: value.attributeUuid, attributeNameUuid: value.attributeNameUuid));
              });
            });
            myTrayWatch.notify();
          }
        }
      }
    });
  }


  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final orderCustomizationWatch = ref.watch(orderCustomizationController);
    return orderCustomizationWatch.productDetailState.isLoading
        ? const ShimmerOrderCustomizationWeb()
        : Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      ref.read(navigationStackProvider).pop();
                    },
                    child: CommonSVG(
                      strIcon: AppAssets.svgArrowBack,
                      svgColor: AppColors.black,
                      width: 16.w,
                      height: 14.w,
                    ),
                  ).paddingOnly(top: 30.h)
                ],
              ).paddingOnly(left: context.width * 0.04),
              SizedBox(height: context.height * 0.03),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: context.height * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(child: _productDetailsWidget()),
                            SizedBox(height: context.height * 0.03),

                            ///Check Box For Remember Customization
                            // InkWell(
                            //   onTap: () =>
                            //       orderCustomizationWatch.updateRememberCustomize(),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       Icon(orderCustomizationWatch.isRememberCustomization
                            //           ? Icons.check_box_rounded
                            //           : Icons.check_box_outline_blank_rounded),
                            //       SizedBox(
                            //         width: 10.w,
                            //       ),
                            //       CommonText(
                            //         title: LocalizationStrings
                            //             .keyRememberCustomization.localized,
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.02,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListView.builder(
                              itemCount: orderCustomizationWatch.productDetailState.success?.data?.productAttributes?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CustomizationWidget(
                                  isMandatory: orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].isMandatory ?? false,
                                  customizationItems: orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].productAttributeNames,
                                  title: orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].attributeName ?? '',
                                  onTap: (attributeNameIndex) {
                                    /// Add attribute selection in list
                                    orderCustomizationWatch.updateAttributeSelection(orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].attributeUuid ?? '',
                                        orderCustomizationWatch.productDetailState.success?.data?.productAttributes?[index].productAttributeNames?[attributeNameIndex].attributeNameUuid ?? '');
                                  },
                                ).paddingOnly(bottom: 30.h);
                              }),
                          _bottomWidget(),
                          SizedBox(height: context.height * 0.1),
                        ],
                      ),
                    )
                  ],
                ).paddingSymmetric(horizontal: context.width * 0.04),
              ),
            ],
          );
  }

  Widget _productDetailsWidget() {
    final orderCustomizationWatch = ref.watch(orderCustomizationController);
    return SafeArea(
      child: Container(
        height: context.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Container(
                height: context.height * 0.3,
                width: context.height * 0.3,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.black)
                ),
                child: ClipOval(
                  child: CacheImage(
                    imageURL: orderCustomizationWatch.productDetailState.success?.data?.productImageUrl ?? '',
                    contentMode: BoxFit.contain,
                  )
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            CommonText(
              title: orderCustomizationWatch.productDetailState.success?.data?.productName ?? '',
              textStyle: TextStyles.medium.copyWith(fontSize: 20.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            CommonText(
              title: orderCustomizationWatch.productDetailState.success?.data?.categoryName ?? '',
              textStyle: TextStyles.regular.copyWith(fontSize: 16.sp),
              maxLines: 5,
              clrfont: AppColors.grey7E7E7E,
            ),
            const Spacer(),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }

  Widget _bottomWidget() {
    final orderCustomizationWatch = ref.watch(orderCustomizationController);
    final myTrayWatch = ref.watch(myTrayController);
    return SizedBox(
      height: context.height * 0.1,
      width: double.maxFinite,
      child: CommonCard(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.r))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                     _widgetQtyButton(isPlus: false,orderCustomizationWatch:orderCustomizationWatch),
                    Container(
                      width: 40.w,
                      alignment: Alignment.center,
                      child: CommonText(
                        title: orderCustomizationWatch.qty.toString(),
                        fontSize: 16.sp,
                      ),
                    ),
                     _widgetQtyButton(isPlus: true,orderCustomizationWatch:orderCustomizationWatch),
                  ],
                ).paddingOnly(right: 15.w),
              ],
            ),
            Flexible(
              child: CommonButton(
                height: 50.h,
                isButtonEnabled: true,
                buttonEnabledColor: AppColors.blue009AF1,
                buttonText: LocalizationStrings.keyGoToTray.localized,
                rightIcon: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.white,
                ),
                isLoading: myTrayWatch.addCartState.isLoading || myTrayWatch.validateItemState.isLoading || myTrayWatch.updateCartQtyState.isLoading,
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
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 30.w),
      ),
    );
  }

  Widget _widgetQtyButton({required bool isPlus, required OrderCustomizationController orderCustomizationWatch}) {
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
