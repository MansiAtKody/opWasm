// To parse this JSON data, do
//
//     final updateEmailRequestModel = updateEmailRequestModelFromJson(jsonString);

import 'dart:convert';

UpdateEmailRequestModel updateEmailRequestModelFromJson(String str) => UpdateEmailRequestModel.fromJson(json.decode(str));

String updateEmailRequestModelToJson(UpdateEmailRequestModel data) => json.encode(data.toJson());

class UpdateEmailRequestModel {
  String? contactNumber;
  String? email;
  String? otp;
  String? password;

  UpdateEmailRequestModel({
    this.contactNumber,
    this.email,
    this.otp,
    this.password,
  });

  factory UpdateEmailRequestModel.fromJson(Map<String, dynamic> json) => UpdateEmailRequestModel(
    contactNumber: json['contactNumber'],
    email: json['email'],
    otp: json['otp'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'contactNumber': contactNumber,
    'email': email,
    'otp': otp,
    'password': password,
  };
}
