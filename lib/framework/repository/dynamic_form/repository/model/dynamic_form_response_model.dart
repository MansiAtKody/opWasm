// To parse this JSON data, do
//
//     final dynamicFormResponseModel = dynamicFormResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

DynamicFormResponseModel dynamicFormResponseModelFromJson(String str) => DynamicFormResponseModel.fromJson(json.decode(str));

String dynamicFormResponseModelToJson(DynamicFormResponseModel data) => json.encode(data.toJson());

class DynamicFormResponseModel {
  String? message;
  DynamicFormData? data;
  int? status;

  DynamicFormResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory DynamicFormResponseModel.fromJson(Map<String, dynamic> json) => DynamicFormResponseModel(
        message: json['message'],
        data: json['data'] == null ? null : DynamicFormData.fromJson(json['data']),
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.toJson(),
        'status': status,
      };
}

class DynamicFormData {
  List<Field>? fields;
  List<ActiveLanguage>? activeLanguages;

  DynamicFormData({
    this.fields,
    this.activeLanguages,
  });

  factory DynamicFormData.fromJson(Map<String, dynamic> json) => DynamicFormData(
        fields: json['fields'] == null ? [] : List<Field>.from(json['fields']!.map((x) => Field.fromJson(x))),
        activeLanguages: json['activeLanguages'] == null ? [] : List<ActiveLanguage>.from(json['activeLanguages']!.map((x) => ActiveLanguage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'fields': fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
        'activeLanguages': activeLanguages == null ? [] : List<dynamic>.from(activeLanguages!.map((x) => x.toJson())),
      };
}

class ActiveLanguage {
  String? uuid;
  String? name;
  String? code;
  bool? isRtl;
  bool? isDefault;
  bool? active;

  ActiveLanguage({
    this.uuid,
    this.name,
    this.code,
    this.isRtl,
    this.isDefault,
    this.active,
  });

  factory ActiveLanguage.fromJson(Map<String, dynamic> json) => ActiveLanguage(
        uuid: json['uuid'],
        name: json['name'],
        code: json['code'],
        isRtl: json['isRTL'],
        isDefault: json['isDefault'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'name': name,
        'code': code,
        'isRTL': isRtl,
        'isDefault': isDefault,
        'active': active,
      };
}

class Field {
  String? fieldName;
  String? parentFieldName;
  String? responseFieldDTO;
  String? languageResponseFieldDTO;
  String? prefilledValue;
  String? type;
  bool? isLanguageEffected;
  int? orderIndex;
  List<Map<WidgetPropertyEnum, dynamic>> listWidget = [];
  ValidationsNew? validations;
  MessagesNew? messages;
  String? placeholder;
  String? format;
  List<DropdownData>? possibleValues;
  // DropdownData? selectedValue;
  Function(bool? value)? onStateChanged;
  Function(DropdownData? value)? onChanged;
  bool? isMultipleSelection;
  String? url;
  bool isEnabled;
  String? urlMethod;
  String? subUrl;
  String? subUrlMethod;
  String? subBodyParameter;
  String? bodyParameter;

  Field({
    this.fieldName,
    this.parentFieldName,
    this.responseFieldDTO,
    this.languageResponseFieldDTO,
    this.prefilledValue,
    this.isEnabled = true,
    this.type,
    this.isLanguageEffected,
    this.orderIndex,
    // this.widget,
    this.validations,
    this.messages,
    this.placeholder,
    this.format,
    this.possibleValues,
    this.onStateChanged,
    this.onChanged,
    this.isMultipleSelection,
    this.url,
    this.urlMethod,
    this.subUrl,
    this.subUrlMethod,
    this.bodyParameter,
    this.subBodyParameter,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        fieldName: json['fieldName'],
        parentFieldName: json['parentFieldName'],
        prefilledValue: json['prefilledValue'],
        responseFieldDTO: json['responseFieldDTO'],
        languageResponseFieldDTO: json['languageResponseFieldDTO'],
        type: json['type'],
        orderIndex: json['orderIndex'],
        isLanguageEffected: json['isLanguageEffected'],
        validations: json['validations'] == null ? null : ValidationsNew.fromJson(json['validations']),
        messages: json['messages'] == null ? null : MessagesNew.fromJson(json['messages']),
        placeholder: json['placeholder'],
        format: json['format'],
        possibleValues: json['possibleValues'] == null ? [] : List<DropdownData>.from(json['possibleValues']!.map((x) => DropdownData(name: x))),
        isMultipleSelection: json['isMultipleSelection'],
        url: (json['url'] == null || json['url'] == '') ? null : json['url'],
        urlMethod: json['urlMethod'],
        subUrl: json['subUrl'],
        subUrlMethod: json['subUrlMethod'],
        bodyParameter: json['bodyParameter'],
        subBodyParameter: json['subBodyParameter'],
      );

  Map<String, dynamic> toJson() => {
        'fieldName': fieldName,
        'parentFieldName': parentFieldName,
        'prefilledValue': prefilledValue,
        'responseFieldDTO': responseFieldDTO,
        'languageResponseFieldDTO': languageResponseFieldDTO,
        'type': type,
        'orderIndex': orderIndex,
        'isLanguageEffected': isLanguageEffected,
        'validations': validations?.toJson(),
        'messages': messages?.toJson(),
        'placeholder': placeholder,
        'format': format,
        'possibleValues': possibleValues == null ? [] : List<dynamic>.from(possibleValues!.map((x) => x)),
        'isMultipleSelection': isMultipleSelection,
        'url': url,
        'urlMethod': urlMethod,
        'bodyParameter': bodyParameter,
        'subBodyParameter': bodyParameter,
      };
}

class MessagesNew {
  String? requiredMessage;
  String? minMessage;
  String? maxMessage;
  String? invalidMessage;

  MessagesNew({
    this.requiredMessage,
    this.minMessage,
    this.maxMessage,
    this.invalidMessage,
  });

  factory MessagesNew.fromJson(Map<String, dynamic> json) => MessagesNew(
        requiredMessage: json['requiredMessage'],
        minMessage: json['minMessage'],
        maxMessage: json['maxMessage'],
        invalidMessage: json['invalidMessage'],
      );

  Map<String, dynamic> toJson() => {
        'requiredMessage': requiredMessage,
        'minMessage': minMessage,
        'invalidMessage': invalidMessage,
      };
}

class ValidationsNew {
  bool? required;
  int? min;
  int? max;
  String? pattern;

  ValidationsNew({
    this.required,
    this.min,
    this.max,
    this.pattern,
  });

  factory ValidationsNew.fromJson(Map<String, dynamic> json) => ValidationsNew(
        required: json['required'],
        min: json['min'],
        max: json['max'],
        pattern: json['pattern'],
      );

  Map<String, dynamic> toJson() => {
        'required': required,
        'min': min,
        'max': max,
        'pattern': pattern,
      };
}

class DropdownData {
  String? uuid;
  String? name;

  DropdownData({
    this.uuid,
    this.name,
  });

  factory DropdownData.fromJson(Map<String, dynamic> json) => DropdownData(
        name: json['name'],
        uuid: json['uuid'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'uuid': uuid,
      };
}

class LanguageDataModel {
  String? languageUuid;
  String? name;

  LanguageDataModel({
    this.languageUuid,
    this.name,
  });

  factory LanguageDataModel.fromJson(Map<String, dynamic> json) => LanguageDataModel(
        languageUuid: json['languageUuid'],
        name: json['name'],
      );
}

enum DynamicFormWidgetsEnumNew { textfield, number, dropdown, editor, date, image, password }
// enum DynamicFormWidgetsEnum { textfield, textarea, number, date, dropdown, radio, checkbox, formswitch }

final dynamicWidgetsValueNew = EnumValues({
  'textfield': DynamicFormWidgetsEnumNew.textfield,
  'number': DynamicFormWidgetsEnumNew.number,
  'dropdown': DynamicFormWidgetsEnumNew.dropdown,
  'editor': DynamicFormWidgetsEnumNew.editor,
  'image': DynamicFormWidgetsEnumNew.image,
  'date': DynamicFormWidgetsEnumNew.date,
  'password': DynamicFormWidgetsEnumNew.password,
});

class WidgetListClass {
  Widget widget;
  dynamic controller;

  WidgetListClass({
    required this.widget,
    this.controller,
  });
}
