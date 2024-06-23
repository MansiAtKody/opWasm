import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class StatisticsWidget extends StatelessWidget with BaseStatelessWidget {
  const StatisticsWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(18.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                title: LocalizationStrings.keyStatistics.localized,
                textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black),
              ).paddingSymmetric(vertical: context.height * 0.01),
              Row(
                children: [
                  _orderDetail(
                    orderTitle: LocalizationStrings.keyNewOrders.localized,
                    orderNumber: '100',
                    imageName: AppAssets.svgNewOrderMobile,
                    context: context,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  _orderDetail(
                    orderTitle: LocalizationStrings.keyTotalOrders.localized,
                    orderNumber: '10',
                    imageName: AppAssets.svgTotalOrderMobile,
                    context: context,
                  ),
                  ///Do not remove this code
                  /*SizedBox(
                    width: 10.w,
                  ),
                  _orderDetail(
                    orderTitle: LocalizationStrings.keyTotalServices.localized,
                    orderNumber: '10',
                    imageName: AppAssets.svgPastOrderMobile,
                    context: context,
                  )*/
                ],
              ).paddingOnly(bottom: 10.h),
            ],
          ).paddingSymmetric(horizontal: 10.w),
        ).paddingSymmetric(horizontal: 12.w);
      },
    );
  }

  ///Order detail widget
  _orderDetail({String? orderTitle, String? orderNumber, String? imageName, required BuildContext context}) {
    return Expanded(
      child: FadeBoxTransition(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.19,
          decoration: BoxDecoration(color: AppColors.whiteF7F7FC, borderRadius: BorderRadius.all(Radius.circular(20.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonSVG(
                strIcon: imageName!,
                boxFit: BoxFit.scaleDown,
                height: 65.h,
                width: 65.h,
              ),
              CommonText(
                title: orderTitle!,
                textStyle: TextStyles.regular.copyWith(color: AppColors.black),
              ),
              CommonText(
                title: orderNumber!,
                textStyle: TextStyles.semiBold.copyWith(fontSize: 24.sp, color: AppColors.blue009AF1),
              )
            ],
          ).paddingSymmetric(vertical: 16.h),
        ),
      ),
    );
  }
}
