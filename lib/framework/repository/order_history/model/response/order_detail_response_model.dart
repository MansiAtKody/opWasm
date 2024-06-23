// To parse this JSON data, do
//
//     final orderDetailResponseModel = orderDetailResponseModelFromJson(jsonString);

import 'dart:convert';

OrderDetailResponseModel orderDetailResponseModelFromJson(String str) => OrderDetailResponseModel.fromJson(json.decode(str));

String orderDetailResponseModelToJson(OrderDetailResponseModel data) => json.encode(data.toJson());

class OrderDetailResponseModel {
  String? message;
  Data? data;
  int? status;

  OrderDetailResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory OrderDetailResponseModel.fromJson(Map<String, dynamic> json) => OrderDetailResponseModel(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "status": status,
  };
}

class Data {
  String? uuid;
  String? entityUuid;
  String? entityName;
  String? entityType;
  int? totalPrice;
  String? locationUuid;
  String? locationName;
  String? locationPointsUuid;
  String? locationPointsName;
  int? totalQty;
  List<OrdersItem>? ordersItems;
  String? status;
  List<String>? nextStatus;
  int? createdAt;

  Data({
    this.uuid,
    this.entityUuid,
    this.entityName,
    this.entityType,
    this.totalPrice,
    this.locationUuid,
    this.locationName,
    this.locationPointsUuid,
    this.locationPointsName,
    this.totalQty,
    this.ordersItems,
    this.status,
    this.nextStatus,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uuid: json["uuid"],
    entityUuid: json["entityUuid"],
    entityName: json["entityName"],
    entityType: json["entityType"],
    totalPrice: json["totalPrice"],
    locationUuid: json["locationUuid"],
    locationName: json["locationName"],
    locationPointsUuid: json["locationPointsUuid"],
    locationPointsName: json["locationPointsName"],
    totalQty: json["totalQty"],
    ordersItems: json["ordersItems"] == null ? [] : List<OrdersItem>.from(json["ordersItems"]!.map((x) => OrdersItem.fromJson(x))),
    status: json["status"],
    nextStatus: json["nextStatus"] == null ? [] : List<String>.from(json["nextStatus"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "entityUuid": entityUuid,
    "entityName": entityName,
    "entityType": entityType,
    "totalPrice": totalPrice,
    "locationUuid": locationUuid,
    "locationName": locationName,
    "locationPointsUuid": locationPointsUuid,
    "locationPointsName": locationPointsName,
    "totalQty": totalQty,
    "ordersItems": ordersItems == null ? [] : List<dynamic>.from(ordersItems!.map((x) => x.toJson())),
    "status": status,
    "nextStatus": nextStatus == null ? [] : List<dynamic>.from(nextStatus!.map((x) => x)),
    "createdAt": createdAt,
  };
}

class OrdersItem {
  String? uuid;
  String? productUuid;
  String? productName;
  String? productDescription;
  String? productImage;
  int? qty;
  List<OrdersItemAttribute>? ordersItemAttributes;
  String? status;
  List<String>? nextStatus;

  OrdersItem({
    this.uuid,
    this.productUuid,
    this.productName,
    this.productDescription,
    this.productImage,
    this.qty,
    this.ordersItemAttributes,
    this.status,
    this.nextStatus,
  });

  factory OrdersItem.fromJson(Map<String, dynamic> json) => OrdersItem(
    uuid: json["uuid"],
    productUuid: json["productUuid"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    productImage: json["productImage"],
    qty: json["qty"],
    ordersItemAttributes: json["ordersItemAttributes"] == null ? [] : List<OrdersItemAttribute>.from(json["ordersItemAttributes"]!.map((x) => OrdersItemAttribute.fromJson(x))),
    status: json["status"],
    nextStatus: json["nextStatus"] == null ? [] : List<String>.from(json["nextStatus"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "productUuid": productUuid,
    "productName": productName,
    "productDescription": productDescription,
    "productImage": productImage,
    "qty": qty,
    "ordersItemAttributes": ordersItemAttributes == null ? [] : List<dynamic>.from(ordersItemAttributes!.map((x) => x.toJson())),
    "status": status,
    "nextStatus": nextStatus == null ? [] : List<dynamic>.from(nextStatus!.map((x) => x)),
  };
}

class OrdersItemAttribute {
  String? uuid;
  String? attributeUuid;
  String? attributeValue;
  String? attributeNameUuid;
  String? attributeNameValue;
  String? attributeNameImage;
  int? price;

  OrdersItemAttribute({
    this.uuid,
    this.attributeUuid,
    this.attributeValue,
    this.attributeNameUuid,
    this.attributeNameValue,
    this.attributeNameImage,
    this.price,
  });

  factory OrdersItemAttribute.fromJson(Map<String, dynamic> json) => OrdersItemAttribute(
    uuid: json["uuid"],
    attributeUuid: json["attributeUuid"],
    attributeValue: json["attributeValue"],
    attributeNameUuid: json["attributeNameUuid"],
    attributeNameValue: json["attributeNameValue"],
    attributeNameImage: json["attributeNameImage"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "attributeUuid": attributeUuid,
    "attributeValue": attributeValue,
    "attributeNameUuid": attributeNameUuid,
    "attributeNameValue": attributeNameValue,
    "attributeNameImage": attributeNameImage,
    "price": price,
  };
}
