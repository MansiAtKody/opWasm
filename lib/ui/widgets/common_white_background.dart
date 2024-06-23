import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CommonWhiteBackground extends StatelessWidget with BaseStatelessWidget{
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Widget child;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;
  const CommonWhiteBackground({Key? key, this.width, this.height, required this.child, this.backgroundColor,this.appBar, this.padding}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        appBar ?? const Offstage(),
        Expanded(
          child: Container(
            height: height,
            width: width,
            padding: padding,
            decoration: BoxDecoration(
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight:  Radius.circular(20.r),
                ),
                color:backgroundColor?? AppColors.white
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}