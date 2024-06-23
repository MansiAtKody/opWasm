// To parse this JSON data, do
//
//     final coffeeSocketResponseModel = coffeeSocketResponseModelFromJson(jsonString);

import 'dart:convert';

CoffeeSocketResponseModel coffeeSocketResponseModelFromJson(String str) => CoffeeSocketResponseModel.fromJson(json.decode(str));

String coffeeSocketResponseModelToJson(CoffeeSocketResponseModel data) => json.encode(data.toJson());

class CoffeeSocketResponseModel {
  String? haId;
  List<Item>? items;

  CoffeeSocketResponseModel({
    this.haId,
    this.items,
  });

  factory CoffeeSocketResponseModel.fromJson(Map<String, dynamic> json) => CoffeeSocketResponseModel(
    haId: json['haId'],
    items: json['items'] == null ? [] : List<Item>.from(json['items']!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'haId': haId,
    'items': items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  String? handling;
  String? key;
  String? level;
  int? timestamp;
  String? uri;
  dynamic value;

  Item({
    this.handling,
    this.key,
    this.level,
    this.timestamp,
    this.uri,
    this.value,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    handling: json['handling'],
    key: json['key'],
    level: json['level'],
    timestamp: json['timestamp'],
    uri: json['uri'],
    value: json['value'],
  );

  Map<String, dynamic> toJson() => {
    'handling': handling,
    'key': key,
    'level': level,
    'timestamp': timestamp,
    'uri': uri,
    'value': value,
  };
}
