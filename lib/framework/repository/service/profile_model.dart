
import 'package:kody_operator/framework/repository/service/service_request_model.dart';

class ProfileModel {
  final int id;
  final String imageUrl;
  final String name;
  final String department;
  List<ServiceRequestModel>? requests = [];

  ProfileModel({
    required this.id,
    this.imageUrl = 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
    required this.name,
    required this.department,
    this.requests,
  });

  void addRequest(ServiceRequestModel model) {
    requests?.add(model);
  }
}
