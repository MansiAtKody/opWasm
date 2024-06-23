
abstract class OrderHistoryRepository{

  /// Order List api
  Future getOrderListApi(String request,int pageNumber);

  /// Order Detail api
  Future getOrderDetailApi(String orderId);
}