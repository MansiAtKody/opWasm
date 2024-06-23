import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/notification/model/response%20model/notification_list_response_model.dart';
import 'package:kody_operator/ui/notification/mobile/helper/notification_header_content_tile_list.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';

class NotificationHeaderTileList extends ConsumerWidget with BaseConsumerWidget {
  final NotificationData model;
  final int delay;
  final int modelIndex;

  const NotificationHeaderTileList({super.key, required this.model, required this.delay, required this.modelIndex});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        CommonCard(
            child: SlideLeftTransition(
              delay: delay,
              child: NotificationHeaderContentTileList(index: modelIndex),
            )
          // ListView.builder(
          //   itemCount:notificationScreenWatch.notificationListState.success?.data?.length??0,
          //   physics: const NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   itemBuilder: (context, index) {
          //     var notificationHeaderList = model.message;
          //     return SlideLeftTransition(
          //       delay: delay,
          //       child: Dismissible(
          //           key: Key(index.toString()),
          //           background: Container(color: Colors.red,),
          //           confirmDismiss:(value)async{
          //             return showConfirmationDialog(context: context, title: 'Delete Notification',
          //                 message: 'Are you sure you want to delete Notification',
          //                 didTakeAction: (status)
          //                 async{
          //                   if(status)
          //                   {
          //                     await notificationScreenWatch.deleteNotificationAPI(context,index.toString());
          //                     if(context.mounted){
          //                       await notificationScreenWatch.notificationListAPI(context);
          //                     }
          //                   }
          //                 }
          //             );
          //           },
          //           child: NotificationHeaderContentTileList(index:index)),
          //     );
          //   },
          //   // separatorBuilder: (BuildContext context, int index) {
          //   //   return Column(
          //   //     children: [
          //   //       Visibility(
          //   //         visible:true,
          //   //         // notificationScreenWatch.dateConverter(formatDatetime(createdAt: model.createdAt??0,dateFormat: 'dd MMM yyyy, hh:mm:ss')) != notificationScreenWatch.dateConverter(formatDatetime(createdAt: notificationScreenWatch.notificationList[index].data?.elementAt(index-1).createdAt??0,dateFormat: 'dd MMM yyyy, hh:mm:ss')),
          //   //         child: CommonText(
          //   //           title:notificationScreenWatch.dateConverter(formatDatetime(createdAt: model.createdAt??0,dateFormat: 'dd MMM yyyy, hh:mm:ss')),
          //   //           textStyle: TextStyles.regular.copyWith(color: AppColors.black,fontSize: 14.sp),
          //   //         ),
          //   //       ),
          //   //       Divider(
          //   //         height: 40.h,
          //   //         color: AppColors.greyBEBEBE.withOpacity(.2),
          //   //       ),
          //   //     ],
          //   //   );
          //   // },
          // ).paddingOnly(left: 21.w, top: 21.w, right: 67.w, bottom: 32.h),
        ),
      ],
    );
  }
}
