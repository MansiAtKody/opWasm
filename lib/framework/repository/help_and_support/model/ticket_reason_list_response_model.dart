// To parse this JSON data, do
//
//     final ticketReasonListResponseModel = ticketReasonListResponseModelFromJson(jsonString);

import 'dart:convert';

TicketReasonListResponseModel ticketReasonListResponseModelFromJson(String str) => TicketReasonListResponseModel.fromJson(json.decode(str));

String ticketReasonListResponseModelToJson(TicketReasonListResponseModel data) => json.encode(data.toJson());

class TicketReasonListResponseModel {
  int? pageNumber;
  List<TicketReasonResponseModel>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  int? pageSize;
  String? message;
  int? totalCount;
  int? status;

  TicketReasonListResponseModel({
    this.pageNumber,
    this.data,
    this.hasNextPage,
    this.totalPages,
    this.hasPreviousPage,
    this.pageSize,
    this.message,
    this.totalCount,
    this.status,
  });

  factory TicketReasonListResponseModel.fromJson(Map<String, dynamic> json) => TicketReasonListResponseModel(
    pageNumber: json["pageNumber"],
    data: json["data"] == null ? [] : List<TicketReasonResponseModel>.from(json["data"]!.map((x) => TicketReasonResponseModel.fromJson(x))),
    hasNextPage: json["hasNextPage"],
    totalPages: json["totalPages"],
    hasPreviousPage: json["hasPreviousPage"],
    pageSize: json["pageSize"],
    message: json["message"],
    totalCount: json["totalCount"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "hasNextPage": hasNextPage,
    "totalPages": totalPages,
    "hasPreviousPage": hasPreviousPage,
    "pageSize": pageSize,
    "message": message,
    "totalCount": totalCount,
    "status": status,
  };
}

class TicketReasonResponseModel {
  String? uuid;
  String? platformType;
  bool? active;
  String? reason;

  TicketReasonResponseModel({
    this.uuid,
    this.platformType,
    this.active,
    this.reason,
  });

  factory TicketReasonResponseModel.fromJson(Map<String, dynamic> json) => TicketReasonResponseModel(
    uuid: json["uuid"],
    platformType: json["platformType"],
    active: json["active"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "platformType": platformType,
    "active": active,
    "reason": reason,
  };
}
