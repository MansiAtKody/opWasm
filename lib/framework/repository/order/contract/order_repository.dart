abstract class OrderRepository{

  /// Product List
  Future getProductListApi(String request);

  ///Category List
  Future categoryListApi({int? pageSize, bool? isActive});

  /// Product detail
  Future productDetailApi(String productUuid);

  /// place order
  Future placeOrderApi(String request);

  /// order list
  Future orderListApi(String request,{int? pageNumber});

  /// cancel order
  Future cancelOrderApi(String orderUuid);

  /// Update Whole order status api
  Future updateOrderStatusApi(String orderId, String status);

  /// Update Whole order item status api
  Future updateOrderItemStatusApi(String orderItemId, String status);

  /// order details
  Future orderDetailsApi(String orderUuid);

  ///Update Order Location Points
  Future changeOrderLocationPointsApi(String orderUuid, String locationPointsUuid);

  /// Refresh Socket
  Future refreshSocket(String queueName);

  /// Favourite Order
  Future favouriteOrderApi(String orderUUid,bool isFavourite);
}