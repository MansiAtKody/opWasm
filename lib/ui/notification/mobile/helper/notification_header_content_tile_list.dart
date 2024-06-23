import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/notification/notification_screen_controller.dart';

import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class NotificationHeaderContentTileList extends ConsumerWidget with BaseConsumerWidget{
  final int index;
  const NotificationHeaderContentTileList({super.key,required this.index});

  @override
  Widget buildPage(BuildContext context,WidgetRef ref){
    final notificationScreenWatch = ref.watch(notificationScreenController);
    return Row(
      children: [
        const CommonSVG(strIcon: AppAssets.svgNotificationBlack),
        SizedBox(width: 15.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                title:  notificationScreenWatch.notificationListState.success?.data?.elementAt(index).orderType??'',
                maxLines: 5,
                fontSize: 14.sp,
              ),
              SizedBox(height: 5.h,),
              CommonText(
                maxLines: 5,
                title:notificationScreenWatch.notificationListState.success?.data?.elementAt(index).message.toString()??'',
                fontSize: 12.sp,clrfont: AppColors.textFieldLabelColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}