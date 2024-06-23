import 'package:flutter/services.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/custom_mouse_region.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class CommonButtonMobile extends StatefulWidget {
  final bool? withBackground;
  final double? height;
  final double? width;
  final Color? buttonEnabledColor;
  final Color? buttonDisabledColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final Widget? leftIcon;
  final double? leftIconHeight;
  final double? leftIconWidth;
  final double? leftIconHorizontalPadding;
  final Widget? rightIcon;
  final double? rightIconLeftPadding;
  final double? rightIconHeight;
  final double? rightIconWidth;
  final double? rightIconHorizontalPadding;
  final String? buttonText;
  final int? buttonMaxLine;
  final TextStyle? buttonTextStyle;
  final double? buttonHorizontalPadding;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onValidateTap;
  final TextAlign? buttonTextAlignment;
  final Color? buttonTextColor;
  final bool isButtonEnabled;
  final bool isLoading;
  final Widget? textWidget;
  final Color? loadingAnimationColor;
  final bool? absorbing;

  const CommonButtonMobile({
    Key? key,
    this.withBackground,
    this.height,
    this.width,
    this.buttonEnabledColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.leftIcon,
    this.leftIconHeight,
    this.leftIconWidth,
    this.leftIconHorizontalPadding,
    this.rightIcon,
    this.rightIconLeftPadding,
    this.rightIconHeight,
    this.rightIconWidth,
    this.rightIconHorizontalPadding,
    this.buttonText,
    this.buttonMaxLine,
    this.buttonTextStyle,
    this.buttonHorizontalPadding,
    this.onTap,
    this.buttonTextAlignment,
    this.buttonTextColor,
    this.isButtonEnabled = true,
    this.buttonDisabledColor,
    this.isLoading = false,
    this.onValidateTap, this.textWidget,
    this.loadingAnimationColor,
    this.absorbing,
  }) : super(key: key);

  @override
  State<CommonButtonMobile> createState() => _CommonButtonMobileState();
}

class _CommonButtonMobileState extends State<CommonButtonMobile> with BaseStatefulWidget {
  bool buttonTapped = false;

  @override
  Widget buildPage(BuildContext context) {
    Color buttonColor = widget.isButtonEnabled ? (widget.buttonEnabledColor ?? AppColors.primary2) : (widget.buttonDisabledColor ?? AppColors.whiteF7F7FC);

    return AbsorbPointer(
      absorbing: widget.absorbing ?? false,
      child: CustomMouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: widget.withBackground ?? false ? EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w) : null,
          decoration: widget.withBackground ?? false
              ? BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.r),
                topLeft: Radius.circular(40.r),
              ))
              : null,
          child: GestureDetector(
            onTapDown: (down) {
              setState(() {
                buttonTapped = true;
              });
            },
            onTapUp: (up) {
              setState(() {
                buttonTapped = false;
              });
            },
            onTap: () async {
              HapticFeedback.heavyImpact();
              hideKeyboard(context);
              setState(() {
                buttonTapped = true;
              });
              await Future.delayed(const Duration(milliseconds: 50));
              setState(() {
                buttonTapped = false;
              });
              if (widget.isButtonEnabled) {
                if(!(widget.isLoading)){
                  widget.onTap?.call();
                }
              }
              widget.onValidateTap?.call();
            },
            onHorizontalDragEnd: (drag) {
              setState(() {
                buttonTapped = false;
              });
            },
            onVerticalDragEnd: (drag) {
              setState(() {
                buttonTapped = false;
              });
            },
            child: Transform.translate(
              offset: Offset(buttonTapped ? 4.w : 0, buttonTapped ? 4.h : 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: widget.height ?? 60.h,
                width: widget.width ?? double.infinity,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(40.r),
                  boxShadow: [BoxShadow(color: widget.buttonEnabledColor?.withOpacity(0.5) ?? AppColors.greyA3A3A3.withOpacity(0.8), offset: Offset(0, buttonTapped ? 0 : 4.h))],
                  border: Border.all(color: widget.borderColor ?? AppColors.transparent, width: widget.borderWidth ?? 1),
                ),
                child: widget.isLoading
                    ? Center(
                  child: LoadingAnimationWidget.waveDots(
                    color: widget.loadingAnimationColor ?? AppColors.white,
                    size: widget.height ?? 48.h,
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.leftIcon != null) widget.leftIcon!,
                    widget.textWidget??Text(
                      widget.buttonText ?? '',
                      textAlign: widget.buttonTextAlignment ?? TextAlign.right,
                      maxLines: 3,
                      style: widget.buttonTextStyle ?? TextStyles.regular.copyWith(fontSize: 16.sp, color: widget.buttonTextColor ?? AppColors.white),
                    ),
                    if (widget.rightIcon != null)
                      Row(
                        children: [SizedBox(width: widget.rightIconLeftPadding ?? 10.w), widget.rightIcon!],
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
Widget Usage
CommonButton(
          buttonText: "Login",
          onTap: () {

          },
        )
 */
