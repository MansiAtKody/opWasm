// To parse this JSON data, do
//
//     final getTicketListResponseModel = getTicketListResponseModelFromJson(jsonString);

import 'dart:convert';

GetTicketListResponseModel getTicketListResponseModelFromJson(String str) => GetTicketListResponseModel.fromJson(json.decode(str));

String getTicketListResponseModelToJson(GetTicketListResponseModel data) => json.encode(data.toJson());

class GetTicketListResponseModel {
  int? pageNumber;
  List<TicketResponseModel>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  String? message;
  int? totalCount;
  int? status;

  GetTicketListResponseModel({
    this.pageNumber,
    this.data,
    this.hasNextPage,
    this.totalPages,
    this.hasPreviousPage,
    this.message,
    this.totalCount,
    this.status,
  });

  factory GetTicketListResponseModel.fromJson(Map<String, dynamic> json) => GetTicketListResponseModel(
    pageNumber: json["pageNumber"],
    data: json["data"] == null ? [] : List<TicketResponseModel>.from(json["data"]!.map((x) => TicketResponseModel.fromJson(x))),
    hasNextPage: json["hasNextPage"],
    totalPages: json["totalPages"],
    hasPreviousPage: json["hasPreviousPage"],
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
    "message": message,
    "totalCount": totalCount,
    "status": status,
  };
}

class TicketResponseModel {
  int? id;
  String? uuid;
  String? ticketReason;
  String? ticketReasonUuid;
  int? entityId;
  String? entityUuid;
  bool? isUserArchived;
  String? userType;
  String? email;
  String? name;
  String? contactNumber;
  String? ticketStatus;
  List<NextStatus>? nextStatus;
  String? description;
  bool? active;
  int? createdAt;
  dynamic acknowledgeComment;
  dynamic acknowledgerName;
  bool? isAcknowledUserArchived;
  dynamic acknowledgerUuid;
  dynamic acknowledgedDate;
  dynamic resolverName;
  dynamic resolverUuid;
  bool? isResolverUserArchived;
  dynamic resolvedDate;
  dynamic resolveComment;

  TicketResponseModel({
    this.id,
    this.uuid,
    this.ticketReason,
    this.ticketReasonUuid,
    this.entityId,
    this.entityUuid,
    this.isUserArchived,
    this.userType,
    this.email,
    this.name,
    this.contactNumber,
    this.ticketStatus,
    this.nextStatus,
    this.description,
    this.active,
    this.createdAt,
    this.acknowledgeComment,
    this.acknowledgerName,
    this.isAcknowledUserArchived,
    this.acknowledgerUuid,
    this.acknowledgedDate,
    this.resolverName,
    this.resolverUuid,
    this.isResolverUserArchived,
    this.resolvedDate,
    this.resolveComment,
  });

  factory TicketResponseModel.fromJson(Map<String, dynamic> json) => TicketResponseModel(
    id: json["id"],
    uuid: json["uuid"],
    ticketReason: json["ticketReason"],
    ticketReasonUuid: json["ticketReasonUuid"],
    entityId: json["entityId"],
    entityUuid: json["entityUuid"],
    isUserArchived: json["isUserArchived"],
    userType: json["userType"],
    email: json["email"],
    name: json["name"],
    contactNumber: json["contactNumber"],
    ticketStatus: json["ticketStatus"],
    nextStatus: json["nextStatus"] == null ? [] : List<NextStatus>.from(json["nextStatus"]!.map((x) => nextStatusValues.map[x]!)),
    description: json["description"],
    active: json["active"],
    createdAt: json["createdAt"],
    acknowledgeComment: json["acknowledgeComment"],
    acknowledgerName: json["acknowledgerName"],
    isAcknowledUserArchived: json["isAcknowledUserArchived"],
    acknowledgerUuid: json["acknowledgerUuid"],
    acknowledgedDate: json["acknowledgedDate"],
    resolverName: json["resolverName"],
    resolverUuid: json["resolverUuid"],
    isResolverUserArchived: json["isResolverUserArchived"],
    resolvedDate: json["resolvedDate"],
    resolveComment: json["resolveComment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "ticketReason": ticketReason,
    "ticketReasonUuid": ticketReasonUuid,
    "entityId": entityId,
    "entityUuid": entityUuid,
    "isUserArchived": isUserArchived,
    "userType": userType,
    "email": email,
    "name": name,
    "contactNumber": contactNumber,
    "ticketStatus": ticketStatus,
    "nextStatus": nextStatus == null ? [] : List<dynamic>.from(nextStatus!.map((x) => nextStatusValues.reverse[x])),
    "description": description,
    "active": active,
    "createdAt": createdAt,
    "acknowledgeComment": acknowledgeComment,
    "acknowledgerName": acknowledgerName,
    "isAcknowledUserArchived": isAcknowledUserArchived,
    "acknowledgerUuid": acknowledgerUuid,
    "acknowledgedDate": acknowledgedDate,
    "resolverName": resolverName,
    "resolverUuid": resolverUuid,
    "isResolverUserArchived": isResolverUserArchived,
    "resolvedDate": resolvedDate,
    "resolveComment": resolveComment,
  };
}

enum NextStatus {
  ACKNOWLEDGED,
  RESOLVED
}

final nextStatusValues = EnumValues({
  "ACKNOWLEDGED": NextStatus.ACKNOWLEDGED,
  "RESOLVED": NextStatus.RESOLVED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
