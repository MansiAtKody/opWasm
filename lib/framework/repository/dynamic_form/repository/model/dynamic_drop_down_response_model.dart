import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';

class DynamicDropDownResponseModel {
  List<DropdownData>? data;

  DynamicDropDownResponseModel({
    this.data,
  });

  factory DynamicDropDownResponseModel.fromJson(Map<String, dynamic> json) => DynamicDropDownResponseModel(
    data: json['data'] == null ? [] : List<DropdownData>.from(json['data']!.map((x) => DropdownData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}