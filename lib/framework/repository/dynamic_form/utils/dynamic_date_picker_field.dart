import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/date_picker/custom_date_picker.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class DynamicDatePickerField extends StatelessWidget with BaseStatelessWidget {
  final Field field;
  final TextEditingController textEditingController;
  final Function(DateTime? selectedDate, {bool? isOkPressed}) getDateCallback;

  const DynamicDatePickerField({super.key, required this.field, required this.getDateCallback, required this.textEditingController});

  @override
  Widget buildPage(BuildContext context) {
    return CommonInputFormField(
      textEditingController: textEditingController,
      hintText: LocalizationStrings.keyDateOfBirth.localized,
      readOnly: true,
      validator: (field.validations?.required ?? false) ? (value) => dynamicValidation(field, value) : null,
      isEnable: true,
      enableInteractiveSelection: false,
      suffixWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: PopupMenuButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.expand(
            width: context.width * 0.5,
            height: context.height * 0.55,
          ),
          enabled: true,
          tooltip: '',
          clipBehavior: Clip.hardEdge,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.r),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CustomDatePicker(
                    selectDateOnTap: true,
                    bubbleWidth: context.width * 0.5,
                    bubbleHeight: context.height * 0.5,
                    // initialDate:  addEmployeeWatch.dobDate,
                    lastDate: DateTime(DateTime.now().year - 10, DateTime.now().month),
                    getDateCallback: (DateTime? selectedDate, {bool? isOkPressed}) {
                      textEditingController.text = DateFormat('dd/MM/yyyy').format(selectedDate ?? DateTime.now());
                    },
                  ),
                ),
              ),
            ];
          },
          child: const CommonSVG(
            strIcon: AppAssets.svgCalender,
            width: 30,
            height: 30,
          ),
        ),
      ),
      textInputType: TextInputType.datetime,
    ).paddingSymmetric(vertical: 10.h);
  }
}
