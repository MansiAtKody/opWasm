// import 'package:kte/framework/controller/home/home_controller.dart';
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
// class FavouriteOrdersWeb extends ConsumerWidget with BaseConsumerWidget {
//   const FavouriteOrdersWeb({super.key});
//
//   @override
//   Widget buildPage(BuildContext context, WidgetRef ref) {
//     final orderListWatch = ref.watch(myOrderController);
//
//     ///Display Favourite Orders
//     return orderListWatch.currentOrderList.isNotEmpty
//         ? ListView(
//           children: [
//             //const Divider(height: 1).paddingSymmetric(vertical: 30.h),
//             ListView.separated(
//                 shrinkWrap: true,
//                 itemCount: orderListWatch.currentOrderList.length,
//                 // physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   OrderModel model = orderListWatch.currentOrderList[index];
//                   return Container(
//                     decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
//                     child: Column(
//                       children: [
//                         ///Common Order Widget
//                         OrderModelWidgetWeb(
//                           order: model,
//                           onFavIconTap: () {
//                             orderListWatch.updateOrderItemFavUnFavByIndex(index);
//                           },
//                         ),
//                         _bottomOrderDetailsStatusWidget(),
//                       ],
//                     ).paddingAll(30.h),
//                   ).paddingOnly(bottom: 20.h,);
//                 },
//                 separatorBuilder: (BuildContext context, int index) {
//                   return SizedBox(
//                     height: 20.h,
//                   );
//                 },
//               ),
//           ],
//         )
//         : _noFavouriteOrders();
//   }
//
//   ///Bottom Widget for a single order
//   _bottomOrderDetailsStatusWidget() {
//     return Consumer(builder: (context, ref, child) {
//       final myOrderWatch = ref.watch(myOrderController);
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           ///Order Details Widget
//           ///Navigate to Order Details Screen On tap
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
//                   width: 15.w,
//                 ),
//               ],
//             ),
//           ),
//
//           ///Quick Order Button
//           CommonButton(
//             buttonText: LocalizationStrings.keyQuickOrder.localized,
//             buttonEnabledColor: AppColors.primary,
//             buttonTextColor: AppColors.white,
//             height: 40.h,
//             width: 116.w,
//             buttonTextStyle: TextStyles.regular.copyWith(fontSize: 16.sp, color: AppColors.white),
//             onTap: () {
//               /// Navigate to home screen and will show order processing
//               showSuccessDialogue(
//                 context: context,
//                 animation: AppAssets.animOrderSuccessful,
//                 successMessage: LocalizationStrings.keyYourOrderIsPlaced.localized,
//                 successDescription: LocalizationStrings.keyYourOrderIsPreparingMsg.localized,
//                 buttonText: LocalizationStrings.keyClose.localized,
//                 onPopCall: (animationController) {
//                   final homeWatch = ref.watch(homeController);
//                   homeWatch.updateAnimationController(animationController);
//                 },
//                 onTap: () {
//                   final homeWatch = ref.watch(homeController);
//                   homeWatch.animationController?.reverse(from: 0.3).then((value) {
//                     homeWatch.updateOrderStatus(OrderStatusHomeEnum.orderProcessing);
//                     homeWatch.updateIsShowOrderStatusWidget(true);
//                     Navigator.pop(context);
//                     ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
//                   });
//                 },
//               );
//             },
//           ),
//         ],
//       );
//     });
//   }
//
//   Widget _noFavouriteOrders() {
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
//           LocalizationStrings.keyNoFavouriteItems.localized,
//           textAlign: TextAlign.center,
//           style: TextStyles.regular.copyWith(
//             fontSize: 18.sp,
//             color: AppColors.primary,
//           ),
//         ).paddingOnly(bottom: 16.h),
//         Text(
//           LocalizationStrings.keyYouHaveNotAddedFavourite.localized,
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
