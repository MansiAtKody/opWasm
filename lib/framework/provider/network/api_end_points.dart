import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';

class ApiEndPoints {
  /*
  * ----- Api status
  * */
  static const int apiStatus_200 = 200; //success
  static const int apiStatus_201 = 201; //success
  static const int apiStatus_202 = 202; //success for static page
  static const int apiStatus_203 = 203; //success
  static const int apiStatus_205 = 205; // for remaining step 2
  static const int apiStatus_401 = 401; //Invalid data
  static const int apiStatus_404 = 404; //Invalid data
  static const int apiStatus_500 = 500; //Invalid data

  /// Auth
  static String login = '/login/operator';
  static String forgotPassword = '/login/forgot/password';
  static String verifyOtp = '/otp/verify/app';
  static String resetPassword = '/login/reset/password';
  static String resendOtp = '/otp';
  static String deleteDeviceToken(String deviceId) =>  '/device/detail/$deviceId';


  static String deleteOperator(String uuid) => '/operator/$uuid';

  /// Check Password
  static String checkPassword = '/login/check/password';

  /// Add Sub Operator
  static String subOperatorList(int pageNumber) => '/operator/user/list?pageNumber=$pageNumber&pageSize=$pageSize';
  static String addSubOperatorForm = '/operator/add/json/form';
  static String editSubOperatorForm = '/operator/edit/json/form';
  static String addSubOperator = '/operator/user';
  static String subOperatorDetail(String uuid) => '/operator/user/$uuid';
  static String activeDeactivateSubOperator(String uuid, bool isActive) => '/operator/user/status/$uuid?active=$isActive';

  ///Operator detail
  static String profileDetail = Session.getOperatorType() == "OPERATOR_USER" ? '/operator/user' : '/operator';
  static String changePassword = '/login/update/password';
  static String uploadProfileImage(String uuid) => Session.getOperatorType() == "OPERATOR_USER" ? '/operator/user/profile/$uuid' : '/operator/profile/$uuid';

  ///Profile
  static String updateEmail = '/login/email';
  static String updateContact = '/login/contact';

  /// Help and Support
  static String ticketList(int pageNo) => '/ticket/list?pageNumber=$pageNo&pageSize=7';
  static String ticketDetails(String uuid) => '/ticket/$uuid';
  static String ticketReasonList({int? pageNo, bool? activeRecords}) => '/ticket/reason/list?platformType=OPERATOR&pageSize=$pageSize&${pageNo != null ? "pageNumber=$pageNo&" : ""}${activeRecords != null ? "activeRecords=$activeRecords&" : ""}';
  static String getTicketReasons = '/ticket/reason/list?platformType=OPERATOR';
  static String addTicket = '/ticket';

  /// CMS
  static String cms(String cmsType) => '/cms/language/type/$cmsType/platform/OPERATOR';

  /// product management
  static String categoryList({int? pageSizeInternal, bool? isActive}) => '/category/list?pageSize=${pageSizeInternal ?? pageSizeThousand}${isActive != null ? '&activeRecords=$isActive' : ''}';
  static String getProductList(int pageNo) => '/product/list/operator/show?pageNumber=$pageNo&pageSize=$pageSize';
  static String productDetail(String productUuid) => '/product/language/operator/show/$productUuid';
  static String updateProductStatus(String productUuid, bool available) => '/product/available/$productUuid?available=$available';
  static String updateProductAttributeStatus(String attributeUuid, bool available) => '/product/attribute/available/$attributeUuid?available=$available';
  static String updateProductAttributeNameStatus(String attributeNameUuid, bool available) => '/product/attribute/name/available/$attributeNameUuid?available=$available';

  ///Order Management
  static String getOrderList(int pageNumber) => '/orders/all/list?pageNumber=$pageNumber&pageSize=$pageSize';
  static String orderDetails(String orderId) => '/orders/$orderId';
  static String refreshSocket(queueName) => '/orders/refresh/socket?queueName=$queueName';
  static String getRobotDetails(String robotUuid) => '/robot/$robotUuid';
  static String dispatchOrder(String robotUuid) => '/orders/dispatch?robotUuid=$robotUuid';
  static String updateOrderStatus(String orderId, String status) => '/orders/status/$orderId?status=$status';
  static String updateOrderItemStatus(String orderItemId, String status) => '/orders/item/status/$orderItemId?status=$status';
  static String favouriteOrderStatus(String orderUuid, bool isFavourite) => '/orders/favourite/$orderUuid?isFavourite=$isFavourite';
  static String registerDevice = '/device/detail';

  /// Coffee SDK APIs
  static String selectProgramAPI = 'https://api.home-connect.com/api/homeappliances/BOSCH-CTL636EB6-68A40EA7DD54/programs/selected';
  static String activateProgramAPI = 'https://api.home-connect.com/api/homeappliances/BOSCH-CTL636EB6-68A40EA7DD54/programs/active';

  /// Robot API
  static String startVoltageAPI = 'start_voltage';
  static String startDasher = 'start_dasher';
  static String emergencyStop = 'emergency_stop';
  static String stopVoltageAPI = 'stop_voltage';

  /// robot tray selection
  static String robotList(int pageNo) => '/robot/list?activeRecords=true&pageNumber=$pageNo&pageSize=$pageSize';
  static String addItemToTray = '/tray/management';
  static String deleteItemFromTray(String uuid) => '/tray/management/$uuid';
  static String getTrayList(String robotUuid, int trayNumber) => '/tray/management/list?robotUuid=$robotUuid&trayNumber=$trayNumber';

  ///Cart
  static String cartCount = '/cart/count';
  static String cartList = '/cart/list';
  static String addCartItem = '/cart/item';
  static String updateCartQty(String productUuid, int qty) => '/cart/item/$productUuid?qty=$qty';
  static String cartDetail(String productUuid) => '/cart/$productUuid';
  static String addItemListCart = '/cart/item/list';
  static String validateItem  = '/cart/item/validate';
  static String frequentlyBoughtList =  '/product/frequently/bought/list';
  static String clearCart = '/cart/clear';


  /// Order
  static String productList = '/product/list/cart/show?pageNumber=1&pageSize=10000';
  static String placeOrder = '/orders/place';
  static String orderList(int pageNumber) =>  '/orders/list?pageSize=$pageSize&pageNumber=$pageNumber';
  static String getProductDetails(String productUuid) => '/product/language/operator/show/$productUuid';
  static String cancelOrder(String orderUuid) => '/orders/status/$orderUuid?status=CANCELED';
  static String changeOrderLocationPoints(String uuid, String locationPointsUuid) => '/orders/change/location/$uuid?locationPointsUuid=$locationPointsUuid';
  static String getLocationList(bool activeRecords, int pageNumber) => '/location/list?activeRecords=$activeRecords&pageSize=$pageSizeThousand&pageNumber=$pageNumber';
  static String getLocationPointList(bool activeRecords, int pageNumber) => '/location/points/list?pageSize=$pageSizeThousand&pageNumber=$pageNumber&activeRecords=true';

  /// Notification
  static String notificationList(int pageNumber) => '/push/notification/list?pageNumber=$pageNumber&pageSize=$pageSize';
  static String notificationListCount =  '/push/notification/count';
  static String notificationListDeleteAll =  '/push/notification';
  static String notificationListDeleteNotification(String notificationId) =>  '/push/notification/$notificationId';

  ///dispatched order
  static String changeOrderStatus(String taskUuid, String status) => '/orders/task/status/$taskUuid?status=$status';
  static String getDispatchedOrderList(String robotUuid) => '/orders/task/list?robotUuid=$robotUuid';

}
