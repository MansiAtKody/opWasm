import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/notification/notification_screen_controller.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class NotificationHeaderContentTileList extends ConsumerWidget with BaseConsumerWidget {
  final int index;
  // final NotificationHeaderModel notificationHeader;
  const NotificationHeaderContentTileList( {super.key,required this.index,});

  @override
  Widget buildPage(BuildContext context,WidgetRef ref) {
    final notificationScreenWatch = ref.watch(notificationScreenController);
    return Row(
      children: [
        Container(
          height: 44.h,
          width: 44.h,
          decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle
          ),
          child:  const CommonSVG(strIcon: AppAssets.svgNotificationWeb).paddingAll(12),
        ),
        SizedBox(width: 15.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonText(
                    title:notificationScreenWatch.notificationListState.success?.data?.elementAt(index).orderType??'',
                    maxLines: 5,
                    textStyle: TextStyles.medium.copyWith(fontSize: 18.sp),
                  ),
                  IconButton(onPressed: (){
                    showConfirmationDialogWeb(context: context, title: 'Delete Notification',
                        message: 'Are you sure you want to delete Notification',
                        dialogWidth: context.width*0.35,
                        didTakeAction: (status)
                        async{
                          if(status)
                          {
                            await notificationScreenWatch.deleteNotificationAPI(context,notificationScreenWatch.notificationListState.success?.data?.elementAt(index).id.toString()??'');
                            if(context.mounted){
                              await notificationScreenWatch.notificationListAPI(context);
                            }
                          }
                        }
                    );
                  }, icon: const Icon(Icons.delete_forever_outlined,size: 20,color: AppColors.red,))
                ],
              ),
              SizedBox(height: 5.h,),
              CommonText(
                maxLines: 5,
                title:notificationScreenWatch.notificationListState.success?.data?.elementAt(index).message.toString()??'',
                textStyle: TextStyles.regular.copyWith(fontSize: 16.sp,color: AppColors.textFieldLabelColor),
              ),
            ],
          ),
        )
      ],
    );
  }
}