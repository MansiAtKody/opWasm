import 'dart:async';
import 'package:kody_operator/framework/repository/dynamic_form/repository/contract/dynamic_form_repository.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_date_picker_field.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_dropdown_new.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_form_field.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_image_widget.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_multiple_selection_dropdown.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:flutter/services.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart' as intl;

class DynamicForm {
  ///Create a singleton class
  DynamicForm._();
  //
  // static DynamicForm dynamicForm = DynamicForm._();
  //
  // ///To create a dynamic form
  // Future createDynamicForm(BuildContext context, DynamicFormResponseModel? responseModel, DynamicFormRepository apiRepository) async {
  //   for (var field in responseModel?.data?.fields ?? []) {
  //     if (field.isLanguageEffected ?? false) {
  //       for (var languages in responseModel?.data?.activeLanguages ?? []) {
  //         await getWidgetFromWidgetType(field, (responseModel?.data?.fields ?? []), dynamicWidgetsValueNew.map[field.type], apiRepository, languages: languages);
  //       }
  //     } else {
  //       await getWidgetFromWidgetType(field, (responseModel?.data?.fields ?? []), dynamicWidgetsValueNew.map[field.type], apiRepository);
  //     }
  //   }
  // }
  //
  // Future<Widget> getWidgetFromWidgetType(Field field, List<Field> fieldList, DynamicFormWidgetsEnumNew? widgetType, DynamicFormRepository apiRepository, {ActiveLanguage? languages}) async {
  //   switch (widgetType) {
  //     ///TextField
  //     case DynamicFormWidgetsEnumNew.textfield:
  //       TextEditingController textController = TextEditingController();
  //       Widget widget = DynamicFormFieldWidget(textController: textController, field: field, languages: languages);
  //       field.listWidget.add({
  //         WidgetPropertyEnum.widget: widget,
  //         WidgetPropertyEnum.languageUuid: languages?.uuid,
  //         WidgetPropertyEnum.textEditingController: textController,
  //       });
  //
  //     ///Number
  //     case DynamicFormWidgetsEnumNew.number:
  //       TextEditingController textController = TextEditingController();
  //       Widget widget = DynamicFormFieldWidget(textController: textController, field: field, languages: languages);
  //       field.listWidget.add({
  //         WidgetPropertyEnum.widget: widget,
  //         WidgetPropertyEnum.languageUuid: languages?.uuid,
  //         WidgetPropertyEnum.textEditingController: textController,
  //       });
  //
  //     ///Password
  //     case DynamicFormWidgetsEnumNew.password:
  //       TextEditingController textController = TextEditingController();
  //       Widget widget = DynamicFormFieldWidget(textController: textController, field: field, languages: languages);
  //       field.listWidget.add({
  //         WidgetPropertyEnum.widget: widget,
  //         WidgetPropertyEnum.languageUuid: languages?.uuid,
  //         WidgetPropertyEnum.textEditingController: textController,
  //       });
  //
  //     ///Dropdown
  //     case DynamicFormWidgetsEnumNew.dropdown:
  //       if (field.isMultipleSelection == false || field.isMultipleSelection == null) {
  //         TextEditingController searchController = TextEditingController();
  //         Widget widget = DynamicDropDown(field: field, fieldList: fieldList, apiRepository: apiRepository, searchController: searchController);
  //         field.listWidget.add({
  //           WidgetPropertyEnum.widget: widget,
  //           WidgetPropertyEnum.selectedValue: null,
  //         });
  //       } else {
  //         TextEditingController searchController = TextEditingController();
  //         Widget widget = DynamicMultipleSelectionDropDown(field: field, fieldList: fieldList, apiRepository: apiRepository, searchController: searchController);
  //         field.listWidget.add({
  //           WidgetPropertyEnum.widget: widget,
  //           WidgetPropertyEnum.selectedValue: null,
  //         });
  //       }
  //
  //     case DynamicFormWidgetsEnumNew.date:
  //       TextEditingController textController = TextEditingController();
  //       Widget widget = DynamicDatePickerField(
  //         field: field,
  //         textEditingController: textController,
  //         getDateCallback: (DateTime? selectedDate, {bool? isOkPressed}) {
  //           field.listWidget.add({
  //             WidgetPropertyEnum.date: selectedDate,
  //           });
  //         },
  //       );
  //       field.listWidget.add({
  //         WidgetPropertyEnum.widget: widget,
  //         WidgetPropertyEnum.languageUuid: languages?.uuid,
  //         WidgetPropertyEnum.textEditingController: textController,
  //       });
  //
  //     ///Image
  //     case DynamicFormWidgetsEnumNew.image:
  //       Widget widget = DynamicImageWidget(field: field);
  //       field.listWidget.add({
  //         WidgetPropertyEnum.widget: widget,
  //         WidgetPropertyEnum.languageUuid: languages?.uuid,
  //         WidgetPropertyEnum.imageBytes: null,
  //         WidgetPropertyEnum.imageUrl: null,
  //       });
  //       break;
  //     case DynamicFormWidgetsEnumNew.editor:
  //       field.listWidget.add({
  //         WidgetPropertyEnum.languageUuid: languages?.uuid,
  //         WidgetPropertyEnum.htmlEditorController: HtmlEditorController(),
  //         WidgetPropertyEnum.htmlValue: null,
  //       });
  //       break;
  //     case null:
  //       return const Offstage();
  //   }
  //   return const Offstage();
  // }
  //
  // ///To set data in fields
  // void setDataInfields(DynamicFormData? dynamicResponseData, Map<String, dynamic>? responseMap) {
  //   dynamicResponseData?.fields?.forEach((fields) {
  //     if (fields.isLanguageEffected ?? false) {
  //       dynamicResponseData.activeLanguages?.forEach((languages) {
  //         ///To create a data from response and response parameter
  //         List<LanguageDataModel>? languageDataList = List<LanguageDataModel>.from(responseMap?['${fields.languageResponseFieldDTO}']!.map(
  //           (x) {
  //             return LanguageDataModel(
  //               languageUuid: x['languageUuid'],
  //               name: x['${fields.responseFieldDTO}'],
  //             );
  //           },
  //         ));
  //
  //         ///To Set data according to language
  //         for (var languageData in languageDataList) {
  //           if (languageData.languageUuid == languages.uuid) {
  //             switch (dynamicWidgetsValueNew.map[fields.type]) {
  //               case DynamicFormWidgetsEnumNew.textfield:
  //                 (fields.listWidget.where((element) => element[WidgetPropertyEnum.languageUuid] == languages.uuid).firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text = languageData.name ?? '';
  //                 break;
  //               case DynamicFormWidgetsEnumNew.editor:
  //                 (fields.listWidget.where((element) => element[WidgetPropertyEnum.languageUuid] == languages.uuid).firstOrNull?[WidgetPropertyEnum.htmlEditorController] as HtmlEditorController).setText(languageData.name ?? '');
  //                 fields.listWidget.where((element) => element[WidgetPropertyEnum.languageUuid] == languages.uuid).firstOrNull?[WidgetPropertyEnum.htmlValue] = languageData.name ?? '';
  //                 break;
  //               default:
  //                 break;
  //             }
  //           }
  //         }
  //       });
  //     } else {
  //       switch (dynamicWidgetsValueNew.map[fields.type]) {
  //         case DynamicFormWidgetsEnumNew.textfield:
  //           (fields.listWidget.firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text = responseMap?['${fields.responseFieldDTO}']?.toString() ?? '';
  //           break;
  //         case DynamicFormWidgetsEnumNew.password:
  //           (fields.listWidget.firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text = responseMap?['${fields.responseFieldDTO}']?.toString() ?? '';
  //           break;
  //         case DynamicFormWidgetsEnumNew.number:
  //           (fields.listWidget.firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text = responseMap?['${fields.responseFieldDTO}']?.toString() ?? '';
  //           break;
  //         case DynamicFormWidgetsEnumNew.date:
  //           (fields.listWidget.firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text =
  //               intl.DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse((responseMap?['${fields.responseFieldDTO}'] ?? 0).toString())));
  //           break;
  //         case DynamicFormWidgetsEnumNew.dropdown:
  //           if (fields.isMultipleSelection == false || fields.isMultipleSelection == null) {
  //             if (fields.possibleValues?.firstOrNull?.uuid != null) {
  //               fields.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] = fields.possibleValues?.where((element) => element.uuid == responseMap?['${fields.responseFieldDTO}']).firstOrNull;
  //             } else {
  //               fields.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] = fields.possibleValues?.where((element) => element.name == responseMap?['${fields.responseFieldDTO}']).firstOrNull;
  //             }
  //           } else {
  //             List<Map<String, dynamic>>? multipleSelectionDropdownResponse = responseMap?['${fields.languageResponseFieldDTO}'];
  //             List<DropdownData>? selectedValue = (fields.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as List<DropdownData>?);
  //             if (fields.possibleValues?.firstOrNull?.uuid != null) {
  //               if (fields.possibleValues != null) {
  //                 for (var values in multipleSelectionDropdownResponse ?? []) {
  //                   if (selectedValue == null) {
  //                     selectedValue = [(fields.possibleValues!.where((data) => data.uuid == values['${fields.responseFieldDTO}']).first)];
  //                   } else {
  //                     selectedValue.add((fields.possibleValues!.where((data) => data.uuid == values['${fields.responseFieldDTO}']).first));
  //                   }
  //                 }
  //               }
  //             } else {
  //               if (fields.possibleValues != null) {
  //                 for (var values in multipleSelectionDropdownResponse ?? []) {
  //                   if (selectedValue == null) {
  //                     selectedValue = [(fields.possibleValues!.where((data) => data.name == values['${fields.responseFieldDTO}']).first)];
  //                   } else {
  //                     selectedValue.add((fields.possibleValues!.where((data) => data.name == values['${fields.responseFieldDTO}']).first));
  //                   }
  //                 }
  //               }
  //             }
  //             fields.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] = selectedValue;
  //           }
  //           break;
  //         case DynamicFormWidgetsEnumNew.image:
  //           fields.listWidget.firstOrNull?[WidgetPropertyEnum.imageUrl] = responseMap?['${fields.responseFieldDTO}'];
  //           break;
  //         default:
  //           break;
  //       }
  //     }
  //   });
  // }
  //
  // Uint8List? getImageFromFieldName(DynamicFormData? dynamicResponseData, String fieldName) {
  //   return (dynamicResponseData?.fields?.where((element) => element.fieldName == fieldName && element.type == 'image').firstOrNull?.listWidget.firstOrNull?[WidgetPropertyEnum.imageBytes] as Uint8List?);
  // }
  //
  // String? getImageUrlFromFieldName(DynamicFormData? dynamicResponseData, String fieldName) {
  //   return dynamicResponseData?.fields?.where((element) => element.fieldName == fieldName && element.type == 'image').firstOrNull?.listWidget.firstOrNull?[WidgetPropertyEnum.imageUrl];
  // }
  //
  // ///Get Request from dynamic form
  // Map<String, dynamic> getRequestFromDynamicForm(DynamicFormData? dynamicResponseData, {String? uuid}) {
  //   ///Request map to send request
  //   Map<String, dynamic> requestMap = {};
  //   if (uuid != null) {
  //     requestMap['uuid'] = uuid;
  //   }
  //   if (dynamicResponseData?.fields?.where((field) => field.isLanguageEffected == true).isNotEmpty ?? false) {
  //     List<Map<String, dynamic>> requestList = [];
  //     dynamicResponseData?.activeLanguages?.forEach((languages) {
  //       Map<String, dynamic> listRequestMap = ({});
  //       listRequestMap['languageUuid'] = languages.uuid;
  //       dynamicResponseData.fields?.where((field) => field.isLanguageEffected == true).forEach((fields) {
  //         ///To add request values values in list
  //         switch (dynamicWidgetsValueNew.map[fields.type]) {
  //           case DynamicFormWidgetsEnumNew.textfield:
  //             listRequestMap['${fields.responseFieldDTO}'] = (fields.listWidget.where((element) => element[WidgetPropertyEnum.languageUuid] == languages.uuid).firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text;
  //             break;
  //           default:
  //             break;
  //         }
  //       });
  //       requestList.add(listRequestMap);
  //       requestMap['${dynamicResponseData.fields?.where((field) => field.languageResponseFieldDTO != null).firstOrNull?.languageResponseFieldDTO}'] = requestList;
  //     });
  //   }
  //   dynamicResponseData?.fields?.where((field) => (field.isLanguageEffected == false)).forEach((fields) {
  //     switch (dynamicWidgetsValueNew.map[fields.type]) {
  //       case DynamicFormWidgetsEnumNew.textfield:
  //         requestMap['${fields.responseFieldDTO}'] = (fields.listWidget.firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text;
  //         break;
  //       case DynamicFormWidgetsEnumNew.number:
  //         requestMap['${fields.responseFieldDTO}'] = (fields.listWidget.firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text;
  //         break;
  //       case DynamicFormWidgetsEnumNew.password:
  //         requestMap['password'] = (fields.listWidget.firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text;
  //         break;
  //       case DynamicFormWidgetsEnumNew.date:
  //         requestMap['${fields.responseFieldDTO}'] = intl.DateFormat('dd/MM/yyyy').parse((fields.listWidget.firstOrNull?[WidgetPropertyEnum.textEditingController] as TextEditingController).text).millisecondsSinceEpoch;
  //         break;
  //       case DynamicFormWidgetsEnumNew.dropdown:
  //         if (fields.isMultipleSelection == false || fields.isMultipleSelection == null) {
  //           if ((fields.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as DropdownData?)?.uuid != null) {
  //             requestMap['${fields.responseFieldDTO}'] = (fields.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as DropdownData?)?.uuid;
  //           } else {
  //             requestMap['${fields.responseFieldDTO}'] = (fields.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as DropdownData?)?.name;
  //           }
  //         } else {
  //           List<Map<String, dynamic>> requestList = [];
  //           List<DropdownData>? selectedValue = (fields.listWidget.firstOrNull?[WidgetPropertyEnum.selectedValue] as List<DropdownData>?);
  //           selectedValue?.forEach((value) {
  //             Map<String, dynamic> listRequestMap = ({});
  //             listRequestMap['${fields.responseFieldDTO}'] = value.uuid ?? value.name;
  //             requestList.add(listRequestMap);
  //           });
  //           requestMap['${fields.languageResponseFieldDTO}'] = requestList;
  //         }
  //         break;
  //       default:
  //         break;
  //     }
  //   });
  //   return requestMap;
  // }
}
