// To parse this JSON data, do
//
//     final addSubOperatorRequestModel = addSubOperatorRequestModelFromJson(jsonString);

import 'dart:convert';

AddSubOperatorRequestModel addSubOperatorRequestModelFromJson(String str) => AddSubOperatorRequestModel.fromJson(json.decode(str));

String addSubOperatorRequestModelToJson(AddSubOperatorRequestModel data) => json.encode(data.toJson());

class AddSubOperatorRequestModel {
  String? name;
  String? email;
  String? contactNumber;
  String? password;
  String? confirmPassword;

  AddSubOperatorRequestModel({
    this.name,
    this.email,
    this.contactNumber,
    this.password,
    this.confirmPassword,
  });

  factory AddSubOperatorRequestModel.fromJson(Map<String, dynamic> json) => AddSubOperatorRequestModel(
    name: json['name'],
    email: json['email'],
    contactNumber: json['contactNumber'],
    password: json['password'],
    confirmPassword: json['confirmPassword'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'contactNumber': contactNumber,
    'password': password,
    'confirmPassword': confirmPassword,
  };
}
