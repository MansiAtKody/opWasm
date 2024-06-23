
abstract class ProductManagementRepository{

  Future getCategoryListApi();

  Future getProductListApi(String request, int pageNo);

  Future updateProductStatusApi(String productUuid, bool active);

  /// Update Product Attribute Status Api
  Future updateProductAttributeStatusApi(String attributeUuid, bool active);

  /// Update Product Attribute Name Status Api
  Future updateProductAttributeNameStatusApi(String attributeNameUuid, bool active);

  /// Product Detail Api
  Future productDetailApi(String productUuid);
}