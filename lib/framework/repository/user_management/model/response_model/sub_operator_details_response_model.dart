// To parse this JSON data, do
//
//     final subOperatorDetailResponseModel = subOperatorDetailResponseModelFromJson(jsonString);

import 'dart:convert';

SubOperatorDetailResponseModel subOperatorDetailResponseModelFromJson(String str) => SubOperatorDetailResponseModel.fromJson(json.decode(str));

String subOperatorDetailResponseModelToJson(SubOperatorDetailResponseModel data) => json.encode(data.toJson());

class SubOperatorDetailResponseModel {
  String? message;
  SubOperatorData? data;
  int? status;

  SubOperatorDetailResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory SubOperatorDetailResponseModel.fromJson(Map<String, dynamic> json) => SubOperatorDetailResponseModel(
    message: json["message"],
    data: json["data"] == null ? null : SubOperatorData.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "status": status,
  };
}

class SubOperatorData {
  String? uuid;
  String? email;
  String? contactNumber;
  String? name;
  String? userUuid;
  bool? active;
  String? operatorUuid;
  String? profileImage;
  bool? emailVerified;
  bool? contactVerified;
  bool? isArchive;

  SubOperatorData({
    this.uuid,
    this.email,
    this.contactNumber,
    this.name,
    this.userUuid,
    this.active,
    this.operatorUuid,
    this.profileImage,
    this.emailVerified,
    this.contactVerified,
    this.isArchive,
  });

  factory SubOperatorData.fromJson(Map<String, dynamic> json) => SubOperatorData(
    uuid: json["uuid"],
    email: json["email"],
    contactNumber: json["contactNumber"],
    name: json["name"],
    userUuid: json["userUuid"],
    active: json["active"],
    operatorUuid: json["operatorUuid"],
    profileImage: json["profileImage"],
    emailVerified: json["emailVerified"],
    contactVerified: json["contactVerified"],
    isArchive: json["isArchive"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "email": email,
    "contactNumber": contactNumber,
    "name": name,
    "userUuid": userUuid,
    "active": active,
    "operatorUuid": operatorUuid,
    "profileImage": profileImage,
    "emailVerified": emailVerified,
    "contactVerified": contactVerified,
    "isArchive": isArchive,
  };
}
