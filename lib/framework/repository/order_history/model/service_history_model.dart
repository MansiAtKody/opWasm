class ServiceHistoryModel {
  /// Order detail info
  final String serviceId;
  final String type;
  final String department;
  final String date;
  final String name;
  final String status;



  bool isCancel = true;


  ServiceHistoryModel({
    required this.serviceId,
    required this.type,
    required this.department,
    required this.date,
    required this.name,
    required this.status,
  });
}
