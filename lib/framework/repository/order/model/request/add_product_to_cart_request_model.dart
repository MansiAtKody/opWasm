/*
// To parse this JSON data, do
//
//     final addProductToCartRequestModel = addProductToCartRequestModelFromJson(jsonString);

import 'dart:convert';

AddProductToCartRequestModel addProductToCartRequestModelFromJson(String str) => AddProductToCartRequestModel.fromJson(json.decode(str));

String addProductToCartRequestModelToJson(AddProductToCartRequestModel data) => json.encode(data.toJson());

class AddProductToCartRequestModel {
  String? productUuid;
  int? qty;
  List<CartAttributeDtoList>? cartAttributeDtoList;

  AddProductToCartRequestModel({
    this.productUuid,
    this.qty,
    this.cartAttributeDtoList,
  });

  factory AddProductToCartRequestModel.fromJson(Map<String, dynamic> json) => AddProductToCartRequestModel(
    productUuid: json["productUuid"],
    qty: json["qty"],
    cartAttributeDtoList: json["cartAttributeDTOList"] == null ? [] : List<CartAttributeDtoList>.from(json["cartAttributeDTOList"]!.map((x) => CartAttributeDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "productUuid": productUuid,
    "qty": qty,
    "cartAttributeDTOList": cartAttributeDtoList == null ? [] : List<dynamic>.from(cartAttributeDtoList!.map((x) => x.toJson())),
  };
}

class CartAttributeDtoList {
  String? attributeUuid;
  String? attributeNameUuid;

  CartAttributeDtoList({
    this.attributeUuid,
    this.attributeNameUuid,
  });

  factory CartAttributeDtoList.fromJson(Map<String, dynamic> json) => CartAttributeDtoList(
    attributeUuid: json["attributeUuid"],
    attributeNameUuid: json["attributeNameUuid"],
  );

  Map<String, dynamic> toJson() => {
    "attributeUuid": attributeUuid,
    "attributeNameUuid": attributeNameUuid,
  };
}
*/
