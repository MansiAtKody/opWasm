

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/datetime_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_details_list_tile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderHistoryDetailsPopup extends StatefulWidget {
  const OrderHistoryDetailsPopup({super.key});

  @override
  State<OrderHistoryDetailsPopup> createState() => _OrderHistoryDetailsPopupState();
}

class _OrderHistoryDetailsPopupState extends State<OrderHistoryDetailsPopup> with BaseStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Consumer(
          builder: (context, ref, child) {
            final myOrderWatch = ref.watch(myOrderController);
            return Row(
              children: [
                const CommonSVG(strIcon: AppAssets.svgPlace).paddingSymmetric(horizontal: 15.w),
                CommonText(
                  title: myOrderWatch.orderDetailsState.success?.data?.locationPointsName ?? '',
                  textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black515151),
                ).paddingOnly(right: 15.w),
                const CommonSVG(strIcon: AppAssets.svgDivider).paddingSymmetric(horizontal: 15.w),
                const CommonSVG(strIcon: AppAssets.svgRecentTime).paddingSymmetric(horizontal: 15.w),
                CommonText(
                  title: '${DateTime.fromMillisecondsSinceEpoch(myOrderWatch.orderDetailsState.success?.data?.createdAt ?? 0).dateOnly} | ${DateTime.fromMillisecondsSinceEpoch(myOrderWatch.orderDetailsState.success?.data?.createdAt ?? 0).timeOnly}',
                  textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black515151),
                ).paddingOnly(right: 15.w),
              ],
            );
          }
        ),

        SizedBox(
          height: 21.h,
        ),
        Container(
          height: context.height * 0.36,
          decoration: BoxDecoration(
            color: AppColors.lightPink,
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
          ),
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final myOrderWatch = ref.watch(myOrderController);
              return ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: myOrderWatch.orderDetailsState.success?.data?.ordersItems?.length ?? 0,
                itemBuilder: (context, index) {
                  return OrderDetailsListTile(
                    orderDetailsModel: myOrderWatch.orderDetailsState.success?.data?.ordersItems?[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
              ).paddingAll(20.h);
            },
          ),
        ),

      ],
    );
  }
}
