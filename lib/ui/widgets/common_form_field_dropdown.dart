import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/dropdown/custom_input_decorator.dart';
import 'package:kody_operator/ui/widgets/dropdown/dropdown_button2.dart';

class CommonDropdownInputFormField<T> extends StatefulWidget {
  final List? menuItems;
  final double? borderWidth;
  final double? height;
  final String? Function(T?)? validator;
  final T? defaultValue;
  final Color? borderColor;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? textStyle;
  final Widget? suffixWidget;
  final double? borderRadius;
  final bool? isEnabled;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(T? value)? onChanged;
  final void Function(bool? value)? onMenuStateChange;
  final List<DropdownMenuItem<T>>? items;
  final DropdownButtonBuilder? selectedItemBuilder;
  final TextEditingController? textEditingController;
  final Function(String value)? searchMatchFn;
  final bool? menuStateValue;

  const CommonDropdownInputFormField({
    Key? key,
    this.menuItems,
    this.isEnabled,
    this.borderWidth,
    this.validator,
    this.borderColor,
    this.hintText,
    this.hintTextStyle,
    this.labelTextStyle,
    this.textStyle,
    this.defaultValue,
    this.borderRadius,
    this.suffixWidget,
    this.onChanged,
    this.onMenuStateChange,
    this.height,
    this.contentPadding,
    this.items,
    this.selectedItemBuilder,
    this.textEditingController,
    this.searchMatchFn,
    this.menuStateValue,
  }) : super(key: key);

  @override
  State<CommonDropdownInputFormField<T>> createState() => _CommonDropdownInputFormFieldState<T>();
}

class _CommonDropdownInputFormFieldState<T> extends State<CommonDropdownInputFormField<T>> with BaseStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    return AbsorbPointer(
      absorbing: !(widget.isEnabled ?? true),
      child: DropdownButtonFormField2<T>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: widget.defaultValue,
        onMenuStateChange: widget.onMenuStateChange,
        decoration: CustomInputDecoration(
          alignLabelWithHint: true,
          isDense: true,
          contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(vertical: 10.h),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.textFieldBorderColor,
              width: widget.borderWidth ?? 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.textFieldBorderColor,
              width: widget.borderWidth ?? 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
              width: widget.borderWidth ?? 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.textFieldBorderColor,
              width: widget.borderWidth ?? 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
              width: widget.borderWidth ?? 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          ),
          errorStyle: TextStyles.regular.copyWith(color: AppColors.errorColor, fontSize: 10.sp),
          errorPadding: EdgeInsets.only(left: 11.w),
          border: InputBorder.none,
          labelText: /*(defaultValue != null && defaultValue!.isNotEmpty) ?*/ widget.hintText,
          hintText: widget.hintText,
          labelStyle: widget.labelTextStyle ??
              TextStyles.medium.copyWith(
                fontSize: 14.sp,
                color: AppColors.textFieldBorderColor,
              ),
        ),
        isExpanded: true,
        hint: Text(
          widget.hintText ?? '',
          style: widget.hintTextStyle ??
              TextStyles.medium.copyWith(
                // fontSize: 14.sp,
                color: AppColors.textFieldBorderColor,
              ),
        ),
        dropdownSearchData: widget.textEditingController != null
            ? DropdownSearchData(
                searchInnerWidget: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  height: widget.height ?? 54.h,
                  child: TextFormField(
                    controller: widget.textEditingController,
                    onChanged: (value) {
                      widget.searchMatchFn?.call(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.borderColor ?? AppColors.textFieldBorderColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.borderColor ?? AppColors.textFieldBorderColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      errorStyle: TextStyles.regular.copyWith(color: AppColors.errorColor, fontSize: 10.sp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                searchInnerWidgetHeight: widget.height ?? 54.h,
              )
            : null,
        items: widget.items ??
            ((widget.menuItems != null)
                ? widget.menuItems!
                    .map(
                      (item) => DropdownMenuItem<T>(
                        value: item,
                        child: Text(item, style: TextStyles.medium.copyWith(color: AppColors.black)),
                      ),
                    )
                    .toList()
                : []),
        selectedItemBuilder: widget.selectedItemBuilder,
        validator: widget.validator,
        onChanged: (value) {
          widget.onChanged?.call(value);
        },
        onSaved: (value) {},
        buttonStyleData: ButtonStyleData(
            height: widget.height ?? 54.h,
            padding: EdgeInsets.only(right: 18.w),
            decoration: const BoxDecoration(
              color: AppColors.transparent,
            )),
        iconStyleData: IconStyleData(
          icon: RotatedBox(
            quarterTurns: widget.menuStateValue ?? false ? 2 : 0,
            child: CommonSVG(
              strIcon: AppAssets.svgDropDown,
              height: 25.h,
              width: 25.w,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: AppColors.whiteF7F7FC,
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ),
    );
  }
}
