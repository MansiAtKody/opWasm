import 'package:kody_operator/ui/widgets/show_notification.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

showNotificationSnackBar(BuildContext context,{double? width,EdgeInsetsGeometry? padding, String? notificationTitle, String? notificationBody}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: width,
      elevation: 0,
      padding: padding??EdgeInsets.only(bottom: context.height*0.08, left: 20.w, right: 20.w),
      backgroundColor: Colors.transparent,
      content: ShowNotification(
        notificationTitle:notificationTitle ,
        notificationBody: notificationBody,
        onCloseTap: (){
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}