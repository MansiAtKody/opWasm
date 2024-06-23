// To parse this JSON data, do
//
//     final addItemListCartRequestModel = addItemListCartRequestModelFromJson(jsonString);

import 'dart:convert';

AddItemListCartRequestModel addItemListCartRequestModelFromJson(String str) => AddItemListCartRequestModel.fromJson(json.decode(str));

String addItemListCartRequestModelToJson(AddItemListCartRequestModel data) => json.encode(data.toJson());

class AddItemListCartRequestModel {
  List<CartDto>? cartDtOs;

  AddItemListCartRequestModel({
    this.cartDtOs,
  });

  factory AddItemListCartRequestModel.fromJson(Map<String, dynamic> json) => AddItemListCartRequestModel(
    cartDtOs: json["cartDTOs"] == null ? [] : List<CartDto>.from(json["cartDTOs"]!.map((x) => CartDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cartDTOs": cartDtOs == null ? [] : List<dynamic>.from(cartDtOs!.map((x) => x.toJson())),
  };
}

class CartDto {
  String? productUuid;
  int? qty;
  List<CartAttributeDtoList>? cartAttributeDtoList;

  CartDto({
    this.productUuid,
    this.qty,
    this.cartAttributeDtoList,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) => CartDto(
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
