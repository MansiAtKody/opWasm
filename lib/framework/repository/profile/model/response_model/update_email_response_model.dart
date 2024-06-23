// To parse this JSON data, do
//
//     final updateEmailResponseModel = updateEmailResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateEmailResponseModel updateEmailResponseModelFromJson(String str) => UpdateEmailResponseModel.fromJson(json.decode(str));

String updateEmailResponseModelToJson(UpdateEmailResponseModel data) => json.encode(data.toJson());

class UpdateEmailResponseModel {
  String? message;
  UpdateEmailData? data;
  int? status;

  UpdateEmailResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory UpdateEmailResponseModel.fromJson(Map<String, dynamic> json) => UpdateEmailResponseModel(
    message: json['message'],
    data: json['data'] == null ? null : UpdateEmailData.fromJson(json['data']),
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.toJson(),
    'status': status,
  };
}

class UpdateEmailData {
  String? accessToken;

  UpdateEmailData({
    this.accessToken,
  });

  factory UpdateEmailData.fromJson(Map<String, dynamic> json) => UpdateEmailData(
    accessToken: json['access_token'],
  );

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
  };
}
