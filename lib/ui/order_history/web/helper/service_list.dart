import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_history/web/helper/product_detail_popup.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ServiceList extends ConsumerWidget with BaseConsumerWidget {
  const ServiceList({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              child: _productTitle(),
            ),
          ],
        );
      },
    );
  }

  Widget _productTitle() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderHistoryWatch = ref.watch(orderHistoryController);
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              textDirection: TextDirection.ltr,
              columnWidths: {
                0: FlexColumnWidth(7.w),
                1: FlexColumnWidth(8.w),
                2: FlexColumnWidth(8.w),
                3: FlexColumnWidth(10.w),
                4: FlexColumnWidth(10.w),
                5: FlexColumnWidth(11.w),
                6: FlexColumnWidth(5.w),
                //7: FlexColumnWidth(3.w),
              },
              children: [
                TableRow(children: [
                  CommonText(
                    title: LocalizationStrings.keyServiceId.localized,
                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                  ),
                  CommonText(
                    title: LocalizationStrings.keyType.localized,
                    textAlign: TextAlign.left,
                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                  ),
                  CommonText(
                    title: LocalizationStrings.keyDate.localized,
                    textAlign: TextAlign.left,
                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                  ),
                  CommonText(
                    title: LocalizationStrings.keyDepartment.localized,
                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                  ),
                  CommonText(
                    title: LocalizationStrings.keyName.localized,
                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                  ),
                  CommonText(
                    title: LocalizationStrings.keyStatus.localized,
                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                  ),
                  const SizedBox()
                ]),
              ],
            ).paddingOnly(left: 25.w),
            SizedBox(
              height: 25.h,
            ),
            orderHistoryWatch.serviceSearchedItemList.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: orderHistoryWatch.serviceSearchedItemList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        //OrderModel model = orderListWatch.orderList[index];
                        return Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.r)), color: AppColors.lightPink),
                          child: InkWell(
                            onTap: () {
                              showAnimatedDialog(
                                context,
                                title: '',
                                heightPercentage: 64,
                                widthPercentage: 70,
                                onPopCall: (animationController) {
                                  orderHistoryWatch.updateAnimationController(animationController);
                                },
                                onCloseTap: () {
                                  orderHistoryWatch.animationController?.reverse(from: 0.3);
                                  Navigator.pop(context);
                                },
                                isCloseButtonVisible: false,
                                givePadding: false,
                                child: const ProductDetailPopUp().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
                              );
                            },
                            child: Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FlexColumnWidth(8.w),
                                1: FlexColumnWidth(8.w),
                                2: FlexColumnWidth(7.w),
                                3: FlexColumnWidth(10.w),
                                4: FlexColumnWidth(10.w),
                                5: FlexColumnWidth(11.w),
                                6: FlexColumnWidth(5.w),
                                // 7: FlexColumnWidth(3.w),
                              },
                              children: [
                                TableRow(children: [
                                  CommonText(
                                    title: orderHistoryWatch.serviceSearchedItemList[index].serviceId,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                  ),
                                  CommonText(
                                    title: orderHistoryWatch.serviceSearchedItemList[index].type,
                                    textAlign: TextAlign.left,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                  ),
                                  CommonText(
                                    title: orderHistoryWatch.serviceSearchedItemList[index].date,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                  ),
                                  CommonText(
                                    title: orderHistoryWatch.serviceSearchedItemList[index].department,
                                    textAlign: TextAlign.left,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                  ),
                                  CommonText(
                                    title: orderHistoryWatch.serviceSearchedItemList[index].name,
                                    maxLines: 2,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                  ),
                                  statusButton(orderHistoryWatch.serviceSearchedItemList[index].status).paddingOnly(right: 60.w),
                                  const CommonSVG(strIcon: AppAssets.svgExpandHistory)
                                ]),
                              ],
                            ).paddingOnly(left: 25.w, right: 20.w, top: 13.h, bottom: 13.h),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 22.h,
                        );
                      },
                    ),
                  )
                : orderHistoryWatch.ctrSearch.text.isNotEmpty
                    ? Expanded(
                        child: Center(
                          child: CommonText(
                            title: 'No data Available',
                            textStyle: TextStyles.semiBold.copyWith(color: AppColors.black),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: orderHistoryWatch.serviceHistoryList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.r)), color: AppColors.lightPink),
                              child: InkWell(
                                onTap: () {
                                  showAnimatedDialog(
                                    context,
                                    title: '',
                                    heightPercentage: 64,
                                    widthPercentage: 70,
                                    onPopCall: (animationController) {
                                      orderHistoryWatch.updateAnimationController(animationController);
                                    },
                                    onCloseTap: () {
                                      orderHistoryWatch.animationController?.reverse(from: 0.3);
                                    },
                                    child: Container(
                                      height: context.height * 0.64,
                                      width: context.width * 0.7,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: const ProductDetailPopUp().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
                                    ),
                                    isCloseButtonVisible: false,
                                    givePadding: false,
                                  );
                                },
                                child: Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FlexColumnWidth(7.w),
                                    1: FlexColumnWidth(8.w),
                                    2: FlexColumnWidth(9.w),
                                    3: FlexColumnWidth(10.w),
                                    4: FlexColumnWidth(10.w),
                                    5: FlexColumnWidth(11.w),
                                    6: FlexColumnWidth(5.w),
                                  },
                                  children: [
                                    TableRow(children: [
                                      CommonText(
                                        title: orderHistoryWatch.serviceHistoryList[index].serviceId,
                                        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                      ),
                                      CommonText(
                                        title: orderHistoryWatch.serviceHistoryList[index].type,
                                        textAlign: TextAlign.left,
                                        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                      ),
                                      CommonText(
                                        title: orderHistoryWatch.serviceHistoryList[index].date,
                                        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                      ),
                                      CommonText(
                                        title: orderHistoryWatch.serviceHistoryList[index].department,
                                        textAlign: TextAlign.left,
                                        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                      ),
                                      CommonText(
                                        title: orderHistoryWatch.serviceHistoryList[index].name,
                                        maxLines: 2,
                                        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                      ),
                                      statusButton(orderHistoryWatch.serviceHistoryList[index].status).paddingOnly(right: 60.w),
                                      const CommonSVG(strIcon: AppAssets.svgExpandHistory)
                                    ]),
                                  ],
                                ).paddingOnly(left: 25.w, right: 20.w, top: 13.h, bottom: 13.h),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 22.h,
                            );
                          },
                        ),
                      ),
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CommonText(
            //         title: LocalizationStrings.keyServiceId,
            //         textStyle: TextStyles.regular
            //             .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //       ).paddingOnly(left: 25.w,bottom: 24.h),
            //       orderHistoryWatch.searchedItemList.isNotEmpty ?  SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.searchedItemList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                     color: AppColors.lightPink,
            //                     borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),bottomLeft: Radius.circular(20.r))
            //                 ),
            //                 child: CommonText(
            //                   title: orderHistoryWatch.searchedItemList[index].serviceId,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 20.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //        : orderHistoryWatch.ctrSearch.text.isNotEmpty ? Container() :  SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.productHistoryList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                     color: AppColors.lightPink,
            //                     borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),bottomLeft: Radius.circular(20.r))
            //                 ),
            //                 child: CommonText(
            //                   title: orderHistoryWatch.serviceHistoryList[index].serviceId,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 20.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CommonText(
            //         title: LocalizationStrings.keyType,
            //         textAlign: TextAlign.left,
            //         textStyle: TextStyles.regular
            //             .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //       ).paddingOnly(left: 25.w,bottom: 24.h),
            //       orderHistoryWatch.searchedItemList.isNotEmpty ?  SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.searchedItemList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 color: AppColors.lightPink,
            //                 child: CommonText(
            //                   title: orderHistoryWatch.searchedItemList[index].type,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 20.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //           : orderHistoryWatch.ctrSearch.text.isNotEmpty ? Container() : SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.productHistoryList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 color: AppColors.lightPink,
            //                 child: CommonText(
            //                   title: orderHistoryWatch.serviceHistoryList[index].type,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 20.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CommonText(
            //         title: LocalizationStrings.keyDate,
            //         textStyle: TextStyles.regular
            //             .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //       ).paddingOnly(left: 25.w,bottom: 24.h),
            //       orderHistoryWatch.searchedItemList.isNotEmpty ?  SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.searchedItemList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 color: AppColors.lightPink,
            //                 child: CommonText(
            //                   title: orderHistoryWatch.searchedItemList[index].date,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 20.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //           : orderHistoryWatch.ctrSearch.text.isNotEmpty ? Container() : SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.productHistoryList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 color: AppColors.lightPink,
            //                 child: CommonText(
            //                   title: orderHistoryWatch.serviceHistoryList[index].date,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 20.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CommonText(
            //         title: LocalizationStrings.keyDepartment,
            //         textAlign: TextAlign.left,
            //         textStyle: TextStyles.regular
            //             .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //       ).paddingOnly(right: 30.w,left: 25.w,bottom: 24.h),
            //       orderHistoryWatch.searchedItemList.isNotEmpty ?  SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.searchedItemList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 color: AppColors.lightPink,
            //                 child: CommonText(
            //                   title: orderHistoryWatch.searchedItemList[index].department,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 30.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //           : orderHistoryWatch.ctrSearch.text.isNotEmpty ? Container() : SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.productHistoryList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 color: AppColors.lightPink,
            //                 child: CommonText(
            //                   title: orderHistoryWatch.serviceHistoryList[index].department,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 30.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CommonText(
            //         title: LocalizationStrings.keyName,
            //         textStyle: TextStyles.regular
            //             .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //       ).paddingOnly(left: 25.w,bottom: 24.h),
            //       orderHistoryWatch.searchedItemList.isNotEmpty ?  SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.searchedItemList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 color: AppColors.lightPink,
            //                 child: CommonText(
            //                   title: orderHistoryWatch.searchedItemList[index].name,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 20.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //           : orderHistoryWatch.ctrSearch.text.isNotEmpty ? Container() : SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.productHistoryList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 color: AppColors.lightPink,
            //                 child: CommonText(
            //                   title: orderHistoryWatch.serviceHistoryList[index].name,
            //                   textStyle: TextStyles.regular
            //                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //                 ).paddingOnly(left: 25.w, right: 20.w, top: 23.h, bottom: 23.h),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Expanded(
            //   flex: 2,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CommonText(
            //         title: LocalizationStrings.keyStatus,
            //         textStyle: TextStyles.regular
            //             .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
            //       ).paddingOnly(left: 30.w,bottom: 24.h),
            //       orderHistoryWatch.searchedItemList.isNotEmpty ?  SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.searchedItemList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 height: 63.h,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.only(topRight: Radius.circular(20.r),bottomRight: Radius.circular(20.r)),
            //                   color: AppColors.lightPink,
            //
            //                 ),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     statusButton(orderHistoryWatch.searchedItemList[index].status),
            //                     const CommonSVG(strIcon: AppAssets.svgExpandHistory)
            //                   ],
            //                 ).paddingOnly(left: 25.w, right: 25.w),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //           : orderHistoryWatch.ctrSearch.text.isNotEmpty ? Container() : SizedBox(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           itemCount: orderHistoryWatch.productHistoryList.length,
            //           scrollDirection: Axis.vertical,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             //OrderModel model = orderListWatch.orderList[index];
            //             return InkWell(
            //               onTap: () {
            //                 showAnimatedDialog(
            //                   context,
            //                   child: DialogTransition(
            //                     onPopCall: (animationController) {
            //                       orderHistoryWatch.updateAnimationController(animationController);
            //                     },
            //                     child: Container(
            //                       height: context.height * 0.64,
            //                       width: context.width * 0.7,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.white,
            //                         borderRadius: BorderRadius.circular(20.r),
            //                       ),
            //                       child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 height: 63.h,
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.only(topRight: Radius.circular(20.r),bottomRight: Radius.circular(20.r)),
            //                   color: AppColors.lightPink,
            //
            //                 ),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     statusButton(orderHistoryWatch.serviceHistoryList[index].status),
            //                     const CommonSVG(strIcon: AppAssets.svgExpandHistory)
            //                   ],
            //                 ).paddingOnly(left: 25.w, right: 25.w),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return SizedBox(
            //               height: 60.h,
            //             );
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // const Spacer(flex: 1,),
            SizedBox(
              width: 50.w,
            )
          ],
        );
      },
    );
  }

  ///status button
  Widget statusButton(String status) {
    return Container(
      height: 42.h,
      width: 0.11.sh,
      decoration: BoxDecoration(
        border: Border.all(
            color: (status == LocalizationStrings.keyRejected.localized)
                ? AppColors.redEE0000
                : (status == LocalizationStrings.keyCanceled.localized)
                    ? AppColors.yellowEF8F00
                    : AppColors.greyB9B9B9),
        borderRadius: BorderRadius.all(Radius.circular(22.r)),
      ),
      child: Center(
        child: CommonText(
          title: status,
          textStyle: TextStyles.regular.copyWith(
              fontSize: 12.sp,
              color: (status == LocalizationStrings.keyRejected.localized)
                  ? AppColors.redEE0000
                  : (status == LocalizationStrings.keyCanceled.localized)
                      ? AppColors.yellowEF8F00
                      : AppColors.greyB9B9B9),
        ),
      ),
    );
  }

