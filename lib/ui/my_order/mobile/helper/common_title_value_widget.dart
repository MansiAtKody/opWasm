import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CommonTitleValueWidget extends StatelessWidget with BaseStatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final double? bottomPadding;
  final double? titleFontSize;
  final double? valueFontSize;
  const CommonTitleValueWidget({super.key, required this.title, required this.value, this.bottomPadding, this.valueColor, this.titleFontSize, this.valueFontSize});

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          title: title,
          clrfont: AppColors.grey7E7E7E,
          fontSize: titleFontSize,
        ),

        CommonText(
          title: value,
          clrfont: valueColor ?? AppColors.black171717,
          fontSize: valueFontSize,
        ),

      ],
    ).paddingOnly(bottom: bottomPadding ?? 15.h);
  }
}
