// To parse this JSON data, do
//
//     final editSubOperatorRequestModel = editSubOperatorRequestModelFromJson(jsonString);

import 'dart:convert';

EditSubOperatorRequestModel editSubOperatorRequestModelFromJson(String str) => EditSubOperatorRequestModel.fromJson(json.decode(str));

String editSubOperatorRequestModelToJson(EditSubOperatorRequestModel data) => json.encode(data.toJson());

class EditSubOperatorRequestModel {
  String? uuid;
  String? name;
  String? email;
  String? contactNumber;

  EditSubOperatorRequestModel({
    this.uuid,
    this.name,
    this.email,
    this.contactNumber,
  });

  factory EditSubOperatorRequestModel.fromJson(Map<String, dynamic> json) => EditSubOperatorRequestModel(
    uuid: json['uuid'],
    name: json['name'],
    email: json['email'],
    contactNumber: json['contactNumber'],
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'name': name,
    'email': email,
    'contactNumber': contactNumber,
  };
}
