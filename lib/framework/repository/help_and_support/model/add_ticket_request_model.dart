// To parse this JSON data, do
//
//     final addTicketRequestModel = addTicketRequestModelFromJson(jsonString);

import 'dart:convert';

AddTicketRequestModel addTicketRequestModelFromJson(String str) => AddTicketRequestModel.fromJson(json.decode(str));

String addTicketRequestModelToJson(AddTicketRequestModel data) => json.encode(data.toJson());

class AddTicketRequestModel {
  String? ticketReasonUuid;
  String? description;

  AddTicketRequestModel({
    this.ticketReasonUuid,
    this.description,
  });

  factory AddTicketRequestModel.fromJson(Map<String, dynamic> json) => AddTicketRequestModel(
    ticketReasonUuid: json["ticketReasonUuid"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "ticketReasonUuid": ticketReasonUuid,
    "description": description,
  };
}
