import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SeriveDetailPopup extends ConsumerStatefulWidget {
  const SeriveDetailPopup({Key? key}) : super(key: key);

  @override
  ConsumerState<SeriveDetailPopup> createState() => _SeriveDetailPopupState();
}

class _SeriveDetailPopupState extends ConsumerState<SeriveDetailPopup> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CommonText(
                  title: 'Hiren Patel',
                  textStyle: TextStyles.regular.copyWith(fontSize: 22.sp),
                ).paddingOnly(right: 15.w),
                Container(
                  decoration: BoxDecoration(color: AppColors.yellowFFEDBF, borderRadius: BorderRadius.all(Radius.circular(24.r))),
                  child: CommonText(
                    title: '#12345',
                    textStyle: TextStyles.regular.copyWith(
                      fontSize: 22.sp,
                      color: AppColors.black,
                    ),
                  ).paddingSymmetric(horizontal: 18.w, vertical: 8.h),
                ).paddingOnly(right: 15.w),
                CommonButton(
                  width: 112.w,
                  height: 42.h,
                  buttonText: 'Delivered',
                  buttonTextStyle: TextStyles.regular.copyWith(color: AppColors.grey989898),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                final orderHistoryWatch = ref.watch(orderHistoryController);
                orderHistoryWatch.animationController?.reverse(from: 0.3);
                Navigator.pop(context);
              },
              child: const CommonSVG(strIcon: AppAssets.svgCrossIcon),
            ),
          ],
        ),
        SizedBox(
          height: 50.h,
        ),
        Row(
          children: [
            const CommonSVG(strIcon: AppAssets.svgEmail).paddingOnly(right: 15.w),
            CommonText(
              title: 'Hiren Patel',
              textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black515151),
            ).paddingOnly(right: 15.w),
            const CommonSVG(strIcon: AppAssets.svgDivider).paddingSymmetric(horizontal: 15.w),
            const CommonSVG(strIcon: AppAssets.svgPlace).paddingSymmetric(horizontal: 15.w),
            CommonText(
              title: 'UI/UX Designer',
              textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black515151),
            ).paddingOnly(right: 15.w),
            const CommonSVG(strIcon: AppAssets.svgDivider).paddingSymmetric(horizontal: 15.w),
            const CommonSVG(strIcon: AppAssets.svgPlace).paddingSymmetric(horizontal: 15.w),
            CommonText(
              title: '23/04/23  1:00PM',
              textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black515151),
            ).paddingOnly(right: 15.w),
          ],
        ),
        SizedBox(
          height: 21.h,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: AppColors.buttonDisabledColor, borderRadius: BorderRadius.all(Radius.circular(15.r)), border: Border.all(color: AppColors.buttonDisabledColor)),
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final orderStatusWatch = ref.watch(orderStatusController);
                return ListView.separated(
                  //shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: orderStatusWatch.upcomingSocketOrders.first.ordersItems?.length ?? 0,
                  itemBuilder: (context, index) {
                    //OrderModel model = orderListWatch.orderList[index];
                    return Container(
                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(15.r)), border: Border.all(color: AppColors.greyE6E6E6)),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 53.h,
                            width: 53.w,
                            child: const CommonSVG(
                              strIcon: AppAssets.svgChai,
                              boxFit: BoxFit.scaleDown,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  title: orderStatusWatch.upcomingSocketOrders.first.ordersItems?[index].productName ?? '',
                                  textStyle: TextStyles.regular.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                CommonText(
                                  title: orderStatusWatch.upcomingSocketOrders.first.ordersItems?[index].ordersItemAttributes?.map((e) => e.attributeNameValue).toList().join(',') ?? '',
                                  maxLines: 2,
                                  textStyle: TextStyles.regular.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.grey8D8C8C,
                                  ),
                                )
                              ],
                            ).paddingOnly(left: 10.w),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(22.r)), border: Border.all(color: AppColors.green14B500)),
                            child: CommonText(
                              title: LocalizationStrings.keyAccept.localized,
                              textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.green14B500),
                            ).paddingSymmetric(horizontal: 15.w, vertical: 10.h),
                          )
                        ],
                      ).paddingSymmetric(horizontal: 10.w, vertical: 12.h),
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
        ),
      ],
    );
  }
}
