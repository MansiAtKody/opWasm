// To parse this JSON data, do
//
//     final notificationListCountResponseModel = notificationListCountResponseModelFromJson(jsonString);

import 'dart:convert';

NotificationListCountResponseModel notificationListCountResponseModelFromJson(String str) => NotificationListCountResponseModel.fromJson(json.decode(str));

String notificationListCountResponseModelToJson(NotificationListCountResponseModel data) => json.encode(data.toJson());

class NotificationListCountResponseModel {
  String? message;
  int? data;
  int? status;

  NotificationListCountResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory NotificationListCountResponseModel.fromJson(Map<String, dynamic> json) => NotificationListCountResponseModel(
    message: json['message'],
    data: json['data'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data,
    'status': status,
  };
}
