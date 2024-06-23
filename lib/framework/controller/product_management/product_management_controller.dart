import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/product_management/contract/product_management_repository.dart';
import 'package:kody_operator/framework/repository/product_management/model/product_management_model.dart';
import 'package:kody_operator/framework/repository/product_management/model/product_type_model.dart';
import 'package:kody_operator/framework/repository/product_management/model/request_model/get_product_list_request_model.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/get_category_list_response_model.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/get_product_list_response_model.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/product_detail_reponse_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

export 'package:kody_operator/framework/repository/product_management/model/product_type_model.dart';

final productManagementController = ChangeNotifierProvider(
  (ref) => getIt<ProductManagementController>(),
);

@injectable
class ProductManagementController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    categoryList = [
      GetCategoryListResponseData(name: LocalizationStrings.keyAll.localized, uuid: ''),
    ];
    productList = [];
    pageNoForGetProductList = 1;
    if (isNotify) {
      notifyListeners();
    }
  }

  ///Update Selected Product
  updateSwitchEnabled(List<SeeCustomizedItemModel> productComponentList, int singleComponentIndex) {
    for (int index = 0; index < productComponentList.length; index++) {
      if (index == singleComponentIndex) {
        productComponentList[index].isEnabled = !productComponentList[index].isEnabled;
      } else {
        // productComponentList[index].isEnabled = false;
      }
    }
    notifyListeners();
  }

  List<ProductTypeModel> productTypeTabList = [
    ProductTypeModel(name: LocalizationStrings.keyAllItems.localized, productType: ProductType.all),
    ProductTypeModel(name: LocalizationStrings.keyDrinks.localized, productType: ProductType.drinks),
    ProductTypeModel(name: LocalizationStrings.keySnacks.localized, productType: ProductType.snacks),
  ];

  List<String> productInfoTitle = [LocalizationStrings.keyProductName.localized, LocalizationStrings.keyCategories.localized, LocalizationStrings.keyProductStatus.localized, LocalizationStrings.keyActiveInactive.localized];

  List<GetCategoryListResponseData> categoryList = [];

  /// Product Type Tab Selected Index
  GetCategoryListResponseData? selectedCategory = GetCategoryListResponseData(name: LocalizationStrings.keyAll.localized, uuid: '');

  Future<void> updateSelectedCategory(BuildContext context, GetCategoryListResponseData? selectedCategory) async {
    this.selectedCategory = selectedCategory;
    await getProductListApi(context, pageNumber: 1, isWeb: true);
    notifyListeners();
  }

  /*/// Update Switch with index
  void updateSwitch({required GetProductListResponseData productModel}) {
    if (productModel.isSwitchOn == false) {
      productModel.isSwitchOn = true;
    } else {
      productModel.isSwitchOn = false;
    }
    notifyListeners();
  }*/

  /// Update Expand Widget With index
  void updateExpandWidget({required GetProductListResponseData productModel}) {
    if (productModel.isExpanded == false) {
      productModel.isExpanded = true;
    } else {
      productModel.isExpanded = false;
    }
    notifyListeners();
  }

  /// Component Type List
  List<String> componentType = [
    'Quantity of Milk',
    'Dairy',
    'Sugar',
  ];

  /// Common All Product List
  List<GetProductListResponseData> productList = [];

  /// Get Product Status text, color, Product Status based on Product Status status
  ProductStatusStyle getOrderStatusTextColor(ProductStatusEnum dasherStatusEnum) {
    ProductStatusStyle dasherStyle;
    switch (dasherStatusEnum) {
      case ProductStatusEnum.available:
        {
          dasherStyle = ProductStatusStyle(
            productStatus: productStatusValues.reverse[ProductStatusEnum.available].toString(),
            productStatusTextColor: AppColors.green35C658,
          );
        }
        break;
      case ProductStatusEnum.unAvailable:
        {
          dasherStyle = ProductStatusStyle(
            productStatus: productStatusValues.reverse[ProductStatusEnum.unAvailable].toString(),
            productStatusTextColor: AppColors.redFF3D00,
          );
        }
        break;
    }
    return dasherStyle;
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  String? selectedProductUuid;
  String? selectedProductAttributeUuid;
  String? selectedProductAttributeNameUuid;

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ProductManagementRepository productManagementRepository;

  ProductManagementController(this.productManagementRepository);

  int pageNoForGetProductList = 1;
  var getCategoryListState = UIState<GetCategoryListResponseModel>();
  var getProductListState = UIState<GetProductListResponseModel>();
  var productDetailState = UIState<ProductDetailResponseModel>();
  var updateProductStatusState = UIState<CommonResponseModel>();
  var updateProductAttributeStatusState = UIState<CommonResponseModel>();
  var updateProductAttributeNameStatusState = UIState<CommonResponseModel>();

  /// get Category List API
  Future<void> getCategoryListApi(BuildContext context) async {
    getCategoryListState.isLoading = true;
    getCategoryListState.success = null;
    notifyListeners();

    final result = await productManagementRepository.getCategoryListApi();

    result.when(success: (data) async {
      getCategoryListState.success = data;
      categoryList.addAll(getCategoryListState.success?.data ?? []);
      selectedCategory = categoryList.where((element) => element.name == LocalizationStrings.keyAll.localized).firstOrNull;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    getCategoryListState.isLoading = false;
    notifyListeners();
  }

  /// get Product List API
  Future<void> getProductListApi(BuildContext context, {int pageNumber = 1, required bool isWeb}) async {
    if (isWeb) {
      getProductListState.isLoading = true;
      productList = [];
    } else {
      /// increase page number
      if (getProductListState.success?.hasNextPage ?? false) {
        pageNoForGetProductList += 1;
      }

      /// set loading status and clear product list
      if (pageNoForGetProductList == 1) {
        productList = [];
        getProductListState.isLoading = true;
      } else {
        getProductListState.isLoadMore = true;
      }
    }
    getProductListState.success = null;
    notifyListeners();

    GetProductListRequestModel requestModel = GetProductListRequestModel(active: '', categoryUuid: selectedCategory?.uuid, searchKeyWord: '', subCategoryUuid: '');
    String request = getProductListRequestModelToJson(requestModel);

    final result = await productManagementRepository.getProductListApi(request, isWeb ? pageNumber : pageNoForGetProductList);

    result.when(success: (data) async {
      getProductListState.success = data;
      for (GetProductListResponseData product in getProductListState.success?.data ?? []) {
        productList.add(product);
      }
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    getProductListState.isLoading = false;
    getProductListState.isLoadMore = false;
    notifyListeners();
  }

  ///Product Index;
  int? updatingProductIndex;

  /// Product Detail API
  Future<void> productDetailApi(BuildContext context, String productUuid) async {
    productDetailState.isLoading = true;
    productDetailState.success = null;
    updatingProductIndex = productList.indexWhere((element) => element.uuid == productUuid);
    notifyListeners();

    final result = await productManagementRepository.productDetailApi(productUuid);

    result.when(success: (data) async {
      productDetailState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    productDetailState.isLoading = false;
    notifyListeners();
  }

  /// update Product status API
  Future<void> updateProductStatusApi(BuildContext context, {required String productUuid, required bool isAvailable}) async {
    selectedProductUuid = productUuid;
    updateProductStatusState.isLoading = true;
    updateProductStatusState.success = null;
    updatingProductIndex = getProductListState.success?.data?.indexWhere((element) => element.uuid == productUuid);
    notifyListeners();

    final result = await productManagementRepository.updateProductStatusApi(productUuid, isAvailable);

    result.when(success: (data) async {
      updateProductStatusState.isLoading = false;
      updateProductStatusState.success = data;
      getProductListState.success?.data?.where((element) => element.uuid == productUuid).firstOrNull?.isAvailable = isAvailable;
      notifyListeners();
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    updateProductStatusState.isLoading = false;
    notifyListeners();
  }

  /// update Product Attribute status API
  Future<void> updateProductAttributeStatusApi(BuildContext context, {required String attributeUuid, required bool active, required productUuid}) async {
    selectedProductAttributeUuid = attributeUuid;
    updateProductAttributeStatusState.isLoading = true;
    updateProductAttributeStatusState.success = null;
    updatingProductAttributeIndex = productDetailState.success?.data?.productAttributes?.indexWhere((attribute) => attribute.uuid == attributeUuid);
    notifyListeners();

    final result = await productManagementRepository.updateProductAttributeStatusApi(attributeUuid, active);

    result.when(success: (data) async {
      updateProductAttributeStatusState.success = data;
      if (updateProductAttributeStatusState.success?.status == ApiEndPoints.apiStatus_200) {
        productDetailState.success?.data?.productAttributes?.where((attribute) => attribute.uuid == attributeUuid).firstOrNull?.isAvailable = active;
        if (active == false) {
          productDetailState.success?.data?.productAttributes?.where((attribute) => attribute.uuid == attributeUuid).firstOrNull?.productAttributeNames?.forEach((element) {
            element.isAvailable = false;
          });
        }
      }
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    updateProductAttributeStatusState.isLoading = false;
    notifyListeners();
  }

  int? updatingProductAttributeNameIndex;
  int? updatingProductAttributeIndex;

  /// update Product Attribute Name status API
  Future<void> updateProductAttributeNameStatusApi(BuildContext context, {required String attributeNameUuid, required String attributeUuid, required bool active, required String productUuid,required isWeb}) async {
    updateProductAttributeNameStatusState.isLoading = true;
    updateProductAttributeNameStatusState.success = null;
    updatingProductAttributeIndex = productDetailState.success?.data?.productAttributes?.indexWhere((attribute) => attribute.uuid == attributeUuid);
    updatingProductAttributeNameIndex =
        productDetailState.success?.data?.productAttributes?.where((attribute) => attribute.uuid == attributeUuid).firstOrNull?.productAttributeNames?.indexWhere((attributeName) => attributeName.uuid == attributeNameUuid);
    notifyListeners();

    final result = await productManagementRepository.updateProductAttributeNameStatusApi(attributeNameUuid, active);

    result.when(
      success: (data) async {
        updateProductAttributeNameStatusState.success = data;
        if (updateProductAttributeNameStatusState.success?.status == ApiEndPoints.apiStatus_200) {
          productDetailState.success?.data?.productAttributes?.where((attribute) => attribute.uuid == attributeUuid).firstOrNull?.productAttributeNames?.where((attributeName) => attributeName.uuid == attributeNameUuid).firstOrNull?.isAvailable = active;
          if (productDetailState.success?.data?.productAttributes?.where((attribute) => attribute.uuid == attributeUuid).firstOrNull?.productAttributeNames?.where((attributeName) => attributeName.isAvailable == true).isEmpty ?? false) {
            productDetailState.success?.data?.productAttributes?.where((attribute) => attribute.uuid == attributeUuid).firstOrNull?.isAvailable = false;
             await productDetailApi(context, productUuid).then((value) {
               if(productDetailState.success?.data?.isAvailable ==false){
                 getProductListApi(context, pageNumber: 1, isWeb: false);
               }
             });
          }
        }
      },
      failure: (NetworkExceptions error) {
        String errorMsg = NetworkExceptions.getErrorMessage(error);
        showCommonErrorDialog(context: context, message: errorMsg);
      },
    );

    updateProductAttributeNameStatusState.isLoading = false;
    notifyListeners();
  }
}
