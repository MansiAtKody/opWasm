// To parse this JSON data, do
//
//     final frequentlyBoughtListResponseModel = frequentlyBoughtListResponseModelFromJson(jsonString);

import 'dart:convert';

FrequentlyBoughtListResponseModel frequentlyBoughtListResponseModelFromJson(String str) => FrequentlyBoughtListResponseModel.fromJson(json.decode(str));

String frequentlyBoughtListResponseModelToJson(FrequentlyBoughtListResponseModel data) => json.encode(data.toJson());

class FrequentlyBoughtListResponseModel {
  String? message;
  List<ProductDetail>? data;
  int? status;

  FrequentlyBoughtListResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory FrequentlyBoughtListResponseModel.fromJson(Map<String, dynamic> json) => FrequentlyBoughtListResponseModel(
    message: json['message'],
    data: json['data'] == null ? [] : List<ProductDetail>.from(json['data']!.map((x) => ProductDetail.fromJson(x))),
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    'status': status,
  };
}

class ProductDetail {
  String? uuid;
  bool? active;
  bool? isAvailable;
  String? image;
  String? productName;
  String? productDescription;

  ProductDetail({
    this.uuid,
    this.active,
    this.isAvailable,
    this.image,
    this.productName,
    this.productDescription,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    uuid: json['uuid'],
    active: json['active'],
    isAvailable: json['isAvailable'],
    image: json['image'],
    productName: json['productName'],
    productDescription: json['productDescription'],
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'active': active,
    'isAvailable': isAvailable,
    'image': image,
    'productName': productName,
    'productDescription': productDescription,
  };
}
