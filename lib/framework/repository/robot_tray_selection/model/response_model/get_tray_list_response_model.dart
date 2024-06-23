// To parse this JSON data, do
//
//     final getTrayListResponseModel = getTrayListResponseModelFromJson(jsonString);

import 'dart:convert';

GetTrayListResponseModel getTrayListResponseModelFromJson(String str) => GetTrayListResponseModel.fromJson(json.decode(str));

String getTrayListResponseModelToJson(GetTrayListResponseModel data) => json.encode(data.toJson());

class GetTrayListResponseModel {
  String? message;
  List<GetTrayListResponseData>? data;
  int? status;

  GetTrayListResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory GetTrayListResponseModel.fromJson(Map<String, dynamic> json) => GetTrayListResponseModel(
    message: json["message"],
    data: json["data"] == null ? [] : List<GetTrayListResponseData>.from(json["data"]!.map((x) => GetTrayListResponseData.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
  };
}

class GetTrayListResponseData {
  String? uuid;
  String? entityUuid;
  String? entityName;
  String? entityType;
  int? trayNumber;
  OrdersItem? ordersItem;

  GetTrayListResponseData({
    this.uuid,
    this.entityUuid,
    this.entityName,
    this.entityType,
    this.trayNumber,
    this.ordersItem,
  });

  factory GetTrayListResponseData.fromJson(Map<String, dynamic> json) => GetTrayListResponseData(
    uuid: json["uuid"],
    entityUuid: json["entityUuid"],
    entityName: json["entityName"],
    entityType: json["entityType"],
    trayNumber: json["trayNumber"],
    ordersItem: json["ordersItem"] == null ? null : OrdersItem.fromJson(json["ordersItem"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "entityUuid": entityUuid,
    "entityName": entityName,
    "entityType": entityType,
    "trayNumber": trayNumber,
    "ordersItem": ordersItem?.toJson(),
  };
}

class OrdersItem {
  String? uuid;
  String? productUuid;
  String? productName;
  String? productDescription;
  String? productImage;
  int? qty;
  String? locationPointsUuid;
  String? locationPointsName;
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
    this.locationPointsUuid,
    this.locationPointsName,
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
    locationPointsUuid: json["locationPointsUuid"],
    locationPointsName: json["locationPointsName"],
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
    "locationPointsUuid": locationPointsUuid,
    "locationPointsName": locationPointsName,
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
  double? price;

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
    price: json["price"]?.toDouble(),
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
