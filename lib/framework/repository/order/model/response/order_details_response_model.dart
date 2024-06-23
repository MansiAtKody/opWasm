// To parse this JSON data, do
//
//     final orderDetailsResponseModel = orderDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsResponseModel orderDetailsResponseModelFromJson(String str) => OrderDetailsResponseModel.fromJson(json.decode(str));

String orderDetailsResponseModelToJson(OrderDetailsResponseModel data) => json.encode(data.toJson());

class OrderDetailsResponseModel {
    String? message;
    OrderDetailsData? data;
    int? status;

    OrderDetailsResponseModel({
        this.message,
        this.data,
        this.status,
    });

    factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) => OrderDetailsResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : OrderDetailsData.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "status": status,
    };
}

class OrderDetailsData {
    String? uuid;
    String? entityUuid;
    String? entityName;
    String? entityType;
    int? totalPrice;
    String? additionalNote;
    String? locationUuid;
    String? locationName;
    String? locationPointsUuid;
    String? locationPointsName;
    String? fieldValue;
    int? totalQty;
    List<OrderDetailsOrdersItem>? ordersItems;
    String? status;
    List<dynamic>? nextStatus;
    int? createdAt;
    bool? isFavourite;

    OrderDetailsData({
        this.uuid,
        this.entityUuid,
        this.entityName,
        this.entityType,
        this.totalPrice,
        this.additionalNote,
        this.locationUuid,
        this.locationName,
        this.locationPointsUuid,
        this.locationPointsName,
        this.fieldValue,
        this.totalQty,
        this.ordersItems,
        this.status,
        this.nextStatus,
        this.createdAt,
        this.isFavourite,
    });

    factory OrderDetailsData.fromJson(Map<String, dynamic> json) => OrderDetailsData(
        uuid: json["uuid"],
        entityUuid: json["entityUuid"],
        entityName: json["entityName"],
        entityType: json["entityType"],
        totalPrice: json["totalPrice"],
        additionalNote: json["additionalNote"],
        locationUuid: json["locationUuid"],
        locationName: json["locationName"],
        locationPointsUuid: json["locationPointsUuid"],
        locationPointsName: json["locationPointsName"],
        fieldValue: json["fieldValue"],
        totalQty: json["totalQty"],
        ordersItems: json["ordersItems"] == null ? [] : List<OrderDetailsOrdersItem>.from(json["ordersItems"]!.map((x) => OrderDetailsOrdersItem.fromJson(x))),
        status: json["status"],
        nextStatus: json["nextStatus"] == null ? [] : List<dynamic>.from(json["nextStatus"]!.map((x) => x)),
        createdAt: json["createdAt"],
        isFavourite: json["isFavourite"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "entityUuid": entityUuid,
        "entityName": entityName,
        "entityType": entityType,
        "totalPrice": totalPrice,
        "additionalNote": additionalNote,
        "locationUuid": locationUuid,
        "locationName": locationName,
        "locationPointsUuid": locationPointsUuid,
        "locationPointsName": locationPointsName,
        "fieldValue": fieldValue,
        "totalQty": totalQty,
        "ordersItems": ordersItems == null ? [] : List<dynamic>.from(ordersItems!.map((x) => x.toJson())),
        "status": status,
        "nextStatus": nextStatus == null ? [] : List<dynamic>.from(nextStatus!.map((x) => x)),
        "createdAt": createdAt,
        "isFavourite": isFavourite,
    };
}

class OrderDetailsOrdersItem {
    String? uuid;
    String? productUuid;
    String? productName;
    String? productDescription;
    String? productImage;
    bool? productAvailable;
    int? qty;
    dynamic locationPointsUuid;
    dynamic locationPointsName;
    List<OrderDetailsOrdersItemAttribute>? ordersItemAttributes;
    String? status;
    List<dynamic>? nextStatus;

    OrderDetailsOrdersItem({
        this.uuid,
        this.productUuid,
        this.productName,
        this.productDescription,
        this.productImage,
        this.productAvailable,
        this.qty,
        this.locationPointsUuid,
        this.locationPointsName,
        this.ordersItemAttributes,
        this.status,
        this.nextStatus,
    });

    factory OrderDetailsOrdersItem.fromJson(Map<String, dynamic> json) => OrderDetailsOrdersItem(
        uuid: json["uuid"],
        productUuid: json["productUuid"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        productImage: json["productImage"],
        productAvailable: json["productAvailable"],
        qty: json["qty"],
        locationPointsUuid: json["locationPointsUuid"],
        locationPointsName: json["locationPointsName"],
        ordersItemAttributes: json["ordersItemAttributes"] == null ? [] : List<OrderDetailsOrdersItemAttribute>.from(json["ordersItemAttributes"]!.map((x) => OrderDetailsOrdersItemAttribute.fromJson(x))),
        status: json["status"],
        nextStatus: json["nextStatus"] == null ? [] : List<dynamic>.from(json["nextStatus"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "productUuid": productUuid,
        "productName": productName,
        "productDescription": productDescription,
        "productImage": productImage,
        "productAvailable": productAvailable,
        "qty": qty,
        "locationPointsUuid": locationPointsUuid,
        "locationPointsName": locationPointsName,
        "ordersItemAttributes": ordersItemAttributes == null ? [] : List<dynamic>.from(ordersItemAttributes!.map((x) => x.toJson())),
        "status": status,
        "nextStatus": nextStatus == null ? [] : List<dynamic>.from(nextStatus!.map((x) => x)),
    };
}

class OrderDetailsOrdersItemAttribute {
    String? uuid;
    String? attributeUuid;
    String? attributeValue;
    String? productAttributeUuid;
    bool? productAttributeAvailable;
    String? attributeNameUuid;
    String? attributeNameValue;
    String? attributeNameImage;
    String? productAttributeNameUuid;
    bool? productAttributeNameAvailable;
    int? price;

    OrderDetailsOrdersItemAttribute({
        this.uuid,
        this.attributeUuid,
        this.attributeValue,
        this.productAttributeUuid,
        this.productAttributeAvailable,
        this.attributeNameUuid,
        this.attributeNameValue,
        this.attributeNameImage,
        this.productAttributeNameUuid,
        this.productAttributeNameAvailable,
        this.price,
    });

    factory OrderDetailsOrdersItemAttribute.fromJson(Map<String, dynamic> json) => OrderDetailsOrdersItemAttribute(
        uuid: json["uuid"],
        attributeUuid: json["attributeUuid"],
        attributeValue: json["attributeValue"],
        productAttributeUuid: json["productAttributeUuid"],
        productAttributeAvailable: json["productAttributeAvailable"],
        attributeNameUuid: json["attributeNameUuid"],
        attributeNameValue: json["attributeNameValue"],
        attributeNameImage: json["attributeNameImage"],
        productAttributeNameUuid: json["productAttributeNameUuid"],
        productAttributeNameAvailable: json["productAttributeNameAvailable"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "attributeUuid": attributeUuid,
        "attributeValue": attributeValue,
        "productAttributeUuid": productAttributeUuid,
        "productAttributeAvailable": productAttributeAvailable,
        "attributeNameUuid": attributeNameUuid,
        "attributeNameValue": attributeNameValue,
        "attributeNameImage": attributeNameImage,
        "productAttributeNameUuid": productAttributeNameUuid,
        "productAttributeNameAvailable": productAttributeNameAvailable,
        "price": price,
    };
}
