// To parse this JSON data, do
//
//     final ticketDetailsResponseModel = ticketDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';

TicketDetailsResponseModel ticketDetailsResponseModelFromJson(String str) => TicketDetailsResponseModel.fromJson(json.decode(str));

String ticketDetailsResponseModelToJson(TicketDetailsResponseModel data) => json.encode(data.toJson());

class TicketDetailsResponseModel {
  String? message;
  TicketResponseModel? data;
  int? status;

  TicketDetailsResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory TicketDetailsResponseModel.fromJson(Map<String, dynamic> json) => TicketDetailsResponseModel(
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

// class Data {
//   int? id;
//   String? uuid;
//   String? ticketReason;
//   String? ticketReasonUuid;
//   int? entityId;
//   String? entityUuid;
//   bool? isUserArchived;
//   String? userType;
//   String? email;
//   String? name;
//   String? contactNumber;
//   String? ticketStatus;
//   List<String>? nextStatus;
//   String? description;
//   bool? active;
//   int? createdAt;
//   dynamic acknowledgeComment;
//   dynamic acknowledgerName;
//   bool? isAcknowledUserArchived;
//   dynamic acknowledgerUuid;
//   dynamic acknowledgedDate;
//   dynamic resolverName;
//   dynamic resolverUuid;
//   bool? isResolverUserArchived;
//   dynamic resolvedDate;
//   dynamic resolveComment;
//
//   Data({
//     this.id,
//     this.uuid,
//     this.ticketReason,
//     this.ticketReasonUuid,
//     this.entityId,
//     this.entityUuid,
//     this.isUserArchived,
//     this.userType,
//     this.email,
//     this.name,
//     this.contactNumber,
//     this.ticketStatus,
//     this.nextStatus,
//     this.description,
//     this.active,
//     this.createdAt,
//     this.acknowledgeComment,
//     this.acknowledgerName,
//     this.isAcknowledUserArchived,
//     this.acknowledgerUuid,
//     this.acknowledgedDate,
//     this.resolverName,
//     this.resolverUuid,
//     this.isResolverUserArchived,
//     this.resolvedDate,
//     this.resolveComment,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     uuid: json["uuid"],
//     ticketReason: json["ticketReason"],
//     ticketReasonUuid: json["ticketReasonUuid"],
//     entityId: json["entityId"],
//     entityUuid: json["entityUuid"],
//     isUserArchived: json["isUserArchived"],
//     userType: json["userType"],
//     email: json["email"],
//     name: json["name"],
//     contactNumber: json["contactNumber"],
//     ticketStatus: json["ticketStatus"],
//     nextStatus: json["nextStatus"] == null ? [] : List<String>.from(json["nextStatus"]!.map((x) => x)),
//     description: json["description"],
//     active: json["active"],
//     createdAt: json["createdAt"],
//     acknowledgeComment: json["acknowledgeComment"],
//     acknowledgerName: json["acknowledgerName"],
//     isAcknowledUserArchived: json["isAcknowledUserArchived"],
//     acknowledgerUuid: json["acknowledgerUuid"],
//     acknowledgedDate: json["acknowledgedDate"],
//     resolverName: json["resolverName"],
//     resolverUuid: json["resolverUuid"],
//     isResolverUserArchived: json["isResolverUserArchived"],
//     resolvedDate: json["resolvedDate"],
//     resolveComment: json["resolveComment"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "uuid": uuid,
//     "ticketReason": ticketReason,
//     "ticketReasonUuid": ticketReasonUuid,
//     "entityId": entityId,
//     "entityUuid": entityUuid,
//     "isUserArchived": isUserArchived,
//     "userType": userType,
//     "email": email,
//     "name": name,
//     "contactNumber": contactNumber,
//     "ticketStatus": ticketStatus,
//     "nextStatus": nextStatus == null ? [] : List<dynamic>.from(nextStatus!.map((x) => x)),
//     "description": description,
//     "active": active,
//     "createdAt": createdAt,
//     "acknowledgeComment": acknowledgeComment,
//     "acknowledgerName": acknowledgerName,
//     "isAcknowledUserArchived": isAcknowledUserArchived,
//     "acknowledgerUuid": acknowledgerUuid,
//     "acknowledgedDate": acknowledgedDate,
//     "resolverName": resolverName,
//     "resolverUuid": resolverUuid,
//     "isResolverUserArchived": isResolverUserArchived,
//     "resolvedDate": resolvedDate,
//     "resolveComment": resolveComment,
//   };
// }
