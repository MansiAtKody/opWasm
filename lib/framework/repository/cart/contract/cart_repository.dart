abstract class CartRepository{

  ///Cart Count Api
  Future cartCountApi();

  ///Cart List Api
  Future cartListApi();

  ///Update Cart Qty
  Future updateCartQtyApi(String request,String productUuid,int qty);

  ///Cart Detail Api
  Future cartDetailApi(String productUuid);

  ///Add Cart
  Future addCartApi(String request);

  /// Add item list in cart
  Future addItemListCartApi(String request);

  ///Validate Items in cart
  Future validateItemApi(String request);

  ///Frequently bought List Api
  Future frequentlyBoughtListApi();

  /// Clear cart
  Future clearCartApi();

}