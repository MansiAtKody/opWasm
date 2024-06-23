import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/controller/robot_tray_selection/robot_tray_selection_controller.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/socket/socket_logger.dart';
import 'package:kody_operator/framework/repository/order/model/response/socket_order_response_model.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/response_model/robot_list_response_model.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/response_model/robot_status_response_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/delegate.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

@LazySingleton(env: [Env.dev, Env.uat])
class SocketManager {
  io.Socket? socket;

  String socketServerUrl;

  AudioPlayer audioPlayer = AudioPlayer();

  List<String> upcomingOrdersIds = [];

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  SocketManager(this.socketServerUrl) {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('new order', 'upcoming order',
            channelDescription: 'when new order is received',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            showWhen: true);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> stopSocket() async {
    await audioPlayer.dispose();
    socket?.disconnect();
  }

  Future<void> startSocket(WidgetRef ref) async {
    socket = io.io(
        '$socketServerUrl?userName=${Session.getUserEntityId().toString()}_${Session.getUserEntityType().toString()}_ORDER_QUEUE',
        io.OptionBuilder().setTransports(['websocket']).build());
    if (socket == socket?.connect()) {
      socket?.disconnect();
    }
    print(socket?.io.uri);
    await Future.delayed(const Duration(milliseconds: 400));
    socket?.connect();
    socket?.onConnect((data) {
      startOrderListSocket((socketData) async {
        SocketOrderResponseModel orderList =
            socketOrderResponseModelFromJson(socketData);

        /// Filtering out new orders
        bool hasNewOrders = orderList.upcomingOrders!
            .any((order) => !upcomingOrdersIds.contains(order.uuid));
        if (hasNewOrders) {
          upcomingOrdersIds =
              orderList.upcomingOrders!.map((order) => order.uuid!).toList();

          if (kIsWeb) {
            await playAudio(globalNavigatorKey.currentState!.context);

            /// Play audio if there are new orders
          } else {
            await showLocalNotification(
                'New Order', 'You have new orders in the queue.');
          }
        }

        return {
          globalRef?.read(orderStatusController).initializeOrderList(orderList, ref)
        };
      }).then((value) {
        refreshSocket();
      });
      startRobotStatusQueue((robotData) {
        print("----------------------robotDetailsData before ");

        RobotStatusResponseModel robotDetailsData =
        RobotStatusResponseModel.fromJson(jsonDecode(robotData));
        print("----------------------robotDetailsData : ");
        List<RobotListResponseData> robotListSocket = globalRef?.read(robotTraySelectionController).robotList ?? [];
        print("after stored");
        for (var robotListSocket in robotListSocket.where((element) => element.uuid == robotDetailsData.uuid)) {
          robotListSocket.state = robotDetailsData.state;
        }
        globalRef?.watch(robotTraySelectionController).updateRobotList(robotListSocket);
        //ref.watch(robotTraySelectionController).updateRobot();
      });
    });

    socket?.onConnectError((data) {
      socket?.connect();
    });
    socket?.onDisconnect((data) {});
  }

  Future<void> startOrderListSocket(
      Function(String data) onDataReceived) async {
    socket?.on('ALL_ORDER_QUEUE', (data) async {
      SocketLogger.instance.printSocketData(jsonDecode(data));
      onDataReceived.call(data.toString());
    });
  }

  Future<void> stopMusicAndPopDialog(BuildContext context) async {
    await audioPlayer.stop();
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Future<void> playAudio(BuildContext context) async {
    if (audioPlayer.state == PlayerState.playing) {
      await stopMusicAndPopDialog(context);
    }
    await audioPlayer.play(AssetSource(AppAssets.audioBuzzer));
    if (context.mounted) {
      showCommonErrorDialogWeb(
          context: context,
          message: LocalizationStrings.keyNewOrderReceived.localized,
          onCrossTap: () async {
            await stopMusicAndPopDialog(context);
          },
          onButtonTap: () async {
            await stopMusicAndPopDialog(context);
          });
    }
  }

  Future<void> startRobotStatusQueue(
      Function(String data) onDataReceived) async {
    socket?.on('robot_status', (data) async {
      onDataReceived.call(data.toString());
      print('<------------ Robot status event data -------->');
    });
  }


  Future<void> sendRobotStatus(String status,String entityId) async {
    socket?.emit('robot_status', '$entityId@$status');
  }

  Future<void> refreshSocket() async {
    Dio dio = Dio();
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'contentType': 'application/json',
      'Accept-Language': Session.getAppLanguage(),
    };

    ///Authorization Header
    String token = Session.getUserAccessToken();
    if (token.isNotEmpty) {
      headers
          .addAll({'Authorization': 'Bearer ${Session.getUserAccessToken()}'});
    }
    dio.options.headers = headers;
    // int portNumber =
    //     int.parse(socket!.io.uri.split(':').last.split('?').first) - 1;
    dio.get(
        'https://service.dasher.kodytechnolab.com/dasher${ApiEndPoints.refreshSocket('ALL_ORDER_QUEUE')}');
  }

  Future<void> sendData(Map<String, dynamic> data,
      {String? userSendTo, List<String>? userSendToList}) async {
    socket?.emit(
      'broadcast_data',
      {
        'toData': userSendToList ?? [userSendTo ?? ''],
        'data': data,
      },
    );
  }
}

@module
abstract class SocketModule {
  @LazySingleton(env: [Env.uat])
  String getUATSocket() {
    String socketServerURL = 'https://socket.dasher.kodytechnolab.com';
    return socketServerURL;
  }

  @LazySingleton(env: [Env.dev])
  String getDebugSocket() {
    String socketServerURL = 'https://socket.dasher.kodytechnolab.com';
    return socketServerURL;
  }
}
