// To parse this JSON data, do
//
//     final productDetailResponseModel = productDetailResponseModelFromJson(jsonString);

import 'dart:convert';

ProductDetailResponseModel productDetailResponseModelFromJson(String str) => ProductDetailResponseModel.fromJson(json.decode(str));

String productDetailResponseModelToJson(ProductDetailResponseModel data) => json.encode(data.toJson());

class ProductDetailResponseModel {
  String? message;
  Data? data;
  int? status;

  ProductDetailResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) => ProductDetailResponseModel(
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
  bool? active;
  String? productName;
  String? productDescription;
  dynamic productImageUrl;
  dynamic categoryUuid;
  String? categoryName;
  String? subCategoryUuid;
  String? subCategoryName;
  List<ProductAttribute>? productAttributes;

  Data({
    this.uuid,
    this.active,
    this.productName,
    this.productDescription,
    this.productImageUrl,
    this.categoryUuid,
    this.categoryName,
    this.subCategoryUuid,
    this.subCategoryName,
    this.productAttributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uuid: json['uuid'],
    active: json['active'],
    productName: json['productName'],
    productDescription: json['productDescription'],
    productImageUrl: json['productImageUrl'],
    categoryUuid: json['categoryUuid'],
    categoryName: json['categoryName'],
    subCategoryUuid: json['subCategoryUuid'],
    subCategoryName: json['subCategoryName'],
    productAttributes: json['productAttributes'] == null ? [] : List<ProductAttribute>.from(json['productAttributes']!.map((x) => ProductAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'active': active,
    'productName': productName,
    'productDescription': productDescription,
    'productImageUrl': productImageUrl,
    'categoryUuid': categoryUuid,
    'categoryName': categoryName,
    'subCategoryUuid': subCategoryUuid,
    'subCategoryName': subCategoryName,
    'productAttributes': productAttributes == null ? [] : List<dynamic>.from(productAttributes!.map((x) => x.toJson())),
  };
}

class ProductAttribute {
  String? uuid;
  String? attributeUuid;
  String? attributeName;
  bool? isMandatory;
  bool? isValidate;
  List<ProductAttributeName>? productAttributeNames;

  ProductAttribute({
    this.uuid,
    this.attributeUuid,
    this.attributeName,
    this.isMandatory,
    this.isValidate = false,
    this.productAttributeNames,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
    uuid: json['uuid'],
    attributeUuid: json['attributeUuid'],
    attributeName: json['attributeName'],
    isMandatory: json['isMandatory'],
    productAttributeNames: json['productAttributeNames'] == null ? [] : List<ProductAttributeName>.from(json['productAttributeNames']!.map((x) => ProductAttributeName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'attributeUuid': attributeUuid,
    'attributeName': attributeName,
    'isMandatory': isMandatory,
    'productAttributeNames': productAttributeNames == null ? [] : List<dynamic>.from(productAttributeNames!.map((x) => x.toJson())),
  };
}

class ProductAttributeName {
  String? uuid;
  String? attributeNameUuid;
  String? attributeNameName;
  String? attributeNameImage;
  double? price;

  ProductAttributeName({
    this.uuid,
    this.attributeNameUuid,
    this.attributeNameName,
    this.attributeNameImage,
    this.price,
  });

  factory ProductAttributeName.fromJson(Map<String, dynamic> json) => ProductAttributeName(
    uuid: json['uuid'],
    attributeNameUuid: json['attributeNameUuid'],
    attributeNameName: json['attributeNameName'],
    attributeNameImage: json['attributeNameImage'],
    price: json['price'],
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'attributeNameUuid': attributeNameUuid,
    'attributeNameName': attributeNameName,
    'attributeNameImage': attributeNameImage,
    'price': price,
  };
}
