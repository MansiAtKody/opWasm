// To parse this JSON data, do
//
//     final editSubOperatorResponseModel = editSubOperatorResponseModelFromJson(jsonString);

import 'dart:convert';

EditSubOperatorResponseModel editSubOperatorResponseModelFromJson(String str) => EditSubOperatorResponseModel.fromJson(json.decode(str));

String editSubOperatorResponseModelToJson(EditSubOperatorResponseModel data) => json.encode(data.toJson());

class EditSubOperatorResponseModel {
  String? message;
  int? status;

  EditSubOperatorResponseModel({
    this.message,
    this.status,
  });

  factory EditSubOperatorResponseModel.fromJson(Map<String, dynamic> json) => EditSubOperatorResponseModel(
    message: json['message'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
  };
}
