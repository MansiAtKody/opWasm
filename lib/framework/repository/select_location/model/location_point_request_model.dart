// To parse this JSON data, do
//
//     final locationPointRequestModel = locationPointRequestModelFromJson(jsonString);

import 'dart:convert';

LocationPointRequestModel locationPointRequestModelFromJson(String str) => LocationPointRequestModel.fromJson(json.decode(str));

String locationPointRequestModelToJson(LocationPointRequestModel data) => json.encode(data.toJson());

class LocationPointRequestModel {
  String? locationUuid;

  LocationPointRequestModel({
    this.locationUuid,
  });

  factory LocationPointRequestModel.fromJson(Map<String, dynamic> json) => LocationPointRequestModel(
    locationUuid: json["locationUuid"],
  );

  Map<String, dynamic> toJson() => {
    "locationUuid": locationUuid,
  };
}
