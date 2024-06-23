// To parse this JSON data, do
//
//     final robotStatusResponseModel = robotStatusResponseModelFromJson(jsonString);

import 'dart:convert';

RobotStatusResponseModel robotStatusResponseModelFromJson(String str) => RobotStatusResponseModel.fromJson(json.decode(str));

String robotStatusResponseModelToJson(RobotStatusResponseModel data) => json.encode(data.toJson());

class RobotStatusResponseModel {
  String? uuid;
  String? robotCode;
  dynamic password;
  String? profileImage;
  int? numberOfTray;
  String? operatorUuid;
  String? operatorName;
  bool? active;
  List<RobotValue>? robotValues;
  List<RobotLocation>? robotLocations;
  List<RobotService>? robotServices;
  dynamic userUuid;
  String? state;

  RobotStatusResponseModel({
    this.uuid,
    this.robotCode,
    this.password,
    this.profileImage,
    this.numberOfTray,
    this.operatorUuid,
    this.operatorName,
    this.active,
    this.robotValues,
    this.robotLocations,
    this.robotServices,
    this.userUuid,
    this.state,
  });

  factory RobotStatusResponseModel.fromJson(Map<String, dynamic> json) => RobotStatusResponseModel(
    uuid: json["uuid"],
    robotCode: json["robotCode"],
    password: json["password"],
    profileImage: json["profileImage"],
    numberOfTray: json["numberOfTray"],
    operatorUuid: json["operatorUuid"],
    operatorName: json["operatorName"],
    active: json["active"],
    robotValues: json["robotValues"] == null ? [] : List<RobotValue>.from(json["robotValues"]!.map((x) => RobotValue.fromJson(x))),
    robotLocations: json["robotLocations"] == null ? [] : List<RobotLocation>.from(json["robotLocations"]!.map((x) => RobotLocation.fromJson(x))),
    robotServices: json["robotServices"] == null ? [] : List<RobotService>.from(json["robotServices"]!.map((x) => RobotService.fromJson(x))),
    userUuid: json["userUuid"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "robotCode": robotCode,
    "password": password,
    "profileImage": profileImage,
    "numberOfTray": numberOfTray,
    "operatorUuid": operatorUuid,
    "operatorName": operatorName,
    "active": active,
    "robotValues": robotValues == null ? [] : List<dynamic>.from(robotValues!.map((x) => x.toJson())),
    "robotLocations": robotLocations == null ? [] : List<dynamic>.from(robotLocations!.map((x) => x.toJson())),
    "robotServices": robotServices == null ? [] : List<dynamic>.from(robotServices!.map((x) => x.toJson())),
    "userUuid": userUuid,
    "state": state,
  };
}

class RobotLocation {
  String? uuid;
  String? locationUuid;
  String? locationName;

  RobotLocation({
    this.uuid,
    this.locationUuid,
    this.locationName,
  });

  factory RobotLocation.fromJson(Map<String, dynamic> json) => RobotLocation(
    uuid: json["uuid"],
    locationUuid: json["locationUuid"],
    locationName: json["locationName"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "locationUuid": locationUuid,
    "locationName": locationName,
  };
}

class RobotService {
  String? uuid;
  String? service;

  RobotService({
    this.uuid,
    this.service,
  });

  factory RobotService.fromJson(Map<String, dynamic> json) => RobotService(
    uuid: json["uuid"],
    service: json["service"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "service": service,
  };
}

class RobotValue {
  String? languageUuid;
  String? languageName;
  String? uuid;
  String? name;

  RobotValue({
    this.languageUuid,
    this.languageName,
    this.uuid,
    this.name,
  });

  factory RobotValue.fromJson(Map<String, dynamic> json) => RobotValue(
    languageUuid: json["languageUuid"],
    languageName: json["languageName"],
    uuid: json["uuid"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "languageUuid": languageUuid,
    "languageName": languageName,
    "uuid": uuid,
    "name": name,
  };
}
