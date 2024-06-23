import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_details_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_history/web/helper/common_status_button.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderStatusOrderItemListTile extends ConsumerWidget with BaseConsumerWidget {
  final OrderDetailsOrdersItem? item;
  final String? orderUuid;
  final int index;

  const OrderStatusOrderItemListTile({super.key, this.item, required this.orderUuid, required this.index});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        return CommonCard(
          borderColor: AppColors.greyE6E6E6,
          child: Column(
            children: [
              Row(
                children: [
                  /// item image
                  ClipOval(
                    child: CacheImage(
                      height: context.height * 0.15,
                      width: context.height * 0.15,
                      imageURL: item?.productImage ?? staticImageMasalaTea,
                    ),
                  ),

                  SizedBox(
                    width: 15.w,
                  ),

                  /// item name, close icon
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// item name
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    title: item?.productName ?? '',
                                    fontSize: 18.sp,
                                    maxLines: 3,
                                  ),
                                  SizedBox(height: context.height * 0.01),
                                  Row(
                                    children: [
                                      CommonText(
                                        title: '${LocalizationStrings.keyTray.localized}: N/A',
                                        maxLines: 1,
                                        textStyle: TextStyles.medium.copyWith(fontSize: 14.sp, color: AppColors.grey7E7E7E),
                                      ),
                                      SizedBox(width: context.height * 0.015),
                                      Container(height: context.height * 0.015, color: AppColors.grey7E7E7E, width: 1),
                                      SizedBox(width: context.height * 0.01),
                                      CommonText(
                                        title: '${LocalizationStrings.keyQty.localized}: ${item?.qty ?? '-'}',
                                        textStyle: TextStyles.medium.copyWith(fontSize: 14.sp, color: AppColors.grey7E7E7E),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: context.height * 0.015),
                                  CommonStatusButton(status: item?.status ?? '', isFilled: true, height: context.height * 0.04)
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.height * 0.015),
                      ],
                    ),
                  )
                ],
              ),
              (orderStatusEnumValues.map[item?.status ?? ''] == OrderStatusEnum.PENDING) || (orderStatusEnumValues.map[item?.status ?? ''] == OrderStatusEnum.ACCEPTED)
                  ? Column(
                      children: [
                        const Divider(color: AppColors.dividerColor, thickness: 1).paddingSymmetric(vertical: 10.h),
                        ref.watch(myOrderController).orderItemStatusUpdate.isLoading && index == ref.watch(myOrderController).updatingOrderItemIndex
                            ? Center(
                                child: LoadingAnimationWidget.waveDots(
                                  color: AppColors.red,
                                  size: 25.h,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  ref.read(myOrderController).orderItemStatusUpdateApi(context, item?.uuid ?? '', OrderStatusEnum.CANCELED).then((value) {
                                    ref.read(myOrderController).orderDetailsApi(context, orderUuid ?? '');
                                  });
                                },
                                child: CommonText(
                                  title: LocalizationStrings.keyCancel.localized,
                                  textStyle: TextStyles.medium.copyWith(fontSize: 15.sp, color: AppColors.red),
                                  maxLines: 1,
                                ),
                              ),
                      ],
                    )
                  : const Offstage(),
            ],
          ).paddingAll(20.r),
        );
      },
    );
  }
}
