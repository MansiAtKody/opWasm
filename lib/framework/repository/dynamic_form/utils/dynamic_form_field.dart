import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_widget_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicFormFieldWidget extends StatefulWidget {
  final TextEditingController textController;
  final Field field;
  final ActiveLanguage? languages;

  const DynamicFormFieldWidget({super.key, required this.textController, required this.field, required this.languages});

  @override
  State<DynamicFormFieldWidget> createState() => _DynamicFormFieldWidgetState();
}

class _DynamicFormFieldWidgetState extends State<DynamicFormFieldWidget> with BaseStatefulWidget {
  bool isPasswordVisible = false;

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final dropdownWatch = ref.watch(dynamicWidgetController);
      print('Mobile Length : ${widget.field.validations?.max}');
      return CommonInputFormField(
        textEditingController: widget.textController,
        hintText: '${widget.field.placeholder?.localized} ${widget.languages != null ? '( ${widget.languages?.name?.capsFirstLetterOfSentence} )' : ''}',
        textDirection: widget.languages?.isRtl ?? false ? TextDirection.rtl : TextDirection.ltr,
        maxLength: widget.field.validations?.max,
        obscureText: widget.field.type == DynamicFormWidgetsEnumNew.password.name ? !(isPasswordVisible) : null,
        textInputType: widget.field.type == DynamicFormWidgetsEnumNew.number.name ? TextInputType.number : null,
        textInputFormatter: widget.field.type == DynamicFormWidgetsEnumNew.number.name
            ? [LengthLimitingTextInputFormatter(widget.field.validations?.max ?? 255), FilteringTextInputFormatter.digitsOnly]
            : [LengthLimitingTextInputFormatter(widget.field.validations?.max ?? 255)],
        validator: (widget.field.validations?.required ?? false) ? (value) => dynamicValidation(widget.field, value) : null,
        suffixWidget: widget.field.type == DynamicFormWidgetsEnumNew.password.name
            ? InkWell(
                onTap: () {
                  isPasswordVisible = !isPasswordVisible;
                  dropdownWatch.notify();
                },
                child: CommonSVG(
                  strIcon: isPasswordVisible ? AppAssets.svgHidePassword : AppAssets.svgShowPassword,
                  svgColor: AppColors.black272727,
                ),
              ).paddingOnly(right: 20.w)
            : const Offstage(),
      ).paddingOnly(bottom: 10.h);
    });
  }
}
