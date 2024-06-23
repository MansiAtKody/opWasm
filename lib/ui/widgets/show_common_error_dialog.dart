import 'package:kody_operator/ui/routing/delegate.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';

showCommonErrorDialog({
  required BuildContext context,
  required String message,
  TextStyle? textStyle,
  Function()? onButtonTap,
  double? height,
  double? width,
})
{
  if(globalNavigatorKey.currentContext?.isMobileScreen??false)
  {
    return showCommonErrorDialogMobile(context: context, message: message,textStyle: textStyle,onButtonTap: onButtonTap,height: height,width: width);
  }
  else
  {
    return showCommonErrorDialogWeb(context: context, message: message,textStyle: textStyle,onButtonTap: onButtonTap,height: height,width: width);
  }
}