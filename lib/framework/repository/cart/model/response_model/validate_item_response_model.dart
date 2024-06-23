// To parse this JSON data, do
//
//     final validateItemResponseModel = validateItemResponseModelFromJson(jsonString);

import 'dart:convert';

ValidateItemResponseModel validateItemResponseModelFromJson(String str) => ValidateItemResponseModel.fromJson(json.decode(str));

String validateItemResponseModelToJson(ValidateItemResponseModel data) => json.encode(data.toJson());

class ValidateItemResponseModel {
  String? message;
  Data? data;
  int? status;

  ValidateItemResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory ValidateItemResponseModel.fromJson(Map<String, dynamic> json) => ValidateItemResponseModel(
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
  bool? productPresent;
  int? qty;

  Data({
    this.uuid,
    this.productPresent,
    this.qty,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uuid: json['uuid'],
    productPresent: json['productPresent'],
    qty: json['qty'],
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'productPresent': productPresent,
    'qty': qty,
  };
}
