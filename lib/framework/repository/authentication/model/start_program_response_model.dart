// To parse this JSON data, do
//
//     final startProgramResponseModel = startProgramResponseModelFromJson(jsonString);

import 'dart:convert';

StartProgramResponseModel startProgramResponseModelFromJson(String str) => StartProgramResponseModel.fromJson(json.decode(str));

String startProgramResponseModelToJson(StartProgramResponseModel data) => json.encode(data.toJson());

class StartProgramResponseModel {
  String? message;
  String? status;

  StartProgramResponseModel({
    this.message,
    this.status,
  });

  factory StartProgramResponseModel.fromJson(Map<String, dynamic> json) => StartProgramResponseModel(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
