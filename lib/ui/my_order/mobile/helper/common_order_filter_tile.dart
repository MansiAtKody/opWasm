import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_checkbox.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonOrderFilterTile extends StatelessWidget with BaseStatelessWidget{
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;
  const CommonOrderFilterTile({Key? key, required this.value, required this.onChanged, required this.title}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonCheckBox(value: value, onChanged: onChanged).paddingOnly(right: 5.h),
        Expanded(
          child: CommonText(
            title: title,
            textStyle: TextStyles.regular.copyWith(
              fontSize: 14.sp,
              color: AppColors.black171717
            ),
          ),
        )
      ],
    );
  }
}
