import 'dart:convert';

import 'package:kody_operator/framework/repository/dynamic_form/repository/contract/dynamic_form_repository.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_drop_down_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_widget_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_form_field_dropdown.dart';
import 'package:kody_operator/ui/widgets/common_searchbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicDropDown extends ConsumerStatefulWidget {
  final Field field;
  final List<Field> fieldList;
  final DynamicFormRepository apiRepository;
  final TextEditingController searchController;

  const DynamicDropDown({super.key, required this.field, required this.fieldList, required this.apiRepository, required this.searchController});

  @override
  ConsumerState createState() => _DynamicDropDownState();
}

class _DynamicDropDownState extends ConsumerState<DynamicDropDown> with BaseConsumerStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    Field? parentField = widget.fieldList.where((element) => element.fieldName == widget.field.parentFieldName).firstOrNull;
    if (widget.field.possibleValues?.firstOrNull?.uuid == null) {
      return CommonDropdownInputFormField<DropdownData>(
        hintText: widget.field.placeholder?.localized,
        validator: (DropdownData? value) => dynamicValidation(widget.field, value?.name),
        isEnabled: widget.field.isEnabled,
        menuItems: widget.field.possibleValues ?? [],
        defaultValue: widget.field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as DropdownData?,
        items: (widget.field.possibleValues ?? [])
            .map(
              (item) => DropdownMenuItem<DropdownData>(
                value: item,
                child: Text(item.name ?? '', style: TextStyles.medium.copyWith(color: AppColors.black)),
              ),
            )
            .toList(),
        onChanged: (DropdownData? value) {
          widget.field.onChanged?.call(value);
          widget.field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] = value;
        },
      ).paddingOnly(bottom: 10.h, top: 10.h);
    }
    return InkWell(
      onTap: () {
        if (widget.field.isEnabled) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DynamicDropdownListWidget(field: widget.field, fieldList: widget.fieldList, searchController: widget.searchController, apiRepository: widget.apiRepository);
            },
          );
        }
      },
      child: CommonInputFormField(
        textEditingController: TextEditingController(text: (widget.field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as DropdownData?)?.name),
        hintText: (widget.field.possibleValues == null || (widget.field.possibleValues?.isEmpty ?? false) && (parentField?.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] != null))
            ? 'No ${widget.field.placeholder?.localized} found'
            : widget.field.placeholder?.localized,
        validator: (String? value) => dynamicValidation(widget.field, value),
        readOnly: true,
        isEnable: false,
        suffixWidget: CommonSVG(
          strIcon: AppAssets.svgDropDown,
          height: 25.h,
          width: 25.w,
        ).paddingAll(4.r),
      ).paddingOnly(bottom: 10.h),
    );
  }
}

class DynamicDropdownListWidget extends StatelessWidget with BaseStatelessWidget {
  final Field field;
  final List<Field> fieldList;
  final TextEditingController searchController;
  final DynamicFormRepository apiRepository;

  const DynamicDropdownListWidget({super.key, required this.field, required this.fieldList, required this.searchController, required this.apiRepository});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final dropdownWatch = ref.watch(dynamicWidgetController);
        return FadeBoxTransition(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              height: context.height * 0.8,
              width: context.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CommonText(
                          title: '${LocalizationStrings.keySelect.localized} ${field.placeholder?.localized.capsFirstLetterOfSentence}',
                          textStyle: TextStyles.medium.copyWith(color: AppColors.black),
                        ),
                      ),
                      SizedBox(width: 15.h),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CommonSVG(strIcon: AppAssets.svgCrossIcon),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  CommonSearchBar(
                    controller: searchController,
                    onChanged: (value) async {
                      dropdownWatch.notify();
                    },
                    leftIcon: AppAssets.svgSearch,
                    borderColor: AppColors.clrD0D5DD,
                    clrSearchIcon: AppColors.clr687083,
                    cursorColor: AppColors.black,
                    textColor: AppColors.black,
                    placeholder: '${LocalizationStrings.keySearch.localized} ${field.placeholder?.localized.capsFirstLetterOfSentence}',
                    suffix: searchController.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              searchController.clear();
                              dropdownWatch.notify();
                            },
                            child: CommonSVG(
                              strIcon: AppAssets.svgCrossIcon,
                              height: 15.h,
                              width: 15.h,
                            ).paddingAll(4.h),
                          )
                        : null,
                    hintStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                    labelStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                  ),
                  SizedBox(height: 15.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: searchController.text.isEmpty ? (field.possibleValues ?? []).length : (field.possibleValues ?? []).where((values) => values.name?.toLowerCase().contains(searchController.text.toLowerCase()) ?? false).length,
                      itemBuilder: (BuildContext context, int index) {
                        DropdownData item =
                            searchController.text.isEmpty ? (field.possibleValues ?? [])[index] : (field.possibleValues ?? []).where((values) => values.name?.toLowerCase().contains(searchController.text.toLowerCase()) ?? false).toList()[index];
                        return InkWell(
                            onTap: () async {
                              field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] = item;
                              List<Field>? subFieldList = fieldList.where((element) => element.parentFieldName == field.fieldName).toList();
                              if (subFieldList.isNotEmpty) {
                                for (var subField in subFieldList) {
                                  Map<String?, String?> request = ({});
                                  request[subField.bodyParameter] = (field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as DropdownData?)?.uuid;
                                  apiRepository.getDropdownValuesApi((subField.url ?? ''), jsonEncode(request)).then(
                                    (apiResult) {
                                      apiResult.when(
                                        success: (success) {
                                          DynamicDropDownResponseModel responseModel = success as DynamicDropDownResponseModel;
                                          subField.possibleValues = responseModel.data;
                                          subField.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] = null;
                                          subField.isEnabled = true;
                                          dropdownWatch.notify();
                                        },
                                        failure: (failure) {
                                          dropdownWatch.notify();
                                        },
                                      );
                                    },
                                  );
                                }
                              }
                              dropdownWatch.notify();
                              Navigator.pop(context);
                            },
                            child: CommonText(
                              title: item.name ?? '',
                              textStyle: TextStyles.medium.copyWith(color: AppColors.black),
                            ).paddingSymmetric(horizontal: 10.w));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(color: AppColors.dividerColor).paddingSymmetric(vertical: 10.h);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
/*return CommonDropdownInputFormField<DropdownData>(
      hintText: (widget.field.possibleValues == null || (widget.field.possibleValues?.isEmpty ?? false) && (parentField?.selectedValue != null)) ? 'No ${widget.field.placeholder?.localized} found' : widget.field.placeholder?.localized,
      validator: (DropdownData? value) => dynamicValidation(widget.field, value?.name),
      isEnabled: widget.field.isEnabled,
      menuItems: widget.field.possibleValues ?? [],
      defaultValue: widget.field.selectedValue,
      items: (widget.field.possibleValues ?? [])
          .map(
            (item) => DropdownMenuItem<DropdownData>(
              value: item,
              child: Text(item.name ?? '', style: TextStyles.medium.copyWith(color: AppColors.black)),
            ),
          )
          .toList(),
      onChanged: (DropdownData? value) {
        widget.field.onChanged?.call(value);
        widget.field.selectedValue = value;
      },
    ).paddingOnly(bottom: 10.h, top: 10.h);*/
