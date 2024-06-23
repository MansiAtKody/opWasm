// To parse this JSON data, do
//
//     final sendOtpResponseModel = sendOtpResponseModelFromJson(jsonString);

import 'dart:convert';

SendOtpResponseModel sendOtpResponseModelFromJson(String str) => SendOtpResponseModel.fromJson(json.decode(str));

String sendOtpResponseModelToJson(SendOtpResponseModel data) => json.encode(data.toJson());

class SendOtpResponseModel {
  String? message;
  String? data;
  int? status;

  SendOtpResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) => SendOtpResponseModel(
    message: json['message'],
    data: json['data'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data,
    'status': status,
  };
}
