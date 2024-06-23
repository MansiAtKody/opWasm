// To parse this JSON data, do
//
//     final productDetailResponseModel = productDetailResponseModelFromJson(jsonString);

import 'dart:convert';

ProductDetailResponseModel productDetailResponseModelFromJson(String str) => ProductDetailResponseModel.fromJson(json.decode(str));

String productDetailResponseModelToJson(ProductDetailResponseModel data) => json.encode(data.toJson());

class ProductDetailResponseModel {
  String? message;
  ProductDetailData? data;
  int? status;

  ProductDetailResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) => ProductDetailResponseModel(
        message: json['message'],
        data: json['data'] == null ? null : ProductDetailData.fromJson(json['data']),
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.toJson(),
        'status': status,
      };
}

class ProductDetailData {
  String? uuid;
  bool? isAvailable;
  String? productName;
  String? productDescription;
  dynamic productImageUrl;
  String? categoryUuid;
  String? categoryName;
  String? subCategoryUuid;
  String? subCategoryName;
  List<ProductAttribute>? productAttributes;
  bool? isExpanded;

  ProductDetailData({this.uuid, this.isAvailable, this.productName, this.productDescription, this.productImageUrl, this.categoryUuid, this.categoryName, this.subCategoryUuid, this.subCategoryName, this.productAttributes, this.isExpanded});

  factory ProductDetailData.fromJson(Map<String, dynamic> json) => ProductDetailData(
        uuid: json['uuid'],
        isAvailable: json['isAvailable'],
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
        'isAvailable': isAvailable,
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
  bool? isAvailable;
  List<ProductAttributeName>? productAttributeNames;

  ProductAttribute({
    this.uuid,
    this.attributeUuid,
    this.attributeName,
    this.isMandatory,
    this.isAvailable,
    this.productAttributeNames,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
        uuid: json['uuid'],
        attributeUuid: json['attributeUuid'],
        attributeName: json['attributeName'],
        isMandatory: json['isMandatory'],
        isAvailable: json['isAvailable'],
        productAttributeNames: json['productAttributeNames'] == null ? [] : List<ProductAttributeName>.from(json['productAttributeNames']!.map((x) => ProductAttributeName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'attributeUuid': attributeUuid,
        'attributeName': attributeName,
        'isMandatory': isMandatory,
        'isAvailable': isAvailable,
        'productAttributeNames': productAttributeNames == null ? [] : List<dynamic>.from(productAttributeNames!.map((x) => x.toJson())),
      };
}

class ProductAttributeName {
  String? uuid;
  String? attributeNameUuid;
  String? attributeNameName;
  String? attributeNameImage;
  double? price;
  bool? isAvailable;

  ProductAttributeName({
    this.uuid,
    this.attributeNameUuid,
    this.attributeNameName,
    this.attributeNameImage,
    this.price,
    this.isAvailable,
  });

  factory ProductAttributeName.fromJson(Map<String, dynamic> json) => ProductAttributeName(
        uuid: json['uuid'],
        attributeNameUuid: json['attributeNameUuid'],
        attributeNameName: json['attributeNameName'],
        attributeNameImage: json['attributeNameImage'],
        price: json['price'],
        isAvailable: json['isAvailable'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'attributeNameUuid': attributeNameUuid,
        'attributeNameName': attributeNameName,
        'attributeNameImage': attributeNameImage,
        'price': price,
        'isAvailable': isAvailable,
      };
}
