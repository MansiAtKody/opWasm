import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_history/web/helper/filter_popup_web.dart';
import 'package:kody_operator/ui/order_history/web/helper/recent_search_web.dart';
import 'package:kody_operator/ui/utils/anim/dialog_transition.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_searchbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderHistoryWeb extends ConsumerStatefulWidget {
  final OrderType? orderType;

  const OrderHistoryWeb({Key? key, this.orderType}) : super(key: key);

  @override
  ConsumerState<OrderHistoryWeb> createState() => _OrderHistoryWebState();
}

class _OrderHistoryWebState extends ConsumerState<OrderHistoryWeb>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final orderHistoryWatch = ref.read(orderHistoryController);
      orderHistoryWatch.disposeController(isNotify: true);
      orderHistoryWatch.updateSelectedOrderType(ref,
          orderType: widget.orderType);
      orderHistoryWatch.searchFocus.addListener(() {
        if (orderHistoryWatch.searchFocus.hasFocus &&
            orderHistoryWatch.searchList.isNotEmpty) {
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

  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tooltipController.isShowing) {
          tooltipController.hide();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: FadeBoxTransition(child: _centerWidget()),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

  ///Top Widget
  Widget _topWidget(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderHistoryWatch = ref.watch(orderHistoryController);
        return Row(
          children: [
            ///Search bar
            Row(
              children: [
                CompositedTransformTarget(
                  link: link,
                  child: OverlayPortal(
                    controller: tooltipController,
                    overlayChildBuilder: (BuildContext context) {
                      return CompositedTransformFollower(
                        link: link,
                        targetAnchor: Alignment.bottomLeft,
                        child:const  Align(
                          alignment: AlignmentDirectional.topStart,
                          child:  RecentSearchWeb()
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 0.4.sw,
                      height: 0.07.sh,
                      child: CommonSearchBar(
                        bgColor: AppColors.whiteF7F7FC,
                        controller: orderHistoryWatch.ctrSearch,
                        leftIcon: AppAssets.svgSearchWeb,
                        textColor: AppColors.grey626262,
                        focusNode: orderHistoryWatch.searchFocus,
                        clrSearchIcon: AppColors.grey626262,
                        placeholder:
                            LocalizationStrings.keySearchText.localized,
                        borderRadius: 57.r,
                        onChanged: (searchText) async {
                          if (orderHistoryWatch.debounce?.isActive ?? false) orderHistoryWatch.debounce?.cancel();

                          orderHistoryWatch.debounce = Timer(const Duration(milliseconds: 500), () async{
                            await getOrderListApiCall(orderHistoryWatch);
                            orderHistoryWatch.selectedOrderType?.orderType ==
                                OrderType.products
                                ? null
                                : orderHistoryWatch.updateSearchedItemList(
                                orderHistoryWatch.serviceHistoryList);
                          });

                        },
                        onTap: () {},
                        onFieldSubmitted: (searchText) {
                          orderHistoryWatch.updateSearchList();
                        },
                      ).paddingSymmetric(horizontal: 20.w),
                    ),
                  ),
                ),

                ///Filter popUp
                InkWell(
                  onTap: () {
                    showAnimatedFilterDialog(
                      context,
                      child: DialogTransition(
                        onPopCall: (animationController) {
                          orderHistoryWatch.updateAnimationController(animationController);
                        },
                        child: SizedBox(
                          height: context.height,
                          width: context.width * 0.3,
                          child: const FilterPopUpWeb(),
                        ),
                      ),
                    );
                  },
                  child: const CommonSVG(
                    strIcon: AppAssets.svgFilterWhite,
                    boxFit: BoxFit.scaleDown,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  ///center widget
  Widget _centerWidget() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderHistoryWatch = ref.watch(orderHistoryController);
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                CommonText(
                  title: LocalizationStrings.keyHistory.localized,
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 24.sp,
                  ),
                ),
                ///Search and Filter widget
                _topWidget(context),
              ]).paddingOnly(top: 20.h, bottom: 30.h),
              Row(
                children: List.generate(
                  orderHistoryWatch.orderTypeList.length,
                  (index) {
                    OrderHistoryModel selectedOrderType =
                        orderHistoryWatch.orderTypeList[index];
                    return ListBounceAnimation(
                      onTap: () {
                        orderHistoryWatch.updateSelectedOrderType(ref,
                            selectedOrderType: selectedOrderType);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                            color: orderHistoryWatch.selectedOrderType ==
                                    selectedOrderType
                                ? AppColors.blue009AF1
                                : AppColors.lightPink),
                        height: 40.h,
                        width: 110.w,
                        child: Center(
                          child: CommonText(
                            title: selectedOrderType.name,
                            textStyle: TextStyles.regular.copyWith(
                                fontSize: 12.sp,
                                color: orderHistoryWatch.selectedOrderType ==
                                        selectedOrderType
                                    ? AppColors.white
                                    : AppColors.grey626262),
                          ),
                        ),
                      ),
                    ).paddingOnly(right: 20.w);
                  },
                ),
              ),
              Expanded(
                child: orderHistoryWatch.selectedOrderType?.screen ??
                    const Offstage(),
              ),
            ],
          ).paddingSymmetric(horizontal: 40.w),
        ).paddingAll(20.h);
      },
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
                    .orderListScrollController.position.maxScrollExtent -
                300)) {
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
