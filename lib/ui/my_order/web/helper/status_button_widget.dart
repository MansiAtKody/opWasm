
import 'package:kody_operator/ui/utils/theme/theme.dart';

import 'package:kody_operator/ui/utils/const/app_enums.dart';

import 'package:kody_operator/ui/widgets/common_text.dart';

class StatusButtonWidget extends StatelessWidget {
  final String status;
  const StatusButtonWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      width: 0.18.sh,
      decoration: BoxDecoration(
        border: Border.all(
            color: (status == OrderStatusEnum.PREPARED.name)
                ? AppColors.blue0083FC
                : (status == OrderStatusEnum.DELIVERED.name)
                ? AppColors.green14B500
                : (status == OrderStatusEnum.CANCELED.name)
                ? AppColors.redEE0000
                : (status == OrderStatusEnum.REJECTED.name)
                ? AppColors.yellowEF8F00
                : AppColors.greyB9B9B9),
        borderRadius: BorderRadius.all(Radius.circular(22.r)),
      ),
      child: Center(
        child: CommonText(
          title: status,
          textStyle: TextStyles.regular.copyWith(
              fontSize: 12.sp,
              color: (status == OrderStatusEnum.PREPARED.name)
                ? AppColors.blue0083FC
                : (status == OrderStatusEnum.DELIVERED.name)
                ? AppColors.green14B500
                : (status == OrderStatusEnum.CANCELED.name)
                ? AppColors.redEE0000
                : (status == OrderStatusEnum.REJECTED.name)
                ? AppColors.yellowEF8F00
                : AppColors.greyB9B9B9),
        ),
      ),
    );
  }
}
