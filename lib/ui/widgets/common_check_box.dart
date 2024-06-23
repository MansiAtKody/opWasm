import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CommonCheckBox extends StatelessWidget with BaseStatelessWidget{
  const CommonCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.shape, this.side,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final OutlinedBorder? shape;
  final BorderSide? side;

  @override
  Widget buildPage(BuildContext context) {
    return Checkbox(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3.r),bottomRight: Radius.circular(3.r)),
          ),

      activeColor: activeColor ?? AppColors.white,
      checkColor: checkColor ?? AppColors.black,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: side ?? MaterialStateBorderSide.resolveWith(
            (states) {
          if (states.contains(MaterialState.selected)) {
            return BorderSide(color: AppColors.blue009AF1, width: 1.w);
          } else {
            return BorderSide(color: AppColors.black, width: 1.w);
          }
        },
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
