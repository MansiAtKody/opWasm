import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_history/mobile/helper/filter_popup_mobile.dart';
import 'package:kody_operator/ui/order_history/mobile/helper/order_history_list.dart';
import 'package:kody_operator/ui/order_history/mobile/helper/recent_search_mobile.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_searchbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class OrderHistoryMobile extends ConsumerStatefulWidget {
  const OrderHistoryMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderHistoryMobile> createState() => _OrderHistoryMobileState();
}

class _OrderHistoryMobileState extends ConsumerState<OrderHistoryMobile>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final orderHistoryWatch = ref.read(orderHistoryController);
      orderHistoryWatch.disposeController(isNotify: true);
      orderHistoryWatch.searchFocus.addListener(() {
        if (orderHistoryWatch.searchFocus.hasFocus && orderHistoryWatch.searchList.isNotEmpty && orderHistoryWatch.ctrSearch.text.isNotEmpty) {
          tooltipController.show();
        } else {
          tooltipController.hide();
        }
      });
    });
  }

  ///Search popUp controllers
  final OverlayPortalController tooltipController = OverlayPortalController();
  final link = LayerLink();
  OverlayEntry? overlayEntry;

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  ///Dispose
  @override
  void dispose() {
    removeHighlightOverlay();
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
        if (tooltipController.isShowing) {
          tooltipController.hide();
        }
      },
      child: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final orderHistoryWatch = ref.watch(orderHistoryController);
    return Column(
      children: [
        CommonAppBar(
          backgroundColor: AppColors.black,
          customTitleWidget: const CommonSVG(strIcon: AppAssets.svgDasher),
          isDrawerEnable: true,
          actions: [
            ///Appbar actions
            InkWell(
                onTap: () {
                  if(!orderHistoryWatch.orderListState.isLoading) {
                    showAnimatedFilterDialog(
                    context,
                    child: FadeBoxTransition(
                      onPopCall: (animationController) {
                        orderHistoryWatch
                            .updateAnimationController(animationController);
                      },
                      child: SizedBox(
                        height: context.height,
                        width: context.width * 0.8,
                        child: const FilterPopUpMobile(),
                      ),
                    ),
                  );
                  }
                },
                child: const CommonSVG(strIcon: AppAssets.svgFilterMobile)
                    .paddingOnly(right: 12.w))
          ],
        ),

        ///Search bar
        CompositedTransformTarget(
          link: link,
          child: OverlayPortal(
            controller: tooltipController,
            overlayChildBuilder: (BuildContext context) {
              return CompositedTransformFollower(
                link: link,
                targetAnchor: Alignment.bottomLeft,
                child:const Align(
                  alignment: AlignmentDirectional.topStart,
                  child:  RecentSearchMobile(),
                ),
              );
            },
            child: SizedBox(
                    height: 0.07.sh,
                    child: CommonSearchBar(
                      bgColor: AppColors.black1F1E1F,
                      controller: orderHistoryWatch.ctrSearch,
                      focusNode: orderHistoryWatch.searchFocus,leftIcon: AppAssets.svgSearchWeb,
                      textColor: AppColors.white,
                      clrSearchIcon: AppColors.white,
                      placeholder: LocalizationStrings.keySearchText.localized,
                      borderRadius: 57.r,
                      cursorColor: AppColors.white,
                      onChanged: (searchText) async{
                        if (orderHistoryWatch.debounce?.isActive ?? false) orderHistoryWatch.debounce?.cancel();

                        orderHistoryWatch.debounce = Timer(const Duration(milliseconds: 500), () async{
                          await getOrderListApiCall(orderHistoryWatch);
                          orderHistoryWatch.updateSearchedItemList(
                              orderHistoryWatch.serviceHistoryList);
                        });
                      },
                      onFieldSubmitted: (searchText) {
                        orderHistoryWatch.updateSearchList();
                      },
                    ).paddingSymmetric(horizontal: 12.w),
                  ),
          ),
        ).paddingOnly(bottom: 30.h),

        /// Center Widget
        Expanded(
             child:CommonWhiteBackground(
                  child: Column(
                    children: [

                      /// Heading Widget
                      Row(
                        children: [
                          ...List.generate(orderHistoryWatch.orderTypeList.length,
                                (index) =>
                          Expanded(
                              child: ListBounceAnimation(
                          transformSize: 1.5,
                            onTap: () {
                              orderHistoryWatch.updateSelectedOrderType(ref,
                                  selectedOrderType:
                                      orderHistoryWatch.orderTypeList[index]);
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(75.r)),
                                  color: orderHistoryWatch.selectedOrderType ==
                                          orderHistoryWatch.orderTypeList[index]
                                      ? AppColors.blue009AF1
                                      : AppColors.whiteF7F7FC),
                              child: Center(
                                child: CommonText(
                                  title:
                                      orderHistoryWatch.orderTypeList[index].name,
                                  textStyle: TextStyles.regular.copyWith(
                                      fontSize: 12.sp,
                                      color: orderHistoryWatch
                                                  .selectedOrderType ==
                                              orderHistoryWatch.orderTypeList[index]
                                          ? AppColors.white
                                          : AppColors.grey626262),
                                ),
                              ),),
                        ).paddingOnly(right: 15.w),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 14.w, vertical: 14.h),

                      ///List Widget
                      const Expanded(
                               child: FadeBoxTransition(
                                child:OrderHistoryList(),
                             ),
                        )
                    ],
                  ).paddingOnly(left: 12.w, right: 12.w, top: 12.h),
                ),
        ),
      ],
    );
  }

  /// Order list with pagination
  Future getOrderListApiCall(OrderHistoryController orderHistoryWatchWatch) async {
    orderHistoryWatchWatch.resetPaginationOrderList();
    orderHistoryWatchWatch.getOrderListApi(context);
    orderHistoryWatchWatch.orderListScrollController.addListener(() {
      if (mounted) {
        if (orderHistoryWatchWatch.orderListScrollController.position.pixels >=
            (orderHistoryWatchWatch
                .orderListScrollController.position.maxScrollExtent)) {
          if (orderHistoryWatchWatch.orderListState.success?.hasNextPage ??
              false) {
            orderHistoryWatchWatch.incrementOrderListPageNumber();
            orderHistoryWatchWatch.getOrderListApi(context);
          }
        }
      }
    });
  }
}
