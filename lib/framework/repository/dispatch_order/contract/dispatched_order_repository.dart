
abstract class DispatchedOrderRepository{


  ///get dispatched order list
  Future getDispatchedOrderList(String robotUuid);


  ///change order status
  Future changeOrderStatus(String taskUuid, String status);

}