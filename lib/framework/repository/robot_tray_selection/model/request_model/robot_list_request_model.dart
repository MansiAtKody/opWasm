// To parse this JSON data, do
//
//     final robotListRequestModel = robotListRequestModelFromJson(jsonString);

import 'dart:convert';

RobotListRequestModel robotListRequestModelFromJson(String str) => RobotListRequestModel.fromJson(json.decode(str));

String robotListRequestModelToJson(RobotListRequestModel data) => json.encode(data.toJson());

class RobotListRequestModel {
  String? robotName;
  String? operatorUuid;

  RobotListRequestModel({
    this.robotName,
    this.operatorUuid,
  });

  factory RobotListRequestModel.fromJson(Map<String, dynamic> json) => RobotListRequestModel(
    robotName: json["robotName"],
    operatorUuid: json["operatorUuid"],
  );

  Map<String, dynamic> toJson() => {
    "robotName": robotName,
    "operatorUuid": operatorUuid,
  };
}
