// To parse this JSON data, do
//
//     final addTicketResponseModel = addTicketResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';

AddTicketResponseModel addTicketResponseModelFromJson(String str) => AddTicketResponseModel.fromJson(json.decode(str));

String addTicketResponseModelToJson(AddTicketResponseModel data) => json.encode(data.toJson());

class AddTicketResponseModel {
  String? message;
  TicketResponseModel? data;
  int? status;

  AddTicketResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory AddTicketResponseModel.fromJson(Map<String, dynamic> json) => AddTicketResponseModel(
    message: json["message"],
    data: json["data"] == null ? null : TicketResponseModel.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "status": status,
  };
}


