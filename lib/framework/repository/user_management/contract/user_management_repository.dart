abstract class UserManagementRepository{

  ///Sub Operator Api
  Future subOperatorListApi(int pageNumber,String request);

  ///Sub Operator Dynamic Form Api
  Future subOperatorDynamicFormApi();

  ///Add Sub Operator
  Future addSubOperatorApi(String request);

  ///Edit Sub Operator
  Future editSubOperatorApi(String request);

  ///Edit Sub Operator Dynamic Form
  Future editSubOperatorDynamicFormApi();

  ///Active and Deactivate Sub Operator
  Future activeDeactivateSubOperatorApi(String uuid, bool isActive);

  ///Sub Operator Detail API
  Future subOperatorDetail(String uuid);
}