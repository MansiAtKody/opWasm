// To parse this JSON data, do
//
//     final sdkErrorResponse = sdkErrorResponseFromJson(jsonString);

import 'dart:convert';

SdkErrorResponse sdkErrorResponseFromJson(String str) => SdkErrorResponse.fromJson(json.decode(str));

String sdkErrorResponseToJson(SdkErrorResponse data) => json.encode(data.toJson());

class SdkErrorResponse {
  Error? error;

  SdkErrorResponse({
    this.error,
  });

  factory SdkErrorResponse.fromJson(Map<String, dynamic> json) => SdkErrorResponse(
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error?.toJson(),
  };
}

class Error {
  String? description;
  String? key;

  Error({
    this.description,
    this.key,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    description: json["description"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "key": key,
  };
}
