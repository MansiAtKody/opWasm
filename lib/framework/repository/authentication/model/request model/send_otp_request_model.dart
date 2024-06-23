// To parse this JSON data, do
//
//     final sendOtpRequestModel = sendOtpRequestModelFromJson(jsonString);

import 'dart:convert';

SendOtpRequestModel sendOtpRequestModelFromJson(String str) => SendOtpRequestModel.fromJson(json.decode(str));

String sendOtpRequestModelToJson(SendOtpRequestModel data) => json.encode(data.toJson());

class SendOtpRequestModel {
  String? userUuid;
  String? type;
  String? userType;
  String? contactNumber;
  String? email;
  bool? verifyBeforeGenerate;

  SendOtpRequestModel({
    this.userUuid,
    this.type,
    this.userType,
    this.contactNumber,
    this.email,
    this.verifyBeforeGenerate,
  });

  factory SendOtpRequestModel.fromJson(Map<String, dynamic> json) => SendOtpRequestModel(
    userUuid: json['userUuid'],
    type: json['type'],
    userType: json['userType'],
    contactNumber: json['contactNumber'],
    email: json['email'],
    verifyBeforeGenerate: json['verifyBeforeGenerate'],
  );

  Map<String, dynamic> toJson() => {
    'userUuid': userUuid,
    'type': type,
    'userType': userType,
    'contactNumber': contactNumber,
    'email': email,
    'verifyBeforeGenerate': verifyBeforeGenerate,
  };
}
