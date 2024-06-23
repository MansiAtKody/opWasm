import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/repository/send_message/send_message_response_model.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketController = ChangeNotifierProvider(
  (ref) => getIt<SocketController>(),
);

@injectable
class SocketController extends ChangeNotifier {
  IO.Socket? socket;

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;

    if (isNotify) {
      notifyListeners();
    }
  }

  initSocket() {
    socket = IO.io(
        '$SOCKET_URL:$SOCKET_PORT?userName=${Session.getUserEmail()}',
        <String, dynamic>{
          'autoConnect': false,
          'transports': ['websocket'],
        });
  }

  Future connectSocket() async {
    socket!.connect();
    getUserData();
  }

  getUserData() {
    socket!.on('list_data', (data) {
      debugPrint('Data Received -> $data');
    });
  }

  sendMessage(String message, String userEmail) {
    SendMessageResponseModel sendMessageResponseModel =
        SendMessageResponseModel(
            data: message, toData: [userEmail, 'manav@malinator.com']);
    socket!.emit(
      'transfer_data_test',
      [
        sendMessageResponseModelToJson(sendMessageResponseModel),
      ],
    );
  }

  bool isConnectingDisconnecting = false;

  updateIsConnectingDisconnecting(bool val) {
    isConnectingDisconnecting = val;
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
