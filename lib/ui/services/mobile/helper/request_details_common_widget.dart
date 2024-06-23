import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

///Request Details Common Widget with label and it's value
class RequestDetailsCommonWidget extends StatelessWidget with BaseStatelessWidget {
  const RequestDetailsCommonWidget({
    super.key,
    required this.title,
    required this.label,
  });

  final String label;
  final String title;

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          title: label,
          textStyle: TextStyles.regular.copyWith(
            color: AppColors.grey7E7E7E,
            fontSize: 12.sp,
          ),
        ).paddingOnly(bottom: 10.h),
        CommonText(
          title: title,
          textStyle: TextStyles.regular.copyWith(
            color: AppColors.black171717,
            fontSize: 12.sp,
          ),
        ).paddingOnly(bottom: 10.h),
      ],
    );
  }
}
