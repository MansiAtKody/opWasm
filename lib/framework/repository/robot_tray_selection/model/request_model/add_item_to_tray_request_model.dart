// To parse this JSON data, do
//
//     final addItemToTrayRequestModel = addItemToTrayRequestModelFromJson(jsonString);

import 'dart:convert';

AddItemToTrayRequestModel addItemToTrayRequestModelFromJson(String str) => AddItemToTrayRequestModel.fromJson(json.decode(str));

String addItemToTrayRequestModelToJson(AddItemToTrayRequestModel data) => json.encode(data.toJson());

class AddItemToTrayRequestModel {
  String? robotUuid;
  int? trayNumber;
  List<TrayManagementList>? trayManagementList;

  AddItemToTrayRequestModel({
    this.robotUuid,
    this.trayNumber,
    this.trayManagementList,
  });

  factory AddItemToTrayRequestModel.fromJson(Map<String, dynamic> json) => AddItemToTrayRequestModel(
    robotUuid: json["robotUuid"],
    trayNumber: json["trayNumber"],
    trayManagementList: json["trayManagementList"] == null ? [] : List<TrayManagementList>.from(json["trayManagementList"]!.map((x) => TrayManagementList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "robotUuid": robotUuid,
    "trayNumber": trayNumber,
    "trayManagementList": trayManagementList == null ? [] : List<dynamic>.from(trayManagementList!.map((x) => x.toJson())),
  };
}

class TrayManagementList {
  String? ordersItemUuid;

  TrayManagementList({
    this.ordersItemUuid,
  });

  factory TrayManagementList.fromJson(Map<String, dynamic> json) => TrayManagementList(
    ordersItemUuid: json["ordersItemUuid"],
  );

  Map<String, dynamic> toJson() => {
    "ordersItemUuid": ordersItemUuid,
  };
}
