// import 'package:kte/framework/controller/drawer/drawer_menu_controller.dart';
// import 'package:kte/framework/controller/my_order/my_order_controller.dart';
// import 'package:kte/framework/utility/extension/extension.dart';
// import 'package:kte/ui/my_order/mobile/helper/common_title_value_widget.dart';
// import 'package:kte/ui/my_order/web/helper/order_model_widget_web.dart';
// import 'package:kte/ui/routing/navigation_stack_item.dart';
// import 'package:kte/ui/routing/stack.dart';
// import 'package:kte/ui/utils/const/app_enums.dart';
// import 'package:kte/ui/utils/theme/theme.dart';
// import 'package:kte/ui/utils/widgets/common_button.dart';
// import 'package:kte/ui/utils/widgets/common_dialogs.dart';
// import 'package:kte/ui/utils/widgets/common_svg.dart';
// import 'package:kte/ui/utils/widgets/common_text.dart';
//
// class PastOrderWeb extends ConsumerWidget with BaseConsumerWidget {
//   const PastOrderWeb({super.key});
//
//   @override
//   Widget buildPage(BuildContext context, WidgetRef ref) {
//     final orderListWatch = ref.watch(myOrderController);
//     if (orderListWatch.filteredList.isNotEmpty) {
//       return ListView(
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ///Date picker to filter orders in certain date range
//           //const SelectCustomDateWidgetWeb(),
//
//           /// Last 7 Days Order Text
//           // CommonText(
//           //   title: LocalizationStrings.keyLast7DaysOrder.localized,
//           //   textStyle: TextStyles.medium.copyWith(fontSize: 20.sp),
//           // ).paddingOnly(top: 50.h, bottom: 30.h, left: 20.w),
//           //const Divider(height: 1).paddingSymmetric(vertical: 30.h),
//
//           ///List of Past Orders
//           ListView.separated(
//             shrinkWrap: true,
//             itemCount: orderListWatch.filteredList.length,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               OrderModel model = orderListWatch.filteredList[index];
//               return Container(
//                 decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
//                 child: Column(
//                   children: [
//                     ///Common Widget to display Orders
//                     OrderModelWidgetWeb(
//                       order: model,
//                       onFavIconTap: () {
//                         orderListWatch.updateFavUnFavByIndex(index);
//                         orderListWatch.updateOrderItemFavUnFav(model);
//                       },
//                       orderStatusWidget: _orderStatus(model.status).paddingOnly(left: 8.w),
//                     ),
//
//                     ///Bottom Widget for Orders
//                     _orderCardBottom(model.status),
//                   ],
//                 ).paddingAll(30.h),
//               ).paddingOnly(bottom: 20.h,);
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return SizedBox(
//                 height: 20.h,
//               );
//             },
//           ),
//         ],
//       );
//     } else {
//       return _noOrders();
//     }
//   }
//
//   ///Order Bottom Widget
//   Widget _orderCardBottom(OrderStatusEnum statusEnum) {
//     return Consumer(builder: (context, ref, child) {
//       final myOrderWatch = ref.watch(myOrderController);
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           ///Order Details text Navigates to Order Details page
//           InkWell(
//             onTap: () {
//               showAnimatedDialog(
//                 context,
//                 child: _widgetOrderDetails(),
//                 heightPercentage: 40,
//                 widthPercentage: 40,
//                 onPopCall: (animationController) {
//                   myOrderWatch.updateAnimationController(animationController);
//                 },
//                 onCloseTap: () {
//                   myOrderWatch.animationController?.reverse(from: 0.3).then((value) {
//                     Navigator.pop(context);
//                   });
//                 },
//                 title: LocalizationStrings.keyOrderDetails.localized,
//               );
//               // showCommonWebDialog(
//               //   context: context,
//               //   widget: _widgetOrderDetails().paddingOnly(bottom: 30.h),
//               //   topText: LocalizationStrings.keyOrderDetails,
//               // );
//             },
//             child: Row(
//               children: [
//                 CommonText(
//                   title: LocalizationStrings.keyOrderDetails.localized,
//                   fontSize: 16.sp,
//                   clrfont: AppColors.primary2,
//                   textDecoration: TextDecoration.underline,
//                 ),
//                 SizedBox(
//                   width: 20.w,
//                 ),
//               ],
//             ),
//           ),
//
//           ///Reorder Button
//           CommonButton(
//             buttonText: LocalizationStrings.keyReorder.localized,
//             buttonEnabledColor: AppColors.primary,
//             buttonTextColor: AppColors.white,
//             height: 40.h,
//             width: 116.w,
//             buttonTextStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.white),
//             onTap: () {
//               /// Navigate to tray
//               final drawerWatch = ref.watch(drawerController);
//               drawerWatch.updateSelectedScreen(ScreenName.tray);
//               drawerWatch.expandingList(2);
//               ref.read(navigationStackProvider).push(const NavigationStackItem.myTray());
//             },
//           ),
//         ],
//       );
//     });
//   }
//
//   /// Order Status Widget
//   Widget _orderStatus(OrderStatusEnum statusEnum) {
//     return Consumer(builder: (context, ref, child) {
//       final orderListWatch = ref.watch(myOrderController);
//       return Container(
//         decoration: BoxDecoration(
//           color: orderListWatch.getOrderStatusTextColor(statusEnum).buttonBgColor,
//           borderRadius: BorderRadius.circular(40.r),
//           border: Border.all(color: AppColors.transparent, width: 1),
//         ),
//         child: CommonText(
//           title: orderListWatch.getOrderStatusTextColor(statusEnum).orderStatus,
//           clrfont: orderListWatch.getOrderStatusTextColor(statusEnum).buttonTextColor,
//         ).paddingSymmetric(horizontal: 25.w, vertical: 10.h),
//       );
//     });
//   }
//
//   /// No Orders Widget
//   Widget _noOrders() {
//     return Column(
//       children: [
//         CommonSVG(
//           strIcon: AppAssets.svgNoServices,
//           width: 228.h,
//           height: 228.h,
//         ).paddingOnly(
//           bottom: 25.h,
//           top: 100.h,
//         ),
//         Text(
//           LocalizationStrings.keyNoOrders.localized,
//           textAlign: TextAlign.center,
//           style: TextStyles.regular.copyWith(
//             fontSize: 18.sp,
//             color: AppColors.primary,
//           ),
//         ).paddingOnly(bottom: 16.h),
//         Text(
//           LocalizationStrings.keyYouHaveNotOrderedAnything.localized,
//           maxLines: 2,
//           softWrap: true,
//           textAlign: TextAlign.center,
//           style: TextStyles.regular.copyWith(
//             color: AppColors.grey7E7E7E,
//           ),
//         ),
//       ],
//     );
//   }
//
//   ///Order Details Widget
//   Widget _widgetOrderDetails() {
//     return Consumer(
//       builder: (BuildContext context, WidgetRef ref, Widget? child) {
//         final myOrderWatch = ref.watch(myOrderController);
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CommonTitleValueWidget(
//               title: LocalizationStrings.keyOrderNo.localized,
//               value: '#123456',
//               titleFontSize: 16.sp,
//               valueFontSize: 16.sp,
//             ),
//             CommonTitleValueWidget(
//               title: LocalizationStrings.keyOrderStatus.localized,
//               value: myOrderWatch.orderTypeSelectedIndex == 1 ? 'Accepted' : 'Delivered',
//               valueColor: myOrderWatch.orderTypeSelectedIndex == 2 ? AppColors.green35A600 : AppColors.red,
//               titleFontSize: 16.sp,
//               valueFontSize: 16.sp,
//             ),
//             CommonTitleValueWidget(
//               title: LocalizationStrings.keyDepartment.localized,
//               value: 'UI/UX Designer',
//               titleFontSize: 16.sp,
//               valueFontSize: 16.sp,
//             ),
//             CommonTitleValueWidget(
//               title: LocalizationStrings.keyDateTime.localized,
//               value: '06 Aug 2023 at 1:45PM',
//               titleFontSize: 16.sp,
//               valueFontSize: 16.sp,
//             ),
//             CommonTitleValueWidget(
//               title: LocalizationStrings.keyQty.localized,
//               value: '01',
//               bottomPadding: 0.h,
//               titleFontSize: 16.sp,
//               valueFontSize: 16.sp,
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
