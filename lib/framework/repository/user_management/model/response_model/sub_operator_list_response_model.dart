// To parse this JSON data, do
//
//     final subOperatorListResponseModel = subOperatorListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';

SubOperatorListResponseModel subOperatorListResponseModelFromJson(String str) => SubOperatorListResponseModel.fromJson(json.decode(str));

String subOperatorListResponseModelToJson(SubOperatorListResponseModel data) => json.encode(data.toJson());

class SubOperatorListResponseModel {
  int? pageNumber;
  List<SubOperatorData>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  int? pageSize;
  String? message;
  int? totalCount;
  int? status;

  SubOperatorListResponseModel({
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

  factory SubOperatorListResponseModel.fromJson(Map<String, dynamic> json) => SubOperatorListResponseModel(
    pageNumber: json['pageNumber'],
    data: json['data'] == null ? [] : List<SubOperatorData>.from(json['data']!.map((x) => SubOperatorData.fromJson(x))),
    hasNextPage: json['hasNextPage'],
    totalPages: json['totalPages'],
    hasPreviousPage: json['hasPreviousPage'],
    pageSize: json['pageSize'],
    message: json['message'],
    totalCount: json['totalCount'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'pageNumber': pageNumber,
    'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    'hasNextPage': hasNextPage,
    'totalPages': totalPages,
    'hasPreviousPage': hasPreviousPage,
    'pageSize': pageSize,
    'message': message,
    'totalCount': totalCount,
    'status': status,
  };
}

