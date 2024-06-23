import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_management/mobile/helper/user_card_top_widget_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../framework/controller/order_management/order_status_controller.dart';

class PastOrderCardMobile extends StatelessWidget with BaseStatelessWidget {
  final SocketOrders? order;
  final int index;

  const PastOrderCardMobile({
    Key? key,
    required this.index,
    required this.order,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              /// Name of person & order ID
              UserCardTopWidgetMobile(
                userName: (order?.entityName == null) ? 'Admin' : order?.entityName ?? '',
                place: order?.locationPointsName ?? '',
                orderNote: order?.additionalNote ?? '',
                ticketNo: order?.uuid ?? '',
              ),
              SizedBox(
                height: 21.h,
              ),

              /// List of the order
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final orderStatusWatch = ref.watch(orderStatusController);
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: order?.ordersItems?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, itemIndex) {
                      return Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40.r),
                            child: CacheImage(
                              height: 40.w,
                              width: 40.w,
                              imageURL: order?.ordersItems?[itemIndex].productImage ?? '',
                              contentMode: BoxFit.scaleDown,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  title: order?.ordersItems?[itemIndex].productName ?? '',
                                  textStyle: TextStyles.regular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                                CommonText(
                                  title: order?.ordersItems?[itemIndex].ordersItemAttributes?.map((e) => e.attributeNameValue).toList().join(',') ?? '',
                                  maxLines: 2,
                                  textStyle: TextStyles.regular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColors.grey8D8C8C,
                                  ),
                                )
                              ],
                            ).paddingOnly(left: 10.w),
                          ),
                          const Spacer(),
                          order?.ordersItems?[itemIndex].status == OrderStatusEnum.CANCELED.name?
                          const Offstage()
                              :(orderStatusWatch.orderItemStatusUpdate.isLoading && orderStatusWatch.updatingOrderItemIndex == itemIndex && orderStatusWatch.updatingOrderIndex == index)?
                          LoadingAnimationWidget.waveDots(color: AppColors.black, size: 10.sp).paddingOnly(right: 16.w)
                              :InkWell(
                            onTap: () async  {
                              orderStatusWatch.updatePreparedOrderStatus(order?.uuid??'', OrderStatusEnum.REJECTED,itemUuid:order?.ordersItems?[itemIndex].uuid );
                              await orderStatusWatch.orderItemStatusUpdateApi(context,order?.uuid??'' , order?.ordersItems?[itemIndex].uuid??'', OrderStatusEnum.OPERATOR_CANCELED);
                            },
                            child: SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: const CommonSVG(
                                strIcon: AppAssets.svgCancelOrder,
                                boxFit: BoxFit.scaleDown,
                              ),
                            ),
                          ).paddingOnly(right: 5.w),
                        ],
                      ).paddingSymmetric(horizontal: 10.w, vertical: 12.h);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 0,
                        color: AppColors.greyE6E6E6,
                      ).paddingSymmetric(horizontal: 15.w);
                    },
                  );
                },
              ),
              SizedBox(
                height: 9.h,
              ),

              /// Dispatch Button
              CommonButton(
                height: 40.h,
                isButtonEnabled: true,
                width: double.maxFinite,
                onTap: () {
                  /// Navigate To Robot & Tray Selection
                  ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.robotTraySelection());
                },
                backgroundColor: AppColors.blue009AF1,
                buttonText: LocalizationStrings.keyDispatch.localized,
                buttonTextStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.white),
              )
            ],
          ).paddingSymmetric(vertical: 16.h, horizontal: 16.w),
        );
      },
    );
  }
}
