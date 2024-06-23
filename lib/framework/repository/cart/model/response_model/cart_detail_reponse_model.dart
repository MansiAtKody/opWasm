// To parse this JSON data, do
//
//     final cartDetailResponseModel = cartDetailResponseModelFromJson(jsonString);

import 'dart:convert';

CartDetailResponseModel cartDetailResponseModelFromJson(String str) => CartDetailResponseModel.fromJson(json.decode(str));

String cartDetailResponseModelToJson(CartDetailResponseModel data) => json.encode(data.toJson());

class CartDetailResponseModel {
  String? message;
  CartDetail? data;
  int? status;

  CartDetailResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory CartDetailResponseModel.fromJson(Map<String, dynamic> json) => CartDetailResponseModel(
    message: json['message'],
    data: json['data'] == null ? null : CartDetail.fromJson(json['data']),
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.toJson(),
    'status': status,
  };
}

class CartDetail {
  String? entityUuid;
  String? entityType;
  double? totalPrice;
  List<CartDtoListData>? cartDtoList;

  CartDetail({
    this.entityUuid,
    this.entityType,
    this.totalPrice,
    this.cartDtoList,
  });

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
    entityUuid: json['entityUuid'],
    entityType: json['entityType'],
    totalPrice: json['totalPrice'],
    cartDtoList: json['cartDTOList'] == null ? [] : List<CartDtoListData>.from(json['cartDTOList']!.map((x) => CartDtoListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'entityUuid': entityUuid,
    'entityType': entityType,
    'totalPrice': totalPrice,
    'cartDTOList': cartDtoList == null ? [] : List<dynamic>.from(cartDtoList!.map((x) => x.toJson())),
  };
}

class CartDtoListData {
  String? uuid;
  String? productUuid;
  String? productImage;
  int? qty;
  List<CartAttributeDtoDataList>? cartAttributeDtoList;

  CartDtoListData({
    this.uuid,
    this.productUuid,
    this.productImage,
    this.qty,
    this.cartAttributeDtoList,
  });

  factory CartDtoListData.fromJson(Map<String, dynamic> json) => CartDtoListData(
    uuid: json['uuid'],
    productUuid: json['productUuid'],
    productImage: json['productImage'],
    qty: json['qty'],
    cartAttributeDtoList: json['cartAttributeDTOList'] == null ? [] : List<CartAttributeDtoDataList>.from(json['cartAttributeDTOList']!.map((x) => CartAttributeDtoDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'productUuid': productUuid,
    'productImage': productImage,
    'qty': qty,
    'cartAttributeDTOList': cartAttributeDtoList == null ? [] : List<dynamic>.from(cartAttributeDtoList!.map((x) => x.toJson())),
  };
}

class CartAttributeDtoDataList {
  String? uuid;
  String? attributeUuid;
  String? attributeValue;
  String? attributeNameUuid;
  String? attributeNameValue;
  dynamic attributeNameImage;

  CartAttributeDtoDataList({
    this.uuid,
    this.attributeUuid,
    this.attributeValue,
    this.attributeNameUuid,
    this.attributeNameValue,
    this.attributeNameImage,
  });

  factory CartAttributeDtoDataList.fromJson(Map<String, dynamic> json) => CartAttributeDtoDataList(
    uuid: json['uuid'],
    attributeUuid: json['attributeUuid'],
    attributeValue: json['attributeValue'],
    attributeNameUuid: json['attributeNameUuid'],
    attributeNameValue: json['attributeNameValue'],
    attributeNameImage: json['attributeNameImage'],
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'attributeUuid': attributeUuid,
    'attributeValue': attributeValue,
    'attributeNameUuid': attributeNameUuid,
    'attributeNameValue': attributeNameValue,
    'attributeNameImage': attributeNameImage,
  };
}
