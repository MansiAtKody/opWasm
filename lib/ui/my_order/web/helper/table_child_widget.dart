import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class TableChildWidget extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const TableChildWidget({super.key, required this.text, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CommonText(
        title: text,
        textAlign: textAlign ?? TextAlign.left,
        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
      ),
    );
  }
}
