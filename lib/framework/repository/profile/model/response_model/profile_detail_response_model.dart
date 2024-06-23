// To parse this JSON data, do
//
//     final profileDetailResponseModel = profileDetailResponseModelFromJson(jsonString);

import 'dart:convert';

ProfileDetailResponseModel profileDetailResponseModelFromJson(String str) => ProfileDetailResponseModel.fromJson(json.decode(str));

String profileDetailResponseModelToJson(ProfileDetailResponseModel data) => json.encode(data.toJson());

class ProfileDetailResponseModel {
  String? message;
  Data? data;
  int? status;

  ProfileDetailResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory ProfileDetailResponseModel.fromJson(Map<String, dynamic> json) => ProfileDetailResponseModel(
    message: json['message'],
    data: json['data'] == null ? null : Data.fromJson(json['data']),
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.toJson(),
    'status': status,
  };
}

class Data {
  String? uuid;
  String? email;
  String? contactNumber;
  String? name;
  bool? active;
  dynamic profileImage;
  bool? emailVerified;
  bool? contactVerified;
  bool? isArchive;

  Data({
    this.uuid,
    this.email,
    this.contactNumber,
    this.name,
    this.active,
    this.profileImage,
    this.emailVerified,
    this.contactVerified,
    this.isArchive,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uuid: json['uuid'],
    email: json['email'],
    contactNumber: json['contactNumber'],
    name: json['name'],
    active: json['active'],
    profileImage: json['profileImage'],
    emailVerified: json['emailVerified'],
    contactVerified: json['contactVerified'],
    isArchive: json['isArchive'],
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'email': email,
    'contactNumber': contactNumber,
    'name': name,
    'active': active,
    'profileImage': profileImage,
    'emailVerified': emailVerified,
    'contactVerified': contactVerified,
    'isArchive': isArchive,
  };
}
