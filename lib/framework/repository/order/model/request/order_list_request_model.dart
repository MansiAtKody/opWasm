// To parse this JSON data, do
//
//     final orderListRequestModel = orderListRequestModelFromJson(jsonString);

import 'dart:convert';

OrderListRequestModel orderListRequestModelFromJson(String str) => OrderListRequestModel.fromJson(json.decode(str));

String orderListRequestModelToJson(OrderListRequestModel data) => json.encode(data.toJson());

class OrderListRequestModel {
    List<String>? status;
    List<String>? entityType;
    String? searchKeyword;
    String? fromDate;
    String? toDate;
    bool? isFavourite;

    OrderListRequestModel({
        this.status,
        this.entityType,
        this.searchKeyword,
        this.fromDate,
        this.toDate,
        this.isFavourite,
    });

    factory OrderListRequestModel.fromJson(Map<String, dynamic> json) => OrderListRequestModel(
        status: json["status"] == null ? [] : List<String>.from(json["status"]!.map((x) => x)),
        entityType: json["entityType"] == null ? [] : List<String>.from(json["entityType"]!.map((x) => x)),
        searchKeyword: json["searchKeyword"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
        isFavourite: json["isFavourite"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? [] : List<dynamic>.from(status!.map((x) => x)),
        "entityType": entityType == null ? [] : List<dynamic>.from(entityType!.map((x) => x)),
        "searchKeyword": searchKeyword,
        "fromDate": fromDate,
        "toDate": toDate,
        "isFavourite": isFavourite,
    };
}
