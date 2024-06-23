import 'package:flutter/services.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/custom_mouse_region.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CommonInputFormField extends StatelessWidget with BaseStatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  final String? placeholderImage;
  final double? placeholderImageHeight;
  final double? placeholderImageWidth;
  final double? placeholderImageHorizontalPadding;
  final String? placeholderText;
  final TextStyle? placeholderTextStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final AutovalidateMode? autovalidateMode;
  final double? fieldHeight;
  final double? fieldWidth;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? fieldTextStyle;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final bool? isEnable;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final InputDecoration? inputDecoration;
  final bool? obscureText;
  final double? bottomFieldMargin;
  final Function(String text)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final Widget? suffixLabel;
  final Color? cursorColor;
  final bool? enableInteractiveSelection;
  final bool? readOnly;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final String? errorMessage;
  final String? labelText;
  final bool hasLabel;
  final TextAlignVertical? textAlignVertical;
  final bool? hasError;
  final Widget? label;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;

  const CommonInputFormField(
      {Key? key,
        required this.textEditingController,
        this.validator,
        this.placeholderImage,
        this.placeholderImageHeight,
        this.placeholderImageWidth,
        this.placeholderImageHorizontalPadding,
        this.placeholderText,
        this.placeholderTextStyle,
        this.hintText,
        this.hintTextStyle,
        this.fieldHeight,
        this.fieldWidth,
        this.backgroundColor,
        this.borderColor,
        this.borderWidth,
        this.borderRadius,
        this.fieldTextStyle,
        this.maxLines,
        this.maxLength,
        this.textInputFormatter,
        this.textInputAction,
        this.textInputType,
        this.textCapitalization,
        this.isEnable,
        this.prefixWidget,
        this.suffixWidget,
        this.inputDecoration,
        this.obscureText,
        this.bottomFieldMargin,
        this.onChanged,
        this.suffixLabel,
        this.cursorColor,
        this.enableInteractiveSelection,
        this.readOnly,
        this.onTap,
        this.focusNode,
        this.onFieldSubmitted,
        this.contentPadding,
        this.textAlignVertical,
        this.label,
        this.errorMessage = '',
        this.hasLabel = true,
        this.onTapOutside,
        this.hasError,
        this.autovalidateMode, this.labelText, this.keyboardType,
      this.textDirection})
      : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return CustomMouseRegion(
      cursor: SystemMouseCursors.text,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: fieldWidth ?? double.infinity,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomFieldMargin ?? 0),
              child: TextFormField(
                obscuringCharacter: '*',
                autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
                onTap: () {
                  focusNode?.requestFocus();
                  onTap?.call();
                },
                onFieldSubmitted: onFieldSubmitted,
                readOnly: readOnly ?? false,
                cursorColor: cursorColor ?? AppColors.black,
                controller: textEditingController,
                focusNode: focusNode,
                textDirection: textDirection,
                style: fieldTextStyle ?? TextStyles.medium.copyWith(color: AppColors.black),
                textAlign: TextAlign.start,
                textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
                maxLines: maxLines ?? 1,
                maxLength: maxLength ?? 1000,
                enableInteractiveSelection: enableInteractiveSelection ?? true,
                obscureText: obscureText ?? false,
                inputFormatters: textInputFormatter,
                onChanged: onChanged,
                textInputAction: textInputAction ?? TextInputAction.next,
                keyboardType: textInputType ?? TextInputType.text,
                textCapitalization: textCapitalization ?? TextCapitalization.none,
                onTapOutside: onTapOutside,
                onEditingComplete: () {},
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  enabled: isEnable ?? true,
                  counterText: '',
                  errorStyle: TextStyles.regular.copyWith(color: AppColors.errorColor, fontSize: 10.sp),
                  filled: true,
                  fillColor: backgroundColor ?? AppColors.transparent,
                  suffixIcon: suffixWidget != null ? Padding(padding: const EdgeInsets.all(2), child: suffixWidget) : null,
                  prefixIcon: prefixWidget,
                  contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: (context.height * 0.02), horizontal: 12.w /*(context.width * 0.015)*/),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.textFieldBorderColor,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(8.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.textFieldBorderColor,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(8.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.errorColor,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(8.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.textFieldBorderColor,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.errorColor,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                  ),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle:hintTextStyle ??
                TextStyles.medium.copyWith(
                color: ((validator?.call(textEditingController.text) != null) && textEditingController.text.isNotEmpty) ? AppColors.errorColor : AppColors.textFieldBorderColor,
                ),
                  labelText: hasLabel ? hintText : null,
                  label: label,
                  alignLabelWithHint: true,
                  labelStyle: hintTextStyle ??
                      TextStyles.medium.copyWith(
                        color: ((validator?.call(textEditingController.text) != null) && textEditingController.text.isNotEmpty) ? AppColors.errorColor : AppColors.textFieldBorderColor,
                      ),
                ),
                validator: validator,
              ),
            ),
          ),
          if (errorMessage != null && errorMessage!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 6.h, bottom: 6.h, left: 12.w),
              child: Text(
                errorMessage ?? '',
                style: TextStyles.regular.copyWith(color: AppColors.errorColor, fontSize: 10.sp),
              ),
            )
        ],
      ),
    );
  }
}

/*
Widget Usage

CommonInputFormField(
  textEditingController: _mobileController,
  suffixWidget: Image.asset(Assets.imagesIcApple),
  validator: validateEmail,
  backgroundColor: AppColors.pinch,
  prefixWidget: Image.asset(Assets.imagesIcApple),
  placeholderImage: Assets.imagesIcApple,
  placeholderText: 'Mobile Number',
)
*/
