
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kody_operator/framework/controller/order_management/order_management_controller.dart';
// import 'package:kody_operator/framework/utility/extension/extension.dart';
// import 'package:kody_operator/framework/utility/extension/string_extension.dart';
// import 'package:kody_operator/ui/order_management/web/helper/order_management_right_widget.dart';
// import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
// import 'package:kody_operator/ui/utils/theme/app_colors.dart';
// import 'package:kody_operator/ui/utils/theme/app_strings.dart';
// import 'package:kody_operator/ui/utils/theme/text_style.dart';
// import 'package:kody_operator/ui/widgets/common_button.dart';
// import 'package:kody_operator/ui/widgets/common_text.dart';
//
// class OrderManagementWeb extends ConsumerStatefulWidget {
//   const OrderManagementWeb({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<OrderManagementWeb> createState() => _OrderManagementWebState();
// }
//
// class _OrderManagementWebState extends ConsumerState<OrderManagementWeb> with BaseConsumerStatefulWidget{
//
//
//   ///Init Override
//   @override
//   void initState() {
//     super.initState();
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       final orderManagementWatch = ref.watch(orderManagementController);
//       orderManagementWatch.disposeController(isNotify : true);
//     });
//   }
//
//   ///Dispose Override
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   ///Build Override
//   @override
//   Widget buildPage(BuildContext context) {
//     return Scaffold(
//       body: _bodyWidget(),
//     );
//   }
//
//   ///Body Widget
//   Widget _bodyWidget() {
//     return Consumer(
//       builder: (BuildContext context, WidgetRef ref, Widget? child) {
//         final orderManagementWatch = ref.watch(orderManagementController);
//         return SingleChildScrollView(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ///Left Widget
//               orderManagementWatch.isPressed
//                   ? Expanded(
//                       flex: 2,
//                       child: Column(
//                         children: [
//                           CommonText(
//                             title: LocalizationStrings.keyRobotTray.localized,
//                             textStyle: TextStyles.regular.copyWith(
//                               fontSize: 20.sp,
//                               color: AppColors.white,
//                             ),
//                           ),
//                           SizedBox(height: 35.h),
//                           ListView.separated(
//                               shrinkWrap: true,
//                               itemCount: 3,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return InkWell(
//                                     onTap: () {
//                                       orderManagementWatch.updateSelectedTray(index);
//                                     },
//                                     child: Container(
//                                         alignment: Alignment.center,
//                                         width: MediaQuery.of(context).size.width,
//                                         height: MediaQuery.of(context).size.height / 5,
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(30.r),
//                                             color: orderManagementWatch.selectedIndex == index
//                                                 ? AppColors.traySelected
//                                                 : AppColors.blackFFFFFF),
//                                         child: Stack(children: [
//                                           orderManagementWatch.trayImage[index] != null
//                                               ? Align(
//                                                 alignment: Alignment.center,
//                                                 child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             50.r),
//                                                     child: CachedNetworkImage(
//                                                       imageUrl: orderManagementWatch.trayImage[index]!,
//                                                       height: 43.w,
//                                                       width: 43.w,
//                                                     ),
//                                                   ),
//                                               )
//                                               : Container(),
//                                           Align(
//                                             alignment: Alignment.center,
//                                             child: CommonText(
//                                                 title: orderManagementWatch.trayNumber[index],
//                                                 textStyle: TextStyles.regular.copyWith(
//                                                     fontSize: 94.sp,
//                                                     color: orderManagementWatch.selectedIndex == index
//                                                         ? AppColors.white.withOpacity(0.3)
//                                                         : AppColors.white.withOpacity(0.2))))
//                                         ]).paddingOnly(bottom: 18.h)));
//                               },
//                               separatorBuilder:
//                                   (BuildContext context, int index) {
//                                 return Padding(
//                                     padding: EdgeInsets.only(bottom: 35.h));
//                               }),
//
//                           /// Dispatch Button
//                           CommonButton(
//                             onTap: () {
//                               orderManagementWatch.hideTray();
//                             },
//                             buttonText: LocalizationStrings.keyDispatch.localized,
//                             backgroundColor:
//                                 orderManagementWatch.selectedIndex != null
//                                     ? AppColors.green14861F
//                                     : AppColors.white.withOpacity(0.05),
//                           ).paddingOnly(top: 35.h)
//                         ],
//                       ).paddingOnly(
//                           left: 60.w, right: 60.w, top: 80.h, bottom: 45.h),
//                     )
//                   : const SizedBox(),
//
//                 ///Right Widget
//               const Expanded(
//                 flex: 8,
//                 child: OrderManagementRightWidget(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
