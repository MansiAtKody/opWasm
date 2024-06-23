import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/location/select_location_dialog_controller.dart';
import 'package:kody_operator/ui/location/web/select_location_dialog_web.dart';
import 'package:kody_operator/ui/my_tray/web/helper/added_additional_note_widget.dart';
import 'package:kody_operator/ui/my_tray/web/helper/addmore_additional_note_widget.dart';
import 'package:kody_operator/ui/my_tray/web/helper/frequently_brought_together_widget_web.dart';
import 'package:kody_operator/ui/my_tray/web/helper/my_tray_tile_list_web.dart';
import 'package:kody_operator/ui/my_tray/web/order_successful_web.dart';
import 'package:kody_operator/ui/my_tray/web/shimmer/my_tray_shimmer_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_checkbox.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';
import 'package:shimmer/shimmer.dart';

class MyTrayWeb extends ConsumerStatefulWidget {
  const MyTrayWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<MyTrayWeb> createState() => _MyTrayWebState();
}

class _MyTrayWebState extends ConsumerState<MyTrayWeb>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final myTrayWatch = ref.read(myTrayController);
      myTrayWatch.updateAdditionalNoteText(Session.getAddedAdditionalNote());
      await myTrayWatch.cartCountApi(context).then((value) async {
        await myTrayWatch.cartListApi(context).then((value) async {
          await myTrayWatch.frequentlyBoughtListApi(context);
        });
      });
      myTrayWatch.disposeController(isNotify: true);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final myTrayWatch = ref.watch(myTrayController);
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
      Expanded(child: _bodyWidget()),
      !(myTrayWatch.cartListState.isLoading &&
              myTrayWatch.cartCountState.isLoading)
          ? myTrayWatch.cartListState.success?.data?.cartDtoList?.isEmpty ??
                  false
              ? const SizedBox()
              : _bottomWidget()
          : const MyTrayWebShimmer()
    ]);
  }

  ///Body Widget
  Widget _bodyWidget() {
    final myTrayWatch = ref.watch(myTrayController);
    if (!(myTrayWatch.cartListState.isLoading ||
        myTrayWatch.frequentlyBoughtListState.isLoading)) {
      return myTrayWatch.cartListState.success?.data?.cartDtoList?.isEmpty ??
              false
          ? EmptyStateWidget(
              title: LocalizationStrings.keyNoCart.localized,
              subTitle: LocalizationStrings.keyYouHaveNotAddedCart.localized,
            )
          : Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),

                ///Add not and add more item widget
                const AddMoreAdditionalNoteWidget(),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///My tray list
                        Column(
                          children: [
                            _myTrayWidget(),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// Added additional note widget
                            const AddedAdditionalNoteWidgetWeb(),

                            SizedBox(
                              height: 30.h,
                            ),

                            ///Frequently bought widget
                            myTrayWatch.frequentlyBoughtListState.success?.data
                                        ?.isNotEmpty ??
                                    false
                                ? const FrequentlyBroughtTogetherWidgetWeb()
                                : const Offstage(),

                            SizedBox(
                              height: 80.h,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
    } else {
      return const MyTrayWebShimmer();
    }
  }

  ///my Tray list
  _myTrayWidget() {
    final myTrayWatch = ref.watch(myTrayController);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount:
                myTrayWatch.cartListState.success?.data?.cartDtoList?.length ??
                    0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              CartDtoList? model =
                  myTrayWatch.cartListState.success?.data?.cartDtoList?[index];
              return MyTrayTileListWeb(trayModel: model)
                  .paddingOnly(bottom: 10.h);
            },
          ).paddingOnly(left: 30.w, right: 30.w, top: 20.h),
          Row(
            children: [
              CommonCheckBox(
                value: myTrayWatch.markAsFavourite,
                onChanged: (rememberMe) {
                  myTrayWatch.updateRememberMe(rememberMe ?? false);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ).paddingOnly(right: 10.w),
              CommonText(
                title: LocalizationStrings.keyMarkToAddFavouriteCombo.localized,
                textStyle: TextStyles.regular
                    .copyWith(fontSize: 18.sp, color: AppColors.black),
              ),
            ],
          ).paddingOnly(left: 30.w, bottom: 30.h),
        ],
      ),
    ).paddingSymmetric(horizontal: 20.w);
  }

  ///bottom widget
  _bottomWidget() {
    final myTrayWatch = ref.watch(myTrayController);
    return Container(
      height: 100.h,
      color: AppColors.black171717,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                title: LocalizationStrings.keyTotalOrder.localized,
                textStyle: TextStyles.regular
                    .copyWith(fontSize: 16.sp, color: AppColors.grey8F8F8F),
              ),
              SizedBox(
                height: 9.h,
              ),
              (myTrayWatch.cartCountState.isLoading ||
                      myTrayWatch.cartListState.isLoading ||
                      myTrayWatch.frequentlyBoughtListState.isLoading)
                  ? itemCountShimmer()
                  : CommonText(
                      title: '${myTrayWatch.cartCountState.success?.data ?? 0}',
                      textStyle: TextStyles.medium
                          .copyWith(fontSize: 20.sp, color: AppColors.white),
                    )
            ],
          ),
          CommonButton(
            height: 50.h,
            width: 176.w,
            onTap: () {
              ref
                  .read(selectLocationDialogController)
                  .onLocationBottomSheetOpened();
              showCommonDialog(
                barrierDismissible: false,
                context: context,
                width: context.width * 0.6,
                height: context.height * 0.7,
                dialogBody: SelectLocationDialogWeb(
                  buttonText: LocalizationStrings.keyPlaceOrder.localized,
                  onButtonPressed: () {
                    myTrayWatch.placeOrderApi(context, ref).then((value) {
                      if (myTrayWatch.placeOrderState.success?.status ==
                          ApiEndPoints.apiStatus_200) {
                        Session.saveLocalData(keyAddedAdditionalNote, '');
                        return showCommonDialog(
                            context: context,
                            dialogBody: const OrderSuccessfulWeb(
                                fromScreen: FromScreen.none));
                      }
                    });
                  },
                ),
              );
            },
            isButtonEnabled: true,
            buttonTextColor: AppColors.white,
            buttonEnabledColor: AppColors.blue009AF1,
            // borderColor: AppColors.primary,
            buttonText: LocalizationStrings.keySelectLocation.localized,
          )
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }

  Widget itemCountShimmer() {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.white,
        child: CommonShimmer(height: 20.h, width: context.width * 0.05));
  }
}
