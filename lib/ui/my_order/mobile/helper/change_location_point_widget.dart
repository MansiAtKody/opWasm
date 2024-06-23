import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/location/select_location_dialog_controller.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ChangeLocationPointWidgetMobile extends ConsumerWidget with BaseConsumerWidget {
  final String orderId;
  const ChangeLocationPointWidgetMobile({Key? key,required this.orderId}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    final myOrderWatch = ref.watch(myOrderController);
    return  (myOrderWatch.orderDetailsState.success?.data?.status == OrderStatusEnum.DELIVERED.name) || (myOrderWatch.orderDetailsState.success?.data?.status == OrderStatusEnum.PARTIALLY_DELIVERED.name)
        ?const Offstage ()
        :(myOrderWatch.orderDetailsState.success?.data?.status == OrderStatusEnum.PENDING.name) || (myOrderWatch.getIsItemDispatched()  && myOrderWatch.orderDetailsState.success?.data?.status == OrderStatusEnum.ACCEPTED.name ) ||
        (myOrderWatch.getIsItemDispatched()  && (myOrderWatch.orderDetailsState.success?.data?.status != OrderStatusEnum.CANCELED.name && myOrderWatch.orderDetailsState.success?.data?.status != OrderStatusEnum.REJECTED.name) )
        ?InkWell(
      onTap: () {
        ref.read(navigationStackProvider).push( NavigationStackItem.selectLocationDialog(onButtonPressed: () async{
          /// change location api call
          await myOrderWatch.changeOrderLocationPointApi(context,orderUuid: myOrderWatch.orderDetailsState.success?.data?.uuid, locationPointsUuid:   ref.read(selectLocationDialogController).tempSelectedLocationPoint?.uuid).then((value) async{

            ref.read(navigationStackProvider).pop();
            /// Details api call
            await myOrderWatch.orderDetailsApi(context, orderId);
          });

        }));
      },
      child: CommonCard(
        color: AppColors.whiteF7F7FC,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  title: LocalizationStrings.keyChangeLocation.localized,
                  textStyle: TextStyles.medium.copyWith(color: AppColors.black171717),
                ),
                CommonText(
                  title: LocalizationStrings.keyCantChangeLocation.localized,
                  textStyle: TextStyles.regular.copyWith(color: AppColors.grey7E7E7E, fontSize: 12.sp),
                ),
              ],
            ).paddingSymmetric(vertical: 20.h, horizontal: 20.w),
            const CommonSVG(strIcon: AppAssets.svgRightArrow).paddingSymmetric(vertical: 20.h, horizontal: 20.w),
          ],
        ),
      ),
    ): const Offstage();
  }
}
