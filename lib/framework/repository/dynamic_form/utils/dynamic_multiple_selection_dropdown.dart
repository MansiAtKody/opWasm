import 'package:kody_operator/framework/repository/dynamic_form/repository/contract/dynamic_form_repository.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_widget_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_check_box.dart';
import 'package:kody_operator/ui/widgets/common_searchbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicMultipleSelectionDropDown extends ConsumerStatefulWidget {
  final Field field;
  final List<Field> fieldList;
  final DynamicFormRepository apiRepository;
  final TextEditingController searchController;

  const DynamicMultipleSelectionDropDown({super.key, required this.field, required this.fieldList, required this.apiRepository, required this.searchController});

  @override
  ConsumerState createState() => _DynamicMultipleSelectionDropDownState();
}

class _DynamicMultipleSelectionDropDownState extends ConsumerState<DynamicMultipleSelectionDropDown> with BaseConsumerStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.field.isEnabled) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DynamicDropdownMultipleSelectionListWidget(field: widget.field, fieldList: widget.fieldList, searchController: widget.searchController);
            },
          );
        }
      },
      child: Container(
              height: 54.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.textFieldBorderColor,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: (widget.field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as List<DropdownData>?) == null || ((widget.field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as List<DropdownData>?)?.isEmpty ?? false)
                        ? CommonText(
                            title: (widget.field.placeholder?.localized ?? '').capsFirstLetterOfSentence,
                            textStyle: TextStyles.medium.copyWith(color: AppColors.textFieldBorderColor),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: (widget.field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as List<DropdownData>?)?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              DropdownData item = (widget.field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as List<DropdownData>)[index];
                              return Container(
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  border: Border.all(
                                    color: AppColors.whiteEAEAEA,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CommonText(
                                      title: item.name ?? '',
                                      textStyle: TextStyles.medium.copyWith(color: AppColors.textFieldBorderColor),
                                    ),
                                    SizedBox(width: 4.w),
                                    InkWell(
                                      onTap: () {
                                        DynamicMultipleSelectionHelper.helper.updateSelectionValues(ref, item: item, field: widget.field);
                                      },
                                      child: const CommonSVG(
                                        strIcon: AppAssets.svgCross,
                                      ).paddingAll(5.r),
                                    ),
                                  ],
                                ).paddingOnly(left: 10.w, right: 5.w),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(width: 10.w);
                            },
                          ).paddingSymmetric(vertical: 5.h),
                  ),
                  SizedBox(width: 5.w),
                  CommonSVG(
                    strIcon: AppAssets.svgDropDown,
                    height: 25.h,
                    width: 25.w,
                  ),
                ],
              ).paddingOnly(right: 6.w, left: 10.w))
          .paddingOnly(bottom: 10.h),
    );
  }
}

class DynamicDropdownMultipleSelectionListWidget extends StatelessWidget with BaseStatelessWidget {
  final Field field;
  final List<Field> fieldList;
  final TextEditingController searchController;

  const DynamicDropdownMultipleSelectionListWidget({super.key, required this.field, required this.fieldList, required this.searchController});

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
              child: Stack(
                children: [
                  Column(
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
                            List<DropdownData>? selectedValue = (field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as List<DropdownData>?);
                            bool isItemSelected = false;
                            if (selectedValue != null) {
                              if (item.uuid == null) {
                                isItemSelected = selectedValue.where((value) => value.name == item.name).isNotEmpty;
                              } else {
                                isItemSelected = selectedValue.where((value) => value.uuid == item.uuid).isNotEmpty;
                              }
                            }
                            return Row(
                              children: [
                                CommonCheckBox(
                                  value: isItemSelected,
                                  onChanged: (value) {
                                    DynamicMultipleSelectionHelper.helper.updateSelectionValues(ref, item: item, field: field);
                                  },
                                ),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: CommonText(
                                    title: item.name ?? '',
                                    textStyle: TextStyles.medium.copyWith(color: AppColors.black),
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 10.w);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(color: AppColors.dividerColor).paddingSymmetric(vertical: 10.h);
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 10.w,
                    bottom: 10.h,
                    child: CommonButton(
                      width: context.width * 0.1,
                      height: context.height * 0.07,
                      isButtonEnabled: true,
                      buttonText: LocalizationStrings.keySave.localized,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DynamicMultipleSelectionHelper {
  DynamicMultipleSelectionHelper._();

  static DynamicMultipleSelectionHelper helper = DynamicMultipleSelectionHelper._();

  void updateSelectionValues(WidgetRef ref, {required DropdownData item, required Field field}) {
    List<DropdownData>? selectedValue = (field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as List<DropdownData>?);
    if (item.uuid == null) {
      if (selectedValue != null) {
        int valueIndex = selectedValue.indexWhere((value) => value.name == item.name);
        if (valueIndex == -1) {
          selectedValue.add(DropdownData(name: item.name));
        } else {
          selectedValue.removeWhere((value) => value.name == item.name);
        }
      } else {
        selectedValue = [DropdownData(name: item.name)];
      }
    } else {
      if (selectedValue != null) {
        int valueIndex = selectedValue.indexWhere((value) => value.uuid == item.uuid);
        if (valueIndex == -1) {
          selectedValue.add(DropdownData(name: item.name, uuid: item.uuid));
        } else {
          selectedValue.removeWhere((value) => value.uuid == item.uuid);
        }
      } else {
        selectedValue = [DropdownData(name: item.name, uuid: item.uuid)];
      }
    }
    field.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] = selectedValue;
    ref.watch(dynamicWidgetController).notify();
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
