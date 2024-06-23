
abstract class NotificationRepository{

  /// API for the notification list
  Future notificationListAPI(int pageNumber);

  /// API for the notification count
  Future notificationListCountAPI();

  ///  API for Delete the notification list
  Future deleteNotificationList();

  ///  API for Delete a notification
  Future deleteNotification(String notificationId);
}