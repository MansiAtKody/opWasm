import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/repository/service/service_request_model.dart';

final serviceListController = ChangeNotifierProvider(
  (ref) => getIt<ServiceListController>(),
);

@injectable
class ServiceListController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    serviceProfiles = [
      ProfileModel(
        id: 0,
        name: 'Amaan',
        department: 'department',
        requests: [
          ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),ServiceRequestModel(
            trayNumber: 0,
            requestDate: DateTime.now(),
            subject: 'subject',
            message: 'message',
            orderId: 'orderId',
            fromPerson: 'fromPerson',
            toPerson: 'toPerson',
            itemType: 'itemType',
            orderStatus: 'orderStatus',
          ),
        ],
      ),
    ];
    selectedProfile = serviceProfiles[0];
    // selectedProfile = null;
    if (isNotify) {
      notifyListeners();
    }
  }

  List<ProfileModel> serviceProfiles = [];
  ProfileModel? selectedProfile;

  updateSelectedProfile(ProfileModel selectedProfile) {
    this.selectedProfile = selectedProfile;
    notifyListeners();
  }

  void addRequest(ServiceRequestModel request) {
    if (selectedProfile?.requests != null) {
      selectedProfile?.requests?.insert(0, request);
    } else {
      selectedProfile?.requests = [request];
    }
    notifyListeners();
  }

  ///Add profile to list after search
  void addProfileToList(ProfileModel profileModel) {
    serviceProfiles.removeWhere((element) => element.requests == null || (element.requests?.isEmpty ?? true));
    int index = serviceProfiles.indexWhere((element) => element.id == profileModel.id);
    if (index == -1) {
      serviceProfiles.insert(0, profileModel);
    } else {
      ProfileModel profileModelBackup = serviceProfiles[index];
      serviceProfiles.removeAt(index);
      serviceProfiles.insert(0, profileModelBackup);
    }
    selectedProfile = serviceProfiles[0];
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
