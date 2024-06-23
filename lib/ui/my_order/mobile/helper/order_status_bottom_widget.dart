import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/controller/my_order/order_home_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:lottie/lottie.dart';

class OrderStatusBottomWidget extends StatelessWidget with BaseStatelessWidget {
  const OrderStatusBottomWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final myOrderWatch = ref.watch(myOrderController);
      final homeWatch = ref.watch(orderHomeController);
      return Visibility(
        visible:false,
      //  visible: myOrderWatch.ongoingSocketOrders != null && homeWatch.getIsShowingOrderStatusWidget(),
        child: SlideUpTransition(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 80.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.black171717),
                child: PageView.builder(
                  itemCount: myOrderWatch.ongoingSocketOrders?.length,
                  onPageChanged: (pageNumber) {
                    myOrderWatch.updateSelectedOrderPageIndex(pageNumber);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        // Lottie.asset(myOrderWatch.orderStatus == OrderStatus.preparing ? AppAssets.animPreparingOrder :AppAssets.animOrderDispatch,height: 54.h,width: 54.h),
                        Lottie.asset(
                          getOrderStatusIcon(myOrderWatch.ongoingSocketOrders?[index].status ?? '')['icon'] ?? AppAssets.animOrderProcessing,
                          height: 54.h,
                          width: 54.h,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        getOrderStatusIcon(myOrderWatch.ongoingSocketOrders?[index].status ?? '')['status'] ?? '',
                                        style: TextStyles.regular.copyWith(color: AppColors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      '${getOrderStatusIcon(myOrderWatch.ongoingSocketOrders?[index].status ?? '')['orderOrReq'] ?? ''} ${myOrderWatch.ongoingSocketOrders?[index].uuid}',
                                      style: TextStyles.regular.copyWith(color: AppColors.white.withOpacity(0.5), fontSize: 12.sp),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      '${myOrderWatch.ongoingSocketOrders?[index].ordersItems?.map((e) => e.productName).join(',')}',
                                      style: TextStyles.regular.copyWith(
                                        color: AppColors.white.withOpacity(0.5),
                                        fontSize: 12.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              CommonButton(
                                height: 32.h,
                                width: 91.w,
                                buttonEnabledColor: AppColors.primary2,
                                buttonText: LocalizationStrings.keyOrderStatus.localized,
                                buttonTextStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
                                onTap: () {
                                  ref.read(navigationStackProvider).push(NavigationStackItem.orderFlowStatus(orderId: myOrderWatch.ongoingSocketOrders?[index].uuid ?? ''));
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: () {
                            ///Dismiss order showing widget
                            homeWatch.updateIsShowOrderStatusWidget(false);
                          },
                          child: const CommonSVG(strIcon: AppAssets.svgCloseWhiteBackBg),
                        )
                      ],
                    ).paddingSymmetric(horizontal: 10.w);
                  },
                ),
              ).paddingAll(20.h),
              SizedBox(
                height: 20.h,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      myOrderWatch.ongoingSocketOrders?.length??0,
                      (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 7.h,
                          width: 7.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: myOrderWatch.selectedOrderPageIndex == index ? AppColors.blue009AF1 : AppColors.greyA3A3A3,
                          ),
                        );
                      },
                    ),
                  ),
                ).paddingOnly(bottom: 15.h),
              )
            ],
          ),
        ),
      );
    });
  }

  Map<String, String> getOrderStatusIcon(String? orderStatus) {
    Map<String, String> map = {};
    OrderStatusEnum? orderStatusEnum = orderStatusEnumValues.map[orderStatus ?? ''];
    switch (orderStatusEnum ?? OrderStatusEnum.PENDING) {
      case OrderStatusEnum.ACCEPTED:
        {
          map = {
            'status': LocalizationStrings.keyOrderAccepted.localized,
            'icon': AppAssets.animOrderAccept,
            'orderOrReq': LocalizationStrings.keyOrderNo.localized,
          };
        }
        break;

      case OrderStatusEnum.REJECTED:
        {
          map = {
            'status': LocalizationStrings.keyOrderRejected.localized,
            'icon': AppAssets.animOrderReject,
            'orderOrReq': LocalizationStrings.keyOrderNo.localized,
          };
        }
        break;

      case OrderStatusEnum.PREPARED:
        {
          map = {
            'status': LocalizationStrings.keyOrderPrepared.localized,
            'icon': AppAssets.animPreparingOrder,
            'orderOrReq': LocalizationStrings.keyOrderNo.localized,
          };
        }
        break;

      case OrderStatusEnum.DISPATCH:
        {
          map = {
            'status': LocalizationStrings.keyOrderDispatched.localized,
            'icon': AppAssets.animOrderDispatch,
            'orderOrReq': LocalizationStrings.keyOrderNo.localized,
          };
        }
        break;
/*
      case OrderStatusEnum.requestAccepted:
        {
          map = {
            'status': LocalizationStrings.keyRequestAccepted.localized,
            'icon': AppAssets.animOrderAccept,
            'orderOrReq': LocalizationStrings.keyReqNo.localized,
          };
        }
        break;

      case OrderStatusEnum.receiverAccepted:
        {
          map = {
            'status': LocalizationStrings.keyReceiverAccepted.localized,
            'icon': AppAssets.animOrderAccept,
            'orderOrReq': LocalizationStrings.keyReqNo.localized,
          };
        }
        break;

      case OrderStatusEnum.onTheWay:
        {
          map = {
            'status': LocalizationStrings.keyOnTheWay.localized,
            'icon': AppAssets.animOrderDispatch,
            'orderOrReq': LocalizationStrings.keyReqNo.localized,
          };
        }
        break;

      case OrderStatusEnum.processing:
        {
          map = {
            'status': LocalizationStrings.keyProcessing.localized,
            'icon': AppAssets.animOrderProcessing,
            'orderOrReq': LocalizationStrings.keyReqNo.localized,
          };
        }
        break;*/
      case OrderStatusEnum.PENDING:
        map = {
          'status': LocalizationStrings.keyOrderPending.localized,
          'icon': AppAssets.animOrderProcessing,
          'orderOrReq': LocalizationStrings.keyOrderNo.localized,
        };
      case OrderStatusEnum.PARTIALLY_DELIVERED:
      case OrderStatusEnum.DELIVERED:
      case OrderStatusEnum.CANCELED:
      case OrderStatusEnum.IN_TRAY:
      case OrderStatusEnum.NONE:
      case OrderStatusEnum.OPERATOR_CANCELED:
      {
        map = {
          'status': LocalizationStrings.keyOrderRejected.localized,
          'icon': AppAssets.animOrderReject,
          'orderOrReq': LocalizationStrings.keyOrderNo.localized,
        };
      }
      break;
      case OrderStatusEnum.ROBOT_CANCELED:
        // TODO: Handle this case.
    }

    return map;
  }
}
