import 'package:flutter/material.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';

/// Robot Tray Status Model
class RobotTrayStatusModel {
  String? robotName;
  int? robotEntityId;
  String? robotEntityType;
  String? robotId;
  RobotAssigned? assigned;
  RobotTrayStatusEnum? status;
  List<RobotTrayModel>? robotTrayList = [];

  RobotTrayStatusModel({
    this.status,
    this.robotEntityId,
    this.robotEntityType,
    this.robotName,
    this.robotId,
    this.assigned,
    this.robotTrayList,
  });
}

/// Robot Tray Items Model
class RobotTrayModel {
  final int trayId;
  final String? trayName;
  SocketOrders? trayItem;

  RobotTrayModel({required this.trayId, this.trayItem, this.trayName});
}

/// Dasher Status Style
class RobotTrayStatusStyle {
  String robotTrayStatus;
  Color robotTrayStatusTextColor;

  RobotTrayStatusStyle({
    required this.robotTrayStatus,
    required this.robotTrayStatusTextColor,
  });
}
