

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/repository/order/model/order_filter_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderTypeFilterTypeWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  const OrderTypeFilterTypeWidgetWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.expand(
        width: context.width * 0.09,
        height: context.height * 0.11,
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      tooltip: LocalizationStrings.keyOrderType.localized,
      color: AppColors.white,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        PopupMenuItem<SampleItem>(
          padding: EdgeInsets.zero,
          value: SampleItem.itemOne,
          child: Container(
              color: AppColors.white,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final orderListWatch = ref.watch(myOrderController);
                  return ListView.separated(
                    itemCount: orderListWatch.orderTypeFilterList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ///Common List tile for Services
                      return Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          final myOrderWatch = ref.watch(myOrderController);
                          OrderTypeFilterModel currentFilter = orderListWatch.orderTypeFilterList[index];
                          return InkWell(
                            onTap: () {
                              myOrderWatch.updateSelectedOrderTypeFilter(ref: ref,selectedOrderTypeFilter: currentFilter);
                              Navigator.pop(context);
                            },
                            child: Text(
                              orderListWatch.orderTypeFilterList[index].name,
                              style: TextStyles.regular.copyWith(
                                color: orderListWatch.orderTypeFilterList[index] == orderListWatch.selectedOrderTypeFilter ? AppColors.blue0083FC : AppColors.grey8F8F8F,
                              ),
                            ).paddingSymmetric(horizontal: 20.w),
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      /// Divider
                      return SizedBox(
                        height: 15.h,
                      );
                    },
                  ).paddingOnly(top: 10.h);
                },
              )),
        ),
      ],
      offset: Offset(-5.w, 10.h),
      position: PopupMenuPosition.under,
      child: Container(
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(31.r)),
        child: Row(
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return CommonText(
                  title: /*LocalizationStrings.keyOrderType.localized*/ ref.watch(myOrderController).selectedOrderTypeFilter?.name ?? '',
                  textStyle: TextStyles.regular.copyWith(color: AppColors.black),
                );
              },
            ),
            const CommonSVG(strIcon: AppAssets.svgArrowDown)
          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 15.h),
      ),
    );
  }
}
