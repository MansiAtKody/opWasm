// To parse this JSON data, do
//
//     final placeOrderRequestModel = placeOrderRequestModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderRequestModel placeOrderRequestModelFromJson(String str) => PlaceOrderRequestModel.fromJson(json.decode(str));

String placeOrderRequestModelToJson(PlaceOrderRequestModel data) => json.encode(data.toJson());

class PlaceOrderRequestModel {
    String? additionalNote;
    String? locationPointsUuid;
    List<PlaceOrderCartList>? cartList;

    PlaceOrderRequestModel({
        this.additionalNote,
        this.locationPointsUuid,
        this.cartList,
    });

    factory PlaceOrderRequestModel.fromJson(Map<String, dynamic> json) => PlaceOrderRequestModel(
        additionalNote: json["additionalNote"],
        locationPointsUuid: json["locationPointsUuid"],
        cartList: json["cartList"] == null ? [] : List<PlaceOrderCartList>.from(json["cartList"]!.map((x) => PlaceOrderCartList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "additionalNote": additionalNote,
        "locationPointsUuid": locationPointsUuid,
        "cartList": cartList == null ? [] : List<dynamic>.from(cartList!.map((x) => x.toJson())),
    };
}

class PlaceOrderCartList {
    String? uuid;

    PlaceOrderCartList({
        this.uuid,
    });

    factory PlaceOrderCartList.fromJson(Map<String, dynamic> json) => PlaceOrderCartList(
        uuid: json["uuid"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
    };
}