//
// Widget _productDetail(int index) {
//   return Consumer(
//     builder: (BuildContext context, WidgetRef ref, Widget? child) {
//       final orderHistoryWatch = ref.watch(orderHistoryController);
//       return InkWell(
//         onTap: () {
//           showAnimatedDialog(
//             context,
//             child: DialogTransition(
//               onPopCall: (animationController) {
//                 orderHistoryWatch.updateAnimationController(animationController);
//               },
//               child: Container(
//                 height: context.height * 0.64,
//                 width: context.width * 0.7,
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child:  const SeriveDetailPopup().paddingSymmetric(horizontal: 30.w, vertical: 30.h),
//               ),
//             ),
//           );
//         },
//         child: Container(
//           decoration: BoxDecoration(
//               color: AppColors.lightPink,
//               borderRadius: BorderRadius.all(Radius.circular(20.r))),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: CommonText(
//                   title: orderHistoryWatch.serviceHistoryList[index].serviceId,
//                   textStyle: TextStyles.regular
//                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: CommonText(
//                   title: orderHistoryWatch.serviceHistoryList[index].type,
//                   textAlign: TextAlign.left,
//                   textStyle: TextStyles.regular
//                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: CommonText(
//                   title: orderHistoryWatch.serviceHistoryList[index].date,
//                   textStyle: TextStyles.regular
//                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: CommonText(
//                   title: orderHistoryWatch.serviceHistoryList[index].department,
//                   textAlign: TextAlign.left,
//                   textStyle: TextStyles.regular
//                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
//                 ).paddingOnly(right: 30.w),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: CommonText(
//                   title: orderHistoryWatch.serviceHistoryList[index].name,
//                   textAlign: TextAlign.left,
//                   textStyle: TextStyles.regular
//                       .copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
//                 ).paddingOnly(right: 30.w),
//               ),
//               // const Spacer(flex: 1,),
//               CommonButton(
//                 isButtonEnabled: true,
//                 height: 40.h,
//                 width: 110.w,
//                 backgroundColor: AppColors.transparent,
//                 borderColor: AppColors.red,
//                 borderWidth: 2,
//                 buttonText: orderHistoryWatch.productHistoryList[index].status,
//                 buttonTextStyle: TextStyles.regular
//                     .copyWith(fontSize: 14.sp, color: AppColors.black),
//                 onTap: () {},
//               ).paddingSymmetric(horizontal: 30.w),
//               const CommonSVG(strIcon: AppAssets.svgExpandHistory)
//             ],
//           ).paddingOnly(left: 25.w, right: 20.w, top: 23.h, bottom: 23.h),
//         ),
//       );
//     },
//   );
// }
}
