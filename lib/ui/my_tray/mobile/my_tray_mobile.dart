import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/my_tray/mobile/helper/frequently_brought_together_widget.dart';
import 'package:kody_operator/ui/my_tray/mobile/helper/my_tray_tile_list.dart';
import 'package:kody_operator/ui/my_tray/mobile/shimmer/my_tray_shimmer_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_check_box.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:shimmer/shimmer.dart';

class MyTrayMobile extends ConsumerStatefulWidget {
  final Function? popCallBack;
  final FromScreen? fromScreen;
  const MyTrayMobile( {Key? key, this.popCallBack,this.fromScreen,}) : super(key: key);

  @override
  ConsumerState<MyTrayMobile> createState() => _MyTrayMobileState();
}

class _MyTrayMobileState extends ConsumerState<MyTrayMobile>
    with BaseConsumerStatefulWidget,BaseDrawerPageWidgetMobile {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      // ref.read(locationController).updateSelectedTempLocation(ref.read(locationController).selectedLocationIndex);
      final myTrayWatch = ref.read(myTrayController);
      myTrayWatch.clearCart();
      myTrayWatch.updateAdditionalNoteText(Session.getAddedAdditionalNote());
      await myTrayWatch.cartCountApi(context).then((value) async{
        await myTrayWatch.cartListApi(context).then((value) async{
          await myTrayWatch.frequentlyBoughtListApi(context);
        });
      });
    });
  }


  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final myTrayWatch = ref.watch(myTrayController);
    return  CommonWhiteBackground(
      appBar:  CommonAppBar(
        backgroundColor: AppColors.black,
        customTitleWidget:(myTrayWatch.cartListState.isLoading ||
            myTrayWatch.cartCountState.isLoading)
            ? Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.black),
            height: 20.h,
            width: 70.w,
          ),
        )
            : RichText(
          text: TextSpan(
              text: LocalizationStrings.keyMyTray.localized,
              style: TextStyles.medium
                  .copyWith(color: AppColors.white, fontSize: 18.sp),
              children: <TextSpan>[
                TextSpan(
                  text:
                  '   (${myTrayWatch.cartCountState.success?.data ?? 0} ${LocalizationStrings.keyItem.localized})',
                  style: TextStyles.regular
                      .copyWith(color: AppColors.white.withOpacity(.9)),
                )
              ]),
        ),
        isDrawerEnable: true,
      ), child: Column(children: [Expanded(child: _bodyWidget()),
          myTrayWatch.cartListState.success?.data?.cartDtoList?.isEmpty ?? false
        ? const Offstage()
        : _bottomButton(),]),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final myTrayWatch = ref.watch(myTrayController);
    return !(myTrayWatch.cartListState.isLoading|| myTrayWatch.frequentlyBoughtListState.isLoading)
        ? myTrayWatch.cartListState.success?.data?.cartDtoList?.isNotEmpty ??
                false
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideLeftTransition(
                      delay: 100,
                      child: _addMoreItemsAdditionalNoteWidget(),
                    ),
                    ListView.builder(
                      itemCount: myTrayWatch
                          .cartListState.success?.data?.cartDtoList?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        CartDtoList? model = myTrayWatch
                            .cartListState.success?.data?.cartDtoList?[index];
                        return SlideLeftTransition(
                          delay: 100,
                          child: MyTrayTileList(
                              trayModel: model,
                              onTap: () async {
                                await myTrayWatch.updateProductUDID(
                                    model?.uuid ?? '',
                                    model?.productUuid ?? '');
                                widget.popCallBack?.call(true);

                                ref.read(navigationStackProvider).push(
                                      NavigationStackItem.orderCustomization(
                                          fromScreen: FromScreen.myTray,
                                          productUuid: model?.productUuid ?? '',
                                          uuid: model?.uuid ?? ''),
                                    );
                              }).paddingOnly(bottom: 10.h),
                        );
                      },
                    ).paddingOnly(
                      left: 20.w,
                      right: 20.w,
                    ),
                    SlideLeftTransition(
                      delay: 300,
                      child: _markAddComboWidget(myTrayWatch),
                    ),
                    SlideLeftTransition(
                      delay: 400,
                      child: _additionalNoteTextAddedWidget(myTrayWatch),
                    ),
                    Divider(
                      height: 40.h,
                    ).paddingSymmetric(
                      horizontal: 20.w,
                    ),
                    (myTrayWatch.frequentlyBoughtListState.success?.data?.isNotEmpty ?? false) ?  const SlideLeftTransition(
                      delay: 400,
                      child: FrequentlyBroughtTogetherWidget(),
                    ) : const Offstage(),


                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              )
            : _emptyMyTrayWidget()
        : const MyTrayMobileShimmer();
  }

  Widget _bottomButton() {
    final myTrayWatch = ref.watch(myTrayController);
    return SlideUpTransition(
      delay: 200,
      duration: 300,
      child: CommonButton(
        width: context.width,
        buttonText: myTrayWatch.myTrayList.isNotEmpty
            ? LocalizationStrings.keySelectYourLocation.localized
            : LocalizationStrings.keyBackToHome.localized,
        rightIcon: const Icon(
          Icons.arrow_forward,
          color: AppColors.white,
        ),
        isButtonEnabled: true,
        buttonEnabledColor: AppColors.blue009AF1,
        rightIconLeftPadding: 5.w,
        onTap: () {
          if (myTrayWatch.myTrayList.isNotEmpty) {
            ref.read(navigationStackProvider).push(
                  NavigationStackItem.selectLocationDialog(
                    buttonText: LocalizationStrings.keyPlaceOrder.localized,
                    onButtonPressed: () {
                      myTrayWatch.placeOrderApi(context, ref, isMobile: true).then((value) {
                        if (myTrayWatch.placeOrderState.success?.status ==
                            ApiEndPoints.apiStatus_200) {
                          Session.saveLocalData(keyAddedAdditionalNote, '');
                          ref.read(navigationStackProvider).push(
                              const NavigationStackItem.orderSuccessful(
                                  fromScreen: FromScreen.none));
                        }
                      });
                    },
                  ),
                );
          } else {
            ref
                .read(navigationStackProvider)
                .popUntil(const NavigationStackItem.home());
          }
        },
        isLoading: myTrayWatch.placeOrderState.isLoading,
      ).paddingSymmetric(horizontal: 20.w,vertical: 20.h),
    );
  }

  Widget _emptyMyTrayWidget() {
    return SlideUpTransition(
      delay: 100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonSVG(
                strIcon: AppAssets.svgMyTrayEmpty,
                height: 282.h,
                width: 282.h,
                boxFit: BoxFit.cover),
            SizedBox(
              height: 30.h,
            ),
            Text(
              LocalizationStrings.keyYourTrayIsEmpty.localized,
              style: TextStyles.regular.copyWith(fontSize: 18.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              LocalizationStrings.keyYouHaveNotAddedCart.localized,
              style: TextStyles.regular.copyWith(color: AppColors.grey7E7E7E),
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: 50.w),
          ],
        ),
      ),
    );
  }

  Widget _addMoreItemsAdditionalNoteWidget() {
    return Consumer(
      builder: (context, ref, child) {
        final myTrayWatch = ref.watch(myTrayController);
        return Row(
          children: [
            _commonMoreItem(
                width:context.width*0.5 ,
                icon: AppAssets.svgAddMore,
                title: LocalizationStrings.keyAddMoreItems.localized,
                onTap: () {
                  ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.orderHome());
                }),
            SizedBox(
              width: myTrayWatch.additionalNoteText.isEmpty?0.w:20.w,
            ),
            myTrayWatch.additionalNoteText.isEmpty?_commonMoreItem(
                icon: AppAssets.svgAdditionalNote,
                title: LocalizationStrings.keyAdditionalNote.localized,
                onTap: () {
                  ref.read(navigationStackProvider).push(
                      const NavigationStackItem.additionalNote(additionalNote: ''));
                }): const Offstage(),
          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 20.h);
      }
    );
  }

  Widget _commonMoreItem(
      {required String icon,
      required String title,
      required Function() onTap,
      double? width}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 60.h,
          width:  width,
          child: CommonCard(
            color: AppColors.whiteF7F7FC,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonSVG(strIcon: icon),
                SizedBox(
                  width: 10.w,
                ),
                CommonText(
                  title: title,
                  fontWeight: TextStyles.fwMedium,
                  clrfont: AppColors.primary2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _markAddComboWidget(MyTrayController myTrayWatch) {
    return myTrayWatch.myTrayList.length > 1
        ? Row(
            children: [
              CommonCheckBox(
                value: myTrayWatch.isMarkToAddYourFavCombo,
                onChanged: (bool? value) {
                  myTrayWatch.updateMarkToAddYourFavCombo();
                },
              ),
              CommonText(
                title: LocalizationStrings
                    .keyMarkToAddYourFavouriteCombo.localized,
              )
            ],
          ).paddingSymmetric(horizontal: 20.w, vertical: 10.h)
        : const Offstage();
  }

  Widget _additionalNoteTextAddedWidget(MyTrayController myTrayWatch) {
    return myTrayWatch.additionalNoteText.isNotEmpty
        ? Container(
          decoration: BoxDecoration(
            color:  AppColors.whiteF7F7FC,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CommonText(
                        title: LocalizationStrings.keyAdditionalNote.localized,
                        clrfont: AppColors.greyA3A3A3,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          ref.read(navigationStackProvider).push(
                              NavigationStackItem.additionalNote(
                                  additionalNote:
                                      myTrayWatch.additionalNoteText));
                        },
                        child: CommonText(
                          title: LocalizationStrings.keyEdit.localized,
                          clrfont: AppColors.primary2,
                          textDecoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CommonText(
                    title: myTrayWatch.additionalNoteText,
                    maxLines: 50,
                  ),
                ],
              ).paddingAll(20.h),
        ).paddingSymmetric(horizontal: 20.w)
        : const Offstage();
  }
}
