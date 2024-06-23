class ServiceRequestModel {
  final String subject;
  final String message;
  final String orderId;
  final String fromPerson;
  final String toPerson;
  final String itemType;
  final String orderStatus;
  final DateTime requestDate;
  final int trayNumber;

  const ServiceRequestModel({
    required this.trayNumber,
    required this.requestDate,
    required this.subject,
    required this.message,
    required this.orderId,
    required this.fromPerson,
    required this.toPerson,
    required this.itemType,
    required this.orderStatus,
  });
}
