// To parse this JSON data, do
//
//     final demoResponseModel = demoResponseModelFromJson(jsonString);

import 'dart:convert';

DemoResponseModel demoResponseModelFromJson(String str) => DemoResponseModel.fromJson(json.decode(str));

String demoResponseModelToJson(DemoResponseModel data) => json.encode(data.toJson());

class DemoResponseModel {
  DemoResponseModel({
    this.success,
    this.status,
  });

  int? success;
  int? status;

  factory DemoResponseModel.fromJson(Map<String, dynamic> json) => DemoResponseModel(
    success: json['success'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'status': status,
  };
}