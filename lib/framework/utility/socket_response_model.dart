// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromJson(jsonString);

import 'dart:convert';

OrderResponseModel orderResponseModelFromJson(String str) => OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) => json.encode(data.toJson());

class OrderResponseModel {
  List<String>? toData;
  Data? data;

  OrderResponseModel({
    this.toData,
    this.data,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) => OrderResponseModel(
    toData: json['toData'] == null ? [] : List<String>.from(json['toData']!.map((x) => x)),
    data: json['data'] == null ? null : Data.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'toData': toData == null ? [] : List<dynamic>.from(toData!.map((x) => x)),
    'data': data?.toJson(),
  };
}

class Data {
  String? entityUuid;
  String? entityType;
  int? totalPrice;
  UserData? userData;
  LocationPoint? locationPoint;
  List<CartDtoList>? cartDtoList;

  Data({
    this.entityUuid,
    this.entityType,
    this.totalPrice,
    this.userData,
    this.locationPoint,
    this.cartDtoList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    entityUuid: json['entityUuid'],
    entityType: json['entityType'],
    totalPrice: json['totalPrice'],
    userData: json['userData'] == null ? null : UserData.fromJson(json['userData']),
    locationPoint: json['locationPoint'] == null ? null : LocationPoint.fromJson(json['locationPoint']),
    cartDtoList: json['cartDTOList'] == null ? [] : List<CartDtoList>.from(json['cartDTOList']!.map((x) => CartDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'entityUuid': entityUuid,
    'entityType': entityType,
    'totalPrice': totalPrice,
    'userData': userData?.toJson(),
    'locationPoint': locationPoint?.toJson(),
    'cartDTOList': cartDtoList == null ? [] : List<dynamic>.from(cartDtoList!.map((x) => x.toJson())),
  };
}

class CartDtoList {
  String? uuid;
  String? productUuid;
  String? productName;
  String? productImage;
  int? qty;
  List<CartAttributeDtoList>? cartAttributeDtoList;

  CartDtoList({
    this.uuid,
    this.productUuid,
    this.productName,
    this.productImage,
    this.qty,
    this.cartAttributeDtoList,
  });

  factory CartDtoList.fromJson(Map<String, dynamic> json) => CartDtoList(
    uuid: json['uuid'],
    productUuid: json['productUuid'],
    productName: json['productName'],
    productImage: json['productImage'],
    qty: json['qty'],
    cartAttributeDtoList: json['cartAttributeDTOList'] == null ? [] : List<CartAttributeDtoList>.from(json['cartAttributeDTOList']!.map((x) => CartAttributeDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'productUuid': productUuid,
    'productName': productName,
    'productImage': productImage,
    'qty': qty,
    'cartAttributeDTOList': cartAttributeDtoList == null ? [] : List<dynamic>.from(cartAttributeDtoList!.map((x) => x.toJson())),
  };
}

class CartAttributeDtoList {
  String? uuid;
  String? attributeUuid;
  String? attributeValue;
  String? attributeNameUuid;
  String? attributeNameValue;
  String? attributeNameImage;

  CartAttributeDtoList({
    this.uuid,
    this.attributeUuid,
    this.attributeValue,
    this.attributeNameUuid,
    this.attributeNameValue,
    this.attributeNameImage,
  });

  factory CartAttributeDtoList.fromJson(Map<String, dynamic> json) => CartAttributeDtoList(
    uuid: json['uuid'],
    attributeUuid: json['attributeUuid'],
    attributeValue: json['attributeValue'],
    attributeNameUuid: json['attributeNameUuid'],
    attributeNameValue: json['attributeNameValue'],
    attributeNameImage: json['attributeNameImage'],
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'attributeUuid': attributeUuid,
    'attributeValue': attributeValue,
    'attributeNameUuid': attributeNameUuid,
    'attributeNameValue': attributeNameValue,
    'attributeNameImage': attributeNameImage,
  };
}

class LocationPoint {
  String? uuid;
  String? name;
  double? xaPoint;
  double? yaPoint;
  double? tethaPoint;
  String? fieldValue;
  String? locationUuid;
  String? locationName;
  bool? active;
  bool? isDefault;

  LocationPoint({
    this.uuid,
    this.name,
    this.xaPoint,
    this.yaPoint,
    this.tethaPoint,
    this.fieldValue,
    this.locationUuid,
    this.locationName,
    this.active,
    this.isDefault,
  });

  factory LocationPoint.fromJson(Map<String, dynamic> json) => LocationPoint(
    uuid: json['uuid'],
    name: json['name'],
    xaPoint: json['xaPoint']?.toDouble(),
    yaPoint: json['yaPoint']?.toDouble(),
    tethaPoint: json['tethaPoint']?.toDouble(),
    fieldValue: json['fieldValue'],
    locationUuid: json['locationUuid'],
    locationName: json['locationName'],
    active: json['active'],
    isDefault: json['isDefault'],
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'name': name,
    'xaPoint': xaPoint,
    'yaPoint': yaPoint,
    'tethaPoint': tethaPoint,
    'fieldValue': fieldValue,
    'locationUuid': locationUuid,
    'locationName': locationName,
    'active': active,
    'isDefault': isDefault,
  };
}

class UserData {
  int? id;
  String? uuid;
  String? name;
  String? email;
  String? contactNumber;
  String? locationUuid;
  String? locationName;
  String? employeeCode;
  dynamic password;
  bool? isSelfSignup;
  String? registeredVia;
  String? userUuid;
  dynamic profileImageUrl;
  bool? isArchive;
  dynamic locationPointsDto;
  int? birthDate;
  String? status;

  UserData({
    this.id,
    this.uuid,
    this.name,
    this.email,
    this.contactNumber,
    this.locationUuid,
    this.locationName,
    this.employeeCode,
    this.password,
    this.isSelfSignup,
    this.registeredVia,
    this.userUuid,
    this.profileImageUrl,
    this.isArchive,
    this.locationPointsDto,
    this.birthDate,
    this.status,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json['id'],
    uuid: json['uuid'],
    name: json['name'],
    email: json['email'],
    contactNumber: json['contactNumber'],
    locationUuid: json['locationUuid'],
    locationName: json['locationName'],
    employeeCode: json['employeeCode'],
    password: json['password'],
    isSelfSignup: json['isSelfSignup'],
    registeredVia: json['registeredVia'],
    userUuid: json['userUuid'],
    profileImageUrl: json['profileImageUrl'],
    isArchive: json['isArchive'],
    locationPointsDto: json['locationPointsDTO'],
    birthDate: json['birthDate'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uuid': uuid,
    'name': name,
    'email': email,
    'contactNumber': contactNumber,
    'locationUuid': locationUuid,
    'locationName': locationName,
    'employeeCode': employeeCode,
    'password': password,
    'isSelfSignup': isSelfSignup,
    'registeredVia': registeredVia,
    'userUuid': userUuid,
    'profileImageUrl': profileImageUrl,
    'isArchive': isArchive,
    'locationPointsDTO': locationPointsDto,
    'birthDate': birthDate,
    'status': status,
  };
}
