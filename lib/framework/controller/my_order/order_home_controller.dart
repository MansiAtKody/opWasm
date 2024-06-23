import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/order/contract/order_repository.dart';
import 'package:kody_operator/framework/repository/order/model/request/product_list_request_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/category_list_response_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/product_list_reponse_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final orderHomeController = ChangeNotifierProvider(
  (ref) => getIt<OrderHomeController>(),
);

@injectable
class OrderHomeController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    productType = ProductType.all;
    additionalNoteController.text = '';
    if (isNotify) {
      notifyListeners();
    }
  }

  ///Product type to filter type of orders (All By Default)
  ProductType productType = ProductType.all;

  ///Change Product Type
  void changeProductType(ProductType productType) {
    this.productType = productType;
    notifyListeners();
  }

  TextEditingController additionalNoteController = TextEditingController();

  ///To check if all fields are valid or not
  bool isAllFieldsValid = false;

  ///Check Validity of Password
  void checkIfAllFieldsValid() {
    isAllFieldsValid = (validateText(additionalNoteController.text, LocalizationStrings.keyAdditionalNoteMsg.localized) == null);
    notifyListeners();
  }

  ///SVG List for order Filter buttons
  final List<String> orderFilterSvg = [
    AppAssets.svgProductTypeAll,
    AppAssets.svgProductTypeSnacks,
    AppAssets.svgProductTypeDrinks,
  ];

  ///String List for order Filter buttons
  final List<String> orderFilterString = [
    LocalizationStrings.keyAllItems.localized,
    LocalizationStrings.keySnacks.localized,
    LocalizationStrings.keyDrinks.localized,
  ];

  ///Product Type list for order Filter Buttons
  final Set<ProductType> orderFilterType = {
    ProductType.all,
    ProductType.snacks,
    ProductType.drinks,
  };

  bool isShowOrderStatusWidget = false;

  getIsShowingOrderStatusWidget() => isShowOrderStatusWidget;

  updateIsShowOrderStatusWidget(bool isShow) {
    isShowOrderStatusWidget = isShow;
    notifyListeners();
  }

  CategoryData? selectedCategory;

  Future<void> updateSelectedCategory({CategoryData? selectedCategory, required BuildContext context}) async {
    this.selectedCategory = selectedCategory;
    notifyListeners();
    await productListApi(context, categoryUuid: selectedCategory?.uuid ?? '');

    // if (this.selectedCategory?.category == Category.all) {
    //   displayItemList = itemList;
    // } else {
    //   displayItemList = itemList.where((element) => element.category == this.selectedCategory?.category).toList();
    // }
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */
  OrderRepository orderRepository;

  OrderHomeController(this.orderRepository);

  var productListState = UIState<ProductListResponseModel>();

  /// Product List API
  Future<void> productListApi(BuildContext context, {String? categoryUuid}) async {
    productListState.isLoading = true;
    productListState.success = null;
    notifyListeners();

    ProductListRequestModel requestModel = ProductListRequestModel(categoryUuid: categoryUuid ?? '', subCategoryUuid: '', active: 'true', searchKeyWord: '');
    String request = productListRequestModelToJson(requestModel);

    final result = await orderRepository.getProductListApi(request);

    result.when(success: (data) async {
      productListState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    productListState.isLoading = false;
    notifyListeners();
  }

  UIState<CategoryListResponseModel> categoryListState = UIState<CategoryListResponseModel>();

  Future<void> changeSelectedCategoryIndex(CategoryData? selectedCategory) async {
    this.selectedCategory = selectedCategory;
    notifyListeners();
  }

  ///Category list API
  Future<void> categoryListApi(BuildContext context, {int pageNumber = 1}) async {
    categoryListState.isLoading = true;
    notifyListeners();
    final result = await orderRepository.categoryListApi(isActive: true);
    result.when(success: (data) async {
      categoryListState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    categoryListState.isLoading = false;
    notifyListeners();
  }
}
