// import 'package:kte/framework/controller/my_order/my_order_controller.dart';
// import 'package:kte/framework/utility/extension/extension.dart';
// import 'package:kte/ui/my_order/web/helper/show_date_picker_widget_web.dart';
// import 'package:kte/ui/utils/const/app_constants.dart';
// import 'package:kte/ui/utils/theme/theme.dart';
// import 'package:kte/ui/utils/widgets/common_dialog_widget.dart';
// import 'package:kte/ui/utils/widgets/common_svg.dart';
// import 'package:kte/ui/utils/widgets/common_text.dart';
//
// class SelectCustomDateWidgetWeb extends ConsumerWidget with BaseConsumerWidget {
//   const SelectCustomDateWidgetWeb({super.key});
//
//   @override
//   Widget buildPage(BuildContext context, WidgetRef ref) {
//     return Consumer(
//       builder: (context, ref, child) {
//         final orderListWatch = ref.watch(myOrderController);
//         return SizedBox(
//           height: context.height * 0.1,
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 0.01.sh,
//                 width: double.infinity,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: CommonText(
//                       title: LocalizationStrings.keySelectCustomDate.localized,
//                       textStyle: TextStyles.medium.copyWith(
//                         color: AppColors.black272727,
//                         fontSize: 20.sp,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Row(
//                       children: [
//                         _widgetCommonSelectDateTappable(context, isStartDate: true),
//                         SizedBox(
//                           width: 20.w,
//                         ),
//                         _widgetCommonSelectDateTappable(context, isStartDate: false),
//                         SizedBox(
//                           width: 20.w,
//                         ),
//                         Container(
//                           height: 0.05.sh,
//                           width: 0.05.sh,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors.black171717,
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               orderListWatch.clearFilter();
//                             },
//                             child: const CommonSVG(
//                               strIcon: AppAssets.svgRightArrow,
//                               svgColor: AppColors.white,
//                             ).paddingAll(10.w),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ).paddingSymmetric(horizontal: 20.w),
//         );
//       },
//     );
//   }
//
//   Widget _widgetCommonSelectDateTappable(BuildContext context, {required bool isStartDate}) {
//     return Consumer(
//       builder: (BuildContext context, WidgetRef ref, Widget? child) {
//         final orderListWatch = ref.watch(myOrderController);
//         return Expanded(
//           child: Opacity(
//             opacity: !isStartDate && orderListWatch.startDate == null ? 0.4 : 1,
//             // child: ShowDatePicketWidgetWeb(
//             //   dateWidget: _widgetCommonSelectDate(isStartDate: isStartDate, context: context),
//             //   isStartDate: isStartDate,
//             // ),
//             child: InkWell(
//               onTap: (){
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return CommonDialogWidget(
//                       child: ShowDatePicketWidgetWeb(isStartDate: isStartDate),
//                     );
//                   },
//                 );
//               },
//               child: _widgetCommonSelectDate(isStartDate: isStartDate, context: context),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _widgetCommonSelectDate({required bool isStartDate, required BuildContext context}) {
//     return Consumer(builder: (context, ref, child) {
//       final orderListWatch = ref.watch(myOrderController);
//       return Container(
//         height: 0.07.sh,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
//         alignment: Alignment.center,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.calendar_today_outlined,
//               color: getDateTextIconColor(isStartDate, orderListWatch),
//             ),
//             SizedBox(
//               width: 10.w,
//             ),
//             FittedBox(
//               fit: BoxFit.contain,
//               child: CommonText(
//                 title: getDateFromDateTime(isStartDate, orderListWatch),
//                 clrfont: getDateTextIconColor(isStartDate, orderListWatch),
//               ),
//             ),
//           ],
//         ).paddingSymmetric(horizontal: 5.w),
//       );
//     });
//   }
//
//   Color getDateTextIconColor(bool isStartDate, OrderListController orderListWatch) {
//     return isStartDate
//         ? (orderListWatch.startDate != null)
//             ? AppColors.primary
//             : AppColors.grey7E7E7E
//         : (orderListWatch.endDate != null)
//             ? AppColors.primary
//             : AppColors.grey7E7E7E;
//   }
//
//   String getDateFromDateTime(bool isStartDate, OrderListController orderListWatch) {
//     if (isStartDate) {
//       if (orderListWatch.startDate != null) {
//         return dateFormatFromDateTime(orderListWatch.startDate, 'dd/MM/yyyy');
//       } else {
//         return LocalizationStrings.keyStartDate.localized;
//       }
//     } else {
//       if (orderListWatch.endDate != null) {
//         return dateFormatFromDateTime(orderListWatch.endDate, 'dd/MM/yyyy');
//       } else {
//         return LocalizationStrings.keyEndDate.localized;
//       }
//     }
//   }
//
//   openDatePicker({required BuildContext context, required bool isStartDate, required DateTime? initialDate, required DateTime? firstDate, required DateTime? lastDate}) async {
//     final datePick = await showDatePicker(context: context, initialDate: initialDate ?? DateTime.now(), firstDate: firstDate ?? DateTime(7), lastDate: lastDate ?? DateTime.now());
//     return datePick;
//   }
// }
