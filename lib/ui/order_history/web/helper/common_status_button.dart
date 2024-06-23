import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonStatusButton extends StatelessWidget {
  final String status;
  final double? height;
  final double? width;
  final bool? isFilled;

  const CommonStatusButton({Key? key, required this.status, this.height, this.width, this.isFilled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderStatusThemeModel theme = getStatusButtonTheme();
    return Container(
      height: height ?? 42.h,
      width: width ?? 0.11.sh,
      decoration: BoxDecoration(
        color: isFilled ?? false ? theme.backgroundColor : null,
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.all(Radius.circular(22.r)),
      ),
      child: Center(
        child: CommonText(
          title: (status =='ROBOT_CANCELED')?LocalizationStrings.keyCanceled.localized: status,
          textStyle: TextStyles.regular.copyWith(
            fontSize: 12.sp,
            color: theme.textColor,
          ),
        ),
      ),
    );
  }

  OrderStatusThemeModel getStatusButtonTheme() {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    switch (orderStatusEnumValues.map[status]) {
      case OrderStatusEnum.REJECTED:
        backgroundColor = AppColors.rejectedBgColor;
        borderColor = AppColors.redE80202;
        textColor = AppColors.redE80202;
        break;
      case OrderStatusEnum.PENDING:
        backgroundColor = AppColors.lightBlueE7FBFF;
        borderColor = AppColors.blue009AF1;
        textColor = AppColors.blue009AF1;
        break;
      case OrderStatusEnum.ACCEPTED:
        backgroundColor = AppColors.acceptedBgColor;
        borderColor = AppColors.green35A600;
        textColor = AppColors.green35A600;
        break;
      case OrderStatusEnum.PREPARED:
        backgroundColor = AppColors.preparedBgColor;
        borderColor = AppColors.preparedTextColor;
        textColor = AppColors.preparedTextColor;
        break;
      case OrderStatusEnum.DISPATCH:
        backgroundColor = AppColors.dispatchBgColor;
        borderColor = AppColors.dispatchTextColor;
        textColor = AppColors.dispatchTextColor;
        break;
      case OrderStatusEnum.PARTIALLY_DELIVERED:
        backgroundColor = AppColors.partiallyDeliveredBgColor;
        borderColor = AppColors.partiallyDeliveredTextColor;
        textColor = AppColors.partiallyDeliveredTextColor;
        break;
      case OrderStatusEnum.DELIVERED:
        backgroundColor = AppColors.deliveredBgColor;
        borderColor = AppColors.deliveredTextColor;
        textColor = AppColors.deliveredTextColor;
        break;
      case OrderStatusEnum.CANCELED:
        backgroundColor = AppColors.cancelledBgColor;
        borderColor = AppColors.cancelledTextColor;
        textColor = AppColors.cancelledTextColor;
        break;
      case OrderStatusEnum.ROBOT_CANCELED:
        backgroundColor = AppColors.cancelledBgColor;
        borderColor = AppColors.cancelledTextColor;
        textColor = AppColors.cancelledTextColor;
        break;

      case OrderStatusEnum.IN_TRAY:
        backgroundColor = AppColors.cancelledBgColor;
        borderColor = AppColors.cancelledTextColor;
        textColor = AppColors.cancelledTextColor;
        break;
      default:
        backgroundColor = AppColors.grey7D7D7D;
        borderColor = AppColors.grey7D7D7D;
        textColor = AppColors.grey7D7D7D;
        break;
    }
    return OrderStatusThemeModel(backgroundColor: backgroundColor, borderColor: borderColor, textColor: textColor);
  }
}

class OrderStatusThemeModel {
  Color backgroundColor;
  Color borderColor;
  Color textColor;

  OrderStatusThemeModel({required this.backgroundColor, required this.borderColor, required this.textColor});
}