// To parse this JSON data, do
//
//     final registerTokenRequestModel = registerTokenRequestModelFromJson(jsonString);

import 'dart:convert';

RegisterTokenRequestModel registerTokenRequestModelFromJson(String str) => RegisterTokenRequestModel.fromJson(json.decode(str));

String registerTokenRequestModelToJson(RegisterTokenRequestModel data) => json.encode(data.toJson());

class RegisterTokenRequestModel {
  bool? active;
  String? deviceId;
  int? userId;
  String? userType;
  String? deviceType;
  String? uniqueDeviceId;

  RegisterTokenRequestModel({
    this.active,
    this.deviceId,
    this.userId,
    this.userType,
    this.deviceType,
    this.uniqueDeviceId,
  });

  factory RegisterTokenRequestModel.fromJson(Map<String, dynamic> json) => RegisterTokenRequestModel(
    active: json["active"],
    deviceId: json["deviceId"],
    userId: json["userId"],
    userType: json["userType"],
    deviceType: json["deviceType"],
    uniqueDeviceId: json["uniqueDeviceId"],
  );

  Map<String, dynamic> toJson() => {
    "active": active,
    "deviceId": deviceId,
    "userId": userId,
    "userType": userType,
    "deviceType": deviceType,
    "uniqueDeviceId": uniqueDeviceId,
  };
}
