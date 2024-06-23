// To parse this JSON data, do
//
//     final refreshTokenResponseModel = refreshTokenResponseModelFromJson(jsonString);

import 'dart:convert';

RefreshTokenResponseModel refreshTokenResponseModelFromJson(String str) => RefreshTokenResponseModel.fromJson(json.decode(str));

String refreshTokenResponseModelToJson(RefreshTokenResponseModel data) => json.encode(data.toJson());

class RefreshTokenResponseModel {
  String? accessToken;
  int? expiresIn;
  String? idToken;
  String? refreshToken;
  String? scope;
  String? tokenType;

  RefreshTokenResponseModel({
    this.accessToken,
    this.expiresIn,
    this.idToken,
    this.refreshToken,
    this.scope,
    this.tokenType,
  });

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) => RefreshTokenResponseModel(
    accessToken: json['access_token'],
    expiresIn: json['expires_in'],
    idToken: json['id_token'],
    refreshToken: json['refresh_token'],
    scope: json['scope'],
    tokenType: json['token_type'],
  );

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'expires_in': expiresIn,
    'id_token': idToken,
    'refresh_token': refreshToken,
    'scope': scope,
    'token_type': tokenType,
  };
}
