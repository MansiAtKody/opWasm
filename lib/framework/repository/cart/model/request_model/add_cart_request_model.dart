// To parse this JSON data, do
//
//     final addCartRequestModel = addCartRequestModelFromJson(jsonString);

import 'dart:convert';

AddCartRequestModel addCartRequestModelFromJson(String str) => AddCartRequestModel.fromJson(json.decode(str));

String addCartRequestModelToJson(AddCartRequestModel data) => json.encode(data.toJson());

class AddCartRequestModel {
  String? productUuid;
  int? qty;
  List<CartAttributeDtoListData>? cartAttributeDtoList;
  String? uuid;

  AddCartRequestModel({
    this.productUuid,
    this.qty,
    this.cartAttributeDtoList,
    this.uuid
  });

  factory AddCartRequestModel.fromJson(Map<String, dynamic> json) => AddCartRequestModel(
    productUuid: json['productUuid'],
    qty: json['qty'],
    cartAttributeDtoList: json['cartAttributeDTOList'] == null ? [] : List<CartAttributeDtoListData>.from(json['cartAttributeDTOList']!.map((x) => CartAttributeDtoListData.fromJson(x))),
    uuid: json['uuid'],
  );

  Map<String, dynamic> toJson() => {
    'productUuid': productUuid,
    'qty': qty,
    'cartAttributeDTOList': cartAttributeDtoList == null ? [] : List<dynamic>.from(cartAttributeDtoList!.map((x) => x.toJson())),
    'uuid': uuid,
  };
}

class CartAttributeDtoListData {
  String? attributeUuid;
  String? attributeNameUuid;

  CartAttributeDtoListData({
    this.attributeUuid,
    this.attributeNameUuid,
  });

  factory CartAttributeDtoListData.fromJson(Map<String, dynamic> json) => CartAttributeDtoListData(
    attributeUuid: json['attributeUuid'],
    attributeNameUuid: json['attributeNameUuid'],
  );

  Map<String, dynamic> toJson() => {
    'attributeUuid': attributeUuid,
    'attributeNameUuid': attributeNameUuid,
  };
}
