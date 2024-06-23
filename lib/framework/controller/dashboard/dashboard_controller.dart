import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/controller/socket/socket_controller.dart';
import 'package:kody_operator/framework/repository/dashboard/tray_model.dart';
import 'package:kody_operator/framework/repository/order_management/model/order_details_response_model.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';


final dashboardController = ChangeNotifierProvider(
      (ref) => getIt<DashboardController>(),
);

@injectable
class DashboardController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    selectedTray = null;
    trayList = [
      TrayModel(trayId: '0'),
      TrayModel(trayId: '1'),
      TrayModel(trayId: '2')
    ];
    if (isNotify) {
      notifyListeners();
    }
  }

  int? selectedTray;

  updateSelectedTray(int tray) {
    if (trayList[tray].orderDetails == null) {
      selectedTray = tray;
    }
    notifyListeners();
  }

  updateOrders(SocketController socketWatch) {
    socketWatch.socket!.on('transfer_data_test', (data) {
      if (data != null) {
        OrderDetailsResponseModel order = OrderDetailsResponseModel.fromJson(
            jsonDecode(jsonDecode(data)['data']));
        orderList.add(order);
        notifyListeners();
      }
    });
  }

  List<TrayModel> trayList = [
    TrayModel(trayId: '0'),
    TrayModel(trayId: '1'),
    TrayModel(trayId: '2')
  ];

  updateTrayOrderDetails(int index) {
    int emptyTrayIndex =
    trayList.indexWhere((element) => element.orderDetails == null);
    if (emptyTrayIndex != -1) {
      if (selectedTray != null) {
        trayList[selectedTray!].orderDetails = orderList[index];
      } else {
        trayList[emptyTrayIndex].orderDetails = orderList[index];
      }
      selectedTray = null;
    } else {
    }
    notifyListeners();
  }

  removeOrderFromTray(int index) {
    trayList[index].orderDetails = null;
    notifyListeners();
  }

  checkIfOrderInTray(OrderDetailsResponseModel order) {
    bool inTray = false;
    for (var element in trayList) {
      if (element.orderDetails == order) {
        inTray = true;
      }
    }
    return inTray;
  }

  List<OrderDetailsResponseModel> orderList = [];

  onListReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final TrayModel tray = trayList.removeAt(oldIndex);
    trayList.insert(newIndex, tray);
    notifyListeners();
  }

  sendChitti(SocketController socketWatch) {
    OrderDetailsResponseModel? order = trayList[0].orderDetails;
    if (order != null) {
      String pointName;
      if (order.userRole == 'CEO') {
        pointName = 'Manav_sir';
      } else {
        pointName = 'product_point';
      }
      // String message =
      //     '${order.userName} ordered ${order.userOrder} with ${order.userOrderDescription}';
      Map<String, dynamic> jsonMap =
      ({'message': order.userOrderDescription, 'point_name': pointName});

      socketWatch.sendMessage(jsonEncode(jsonMap), CHITTI_EMAIL);
    }
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
