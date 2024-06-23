// To parse this JSON data, do
//
//     final cartListResponseModel = cartListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:kody_operator/framework/repository/profile/model/response_model/profile_detail_response_model.dart';
import 'package:kody_operator/framework/repository/select_location/model/location_point_list_response_model.dart';

CartListResponseModel cartListResponseModelFromJson(String str) => CartListResponseModel.fromJson(json.decode(str));

String cartListResponseModelToJson(CartListResponseModel data) => json.encode(data.toJson());

class CartListResponseModel {
  String? message;
  CartList? data;
  int? status;

  CartListResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory CartListResponseModel.fromJson(Map<String, dynamic> json) => CartListResponseModel(
    message: json['message'],
    data: json['data'] == null ? null : CartList.fromJson(json['data']),
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.toJson(),
    'status': status,
  };
}

class CartList {
  dynamic entityUuid;
  String? entityType;
  ProfileDetailResponseModel? userData;
  LocationPointResponseModel? locationPoint;
  double? totalPrice;
  List<CartDtoList>? cartDtoList;

  CartList({
    this.entityUuid,
    this.entityType,
    this.totalPrice,
    this.userData,
    this.locationPoint,
    this.cartDtoList,
  });

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
    entityUuid: json['entityUuid'],
    entityType: json['entityType'],
    totalPrice: json['totalPrice'],
    userData: json['userData'] == null ? null : ProfileDetailResponseModel.fromJson(json['userData']),
    locationPoint: json['locationPoint'] == null ? null : LocationPointResponseModel.fromJson(json['locationPoint']),
    cartDtoList: json['cartDTOList'] == null ? [] : List<CartDtoList>.from(json['cartDTOList']!.map((x) => CartDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'entityUuid': entityUuid,
    'entityType': entityType,
    'totalPrice': totalPrice,
    'userData': userData?.toJson(),
    'locationPoint': locationPoint?.toJson(),
    'cartDTOList': cartDtoList == null ? [] : List<dynamic>.from(cartDtoList!.map((x) => x.toJson())),
  };
}

class CartDtoList {
  String? uuid;
  String? productUuid;
  String? productName;
  dynamic productImage;
  int? qty;
  List<CartAttributesDtoList>? cartAttributeDtoList;

  CartDtoList({
    this.uuid,
    this.productUuid,
    this.productImage,
    this.qty,
    this.productName,
    this.cartAttributeDtoList,
  });

  factory CartDtoList.fromJson(Map<String, dynamic> json) => CartDtoList(
    uuid: json['uuid'],
    productUuid: json['productUuid'],
    productName: json['productName'],
    productImage: json['productImage'],
    qty: json['qty'],
    cartAttributeDtoList: json['cartAttributeDTOList'] == null ? [] : List<CartAttributesDtoList>.from(json['cartAttributeDTOList']!.map((x) => CartAttributesDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'productUuid': productUuid,
    'productName': productName,
    'productImage': productImage,
    'qty': qty,
    'cartAttributeDTOList': cartAttributeDtoList == null ? [] : List<dynamic>.from(cartAttributeDtoList!.map((x) => x.toJson())),
  };
}

class CartAttributesDtoList {
  String? uuid;
  String? attributeUuid;
  String? attributeValue;
  String? attributeNameUuid;
  String? attributeNameValue;
  dynamic attributeNameImage;

  CartAttributesDtoList({
    this.uuid,
    this.attributeUuid,
    this.attributeValue,
    this.attributeNameUuid,
    this.attributeNameValue,
    this.attributeNameImage,
  });

  factory CartAttributesDtoList.fromJson(Map<String, dynamic> json) => CartAttributesDtoList(
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
