// To parse this JSON data, do
//
//     final getTicketListRequestModel = getTicketListRequestModelFromJson(jsonString);

import 'dart:convert';

GetTicketListRequestModel getTicketListRequestModelFromJson(String str) => GetTicketListRequestModel.fromJson(json.decode(str));

String getTicketListRequestModelToJson(GetTicketListRequestModel data) => json.encode(data.toJson());

class GetTicketListRequestModel {
  String? fromDate;
  String? toDate;
  String? currentDate;
  String? status;

  GetTicketListRequestModel({
    this.fromDate,
    this.toDate,
    this.currentDate,
    this.status,
  });

  factory GetTicketListRequestModel.fromJson(Map<String, dynamic> json) => GetTicketListRequestModel(
    fromDate: json["fromDate"],
    toDate: json["ToDate"],
    currentDate: json["currentDate"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "fromDate": fromDate,
    "ToDate": toDate,
    "currentDate": currentDate,
    "status": status,
  };
}
