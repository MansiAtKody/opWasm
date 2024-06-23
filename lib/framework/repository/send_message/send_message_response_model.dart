// To parse this JSON data, do
//
//     final sendMessageResponseModel = sendMessageResponseModelFromJson(jsonString);

import 'dart:convert';

SendMessageResponseModel sendMessageResponseModelFromJson(String str) =>
    SendMessageResponseModel.fromJson(json.decode(str));

String sendMessageResponseModelToJson(SendMessageResponseModel data) =>
    json.encode(data.toJson());

class SendMessageResponseModel {
  String data;
  List<String> toData;

  SendMessageResponseModel({
    required this.data,
    required this.toData,
  });

  factory SendMessageResponseModel.fromJson(Map<String, dynamic> json) =>
      SendMessageResponseModel(
        data: json["data"],
        toData: List<String>.from(json["toData"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "toData": List<dynamic>.from(toData.map((x) => x)),
      };
}

main() {
  List<Map<String, dynamic>> jsonMap = [
    {
      'user_data': {
        'userName': 'Name',
        'additional_details': 'Test data',
      },
      'point_name': 'point_name',
    },
    {
      'user_data': {
        'userName': 'Name',
        'additional_details': 'Test data',
      },
      'point_name': 'point_name',
    },
    {
      'user_data': {
        'userName': 'Name',
        'additional_details': 'Test data',
      },
      'point_name': 'point_name',
    },
    {
      'user_data': null,
      'point_name': 'production',
    }
  ];

  print(jsonEncode(jsonMap));
}
