// To parse this JSON data, do
//
//     final subOperatorListRequestModel = subOperatorListRequestModelFromJson(jsonString);

import 'dart:convert';

SubOperatorListRequestModel subOperatorListRequestModelFromJson(String str) => SubOperatorListRequestModel.fromJson(json.decode(str));

String subOperatorListRequestModelToJson(SubOperatorListRequestModel data) => json.encode(data.toJson());

class SubOperatorListRequestModel {
  dynamic active;
  String? searchKeyword;

  SubOperatorListRequestModel({
    this.active,
    this.searchKeyword,
  });

  factory SubOperatorListRequestModel.fromJson(Map<String, dynamic> json) => SubOperatorListRequestModel(
    active: json['active'],
    searchKeyword: json['searchKeyword'],
  );

  Map<String, dynamic> toJson() => {
    'active': active,
    'searchKeyword': searchKeyword,
  };
}
