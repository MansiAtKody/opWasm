
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';


class CommonText extends StatelessWidget with BaseStatelessWidget{
  final String title;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? fontSize;
  final Color? clrfont;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final TextStyle? textStyle;
  final TextOverflow? textOverflow;
  final bool? softWrap;

  const CommonText(
      {Key? key,
      this.title = '',
      this.fontWeight,
      this.fontStyle,
      this.fontSize,
      this.clrfont,
      this.maxLines,
      this.textAlign,
      this.textDecoration,
      this.textStyle, this.textOverflow, this.softWrap = false})
      : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Text(
      title,
      textScaleFactor: 1.0,
      //-- will not change if system fonts size changed
      maxLines: maxLines ?? 1,
      textAlign: textAlign ?? TextAlign.start,
      overflow: textOverflow ??TextOverflow.ellipsis,
      style: textStyle ?? TextStyle(
              fontFamily: TextStyles.fontFamily,
              fontWeight: fontWeight ?? TextStyles.fwRegular,
              fontSize: fontSize ?? 14.sp,
              color: clrfont ?? AppColors.black171717,
              fontStyle: fontStyle ?? FontStyle.normal,
              decoration: textDecoration ?? TextDecoration.none),
      softWrap: softWrap,
    );
  }
}
