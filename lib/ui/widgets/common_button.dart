import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonButton extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final String? leftImage;
  final double? leftImageHeight;
  final double? leftImageWidth;
  final double? leftImageHorizontalPadding;
  final GestureTapCallback? onValidateTap;
  final Widget? prefixIcon;
  final String? rightImage;
  final Widget? rightIcon;
  final double? rightImageHeight;
  final double? rightImageWidth;
  final double? rightImageHorizontalPadding;
  final String? buttonText;
  final int? buttonMaxLine;
  final TextStyle? buttonTextStyle;
  final double? buttonHorizontalPadding;
  final bool isButtonEnabled;
  final GestureTapCallback? onTap;
  final TextAlign? buttonTextAlignment;
  final Color? buttonTextColor;
  final Color? buttonEnabledColor;
  final Color? buttonDisabledColor;
  final double? buttonTextSize;
  final bool isLoading;
  final Color? loadingAnimationColor;
  final double? rightIconLeftPadding;

  const CommonButton({
    Key? key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.leftImage,
    this.leftImageHeight,
    this.leftImageWidth,
    this.leftImageHorizontalPadding,
    this.rightImage,
    this.rightImageHeight,
    this.rightImageWidth,
    this.rightImageHorizontalPadding,
    this.prefixIcon,
    this.buttonText,
    this.buttonMaxLine,
    this.buttonTextStyle,
    this.buttonHorizontalPadding,
    this.onTap,
    this.onValidateTap,
    this.buttonTextAlignment,
    this.buttonTextColor,
    this.isButtonEnabled = false,
    this.buttonEnabledColor,
    this.buttonDisabledColor,
    this.buttonTextSize,
    this.isLoading = false,
    this.loadingAnimationColor, this.rightIcon,this.rightIconLeftPadding
  }) : super(key: key);

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    Color buttonColor = widget.isButtonEnabled ? (widget.buttonEnabledColor ?? AppColors.clr009AF1) : (widget.buttonDisabledColor ?? AppColors.clrF7F7FC);
    return AbsorbPointer(
      absorbing: widget.isLoading,
      child: InkWell(
        onTap: () {
          widget.onValidateTap?.call();
          if (widget.isButtonEnabled) {
            if(!widget.isLoading){
              widget.onTap?.call();
            }
          }
        },
        child: Container(
          height: widget.height ?? 50.h,
          width: widget.width ?? 233.w,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(40.r),
            border: Border.all(color: widget.borderColor ?? AppColors.transparent, width: widget.borderWidth ?? 0),
          ),
          child: widget.isLoading
          ? Center(
            child: LoadingAnimationWidget.waveDots(
              color: widget.loadingAnimationColor ?? AppColors.white,
              size: widget.height ?? 48.h,
            ),
          )
          : Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.prefixIcon != null
                  ? widget.prefixIcon!
                  : widget.leftImage != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.leftImageHorizontalPadding ?? 12.w),
                          child: Image.asset(
                            widget.leftImage!,
                            height: widget.leftImageHeight,
                            width: widget.leftImageWidth,
                          ),
                        )
                      : const Offstage(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.buttonHorizontalPadding ?? 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.buttonText ?? '',
                        textAlign: widget.buttonTextAlignment ?? TextAlign.center,
                        maxLines: widget.buttonMaxLine ?? 1,
                        style: widget.buttonTextStyle ?? TextStyles.regular.copyWith(fontSize: widget.buttonTextSize ?? 22.sp, color: widget.buttonTextColor ?? AppColors.white),
                      ),
                      if (widget.rightIcon != null)...{
                        Row(
                          children: [SizedBox(width: widget.rightImageHorizontalPadding ?? 8.w), widget.rightIcon!],
                        ),
                      }
                    ],
                  ),
                ),
              ),
                      if ((widget.rightImage ?? '').isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  widget.rightImageHorizontalPadding ?? 12.w),
                          child: Image.asset(
                            widget.rightImage!,
                            height: widget.rightImageHeight,
                            width: widget.rightImageWidth,
                          ),
                        ),
                  ],
          ).paddingAll(5.h),
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
* */
