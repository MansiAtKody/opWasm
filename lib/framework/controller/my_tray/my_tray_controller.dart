import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/controller/my_tray/additional_note_controller.dart';
import 'package:kody_operator/framework/controller/my_tray/order_customization_controller.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/cart/contract/cart_repository.dart';
import 'package:kody_operator/framework/repository/cart/model/request_model/add_cart_request_model.dart';
import 'package:kody_operator/framework/repository/cart/model/request_model/add_item_list_cart_request_model.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_count_response_model.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_detail_reponse_model.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_list_response_model.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/frequenlty_bought_list_response_model.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/validate_item_response_model.dart';
import 'package:kody_operator/framework/repository/order/contract/order_repository.dart';
import 'package:kody_operator/framework/repository/order/model/request/place_order_request_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_details_response_model.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/location/select_location_dialog_controller.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final myTrayController = ChangeNotifierProvider(
  (ref) => getIt<MyTrayController>(),
);

@injectable
class MyTrayController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    markAsFavourite = false;
    forCartDetailproductUDID = '';
    if (isNotify) {
      notifyListeners();
    }
  }

  String forCartDetailproductUDID = '';
  String productUDID = '';

  // String  = '';
  String selectedProductUuid = '';

  Future<void> updateProductUDID(String udid, String id) async {
    forCartDetailproductUDID = udid;
    productUDID = id;
    notifyListeners();
  }

  List<TrayModel> myTrayList = [
    TrayModel(
        name: 'Cappuccino Coffee',
        des: 'Espresso, steamed milk, and milk foam.',
        qty: 2),
    TrayModel(
        name: 'Cappuccino Coffee',
        des: 'Espresso, steamed milk, and milk foam.',
        qty: 3),
    TrayModel(
        name: 'Cappuccino Coffee',
        des: 'Espresso, steamed milk, and milk foam.',
        qty: 5),
  ];

  void addModel(TrayModel tray) {
    myTrayList.add(tray);
    notifyListeners();
  }

  TrayModel myTray = TrayModel(
      name: 'Cappuccino Coffee',
      des: 'Espresso, steamed milk, and milk foam.',
      qty: 1);

  // void removeItemFromTrayList(CartDtoList model) {
  //   myTrayList.remove(model);
  //   notifyListeners();
  // }

  void incrementQty(CartDtoList model) {
    model.qty = model.qty! + 1;
    notifyListeners();
  }

  void decrementQty(CartDtoList model) {
    if (model.qty! > 0) {
      model.qty = model.qty! - 1;
    }
    notifyListeners();
  }

  bool isExpandItemAddedBottomSheet = false;

  ///add order to favorite
  bool markAsFavourite = false;

  void updateRememberMe(bool rememberMe) {
    markAsFavourite = rememberMe;
    notifyListeners();
  }

  void updateIsExpandItemAddedBottomSheet() {
    isExpandItemAddedBottomSheet = !isExpandItemAddedBottomSheet;
    notifyListeners();
  }

  void updateFavItem(TrayModel trayModel) {
    trayModel.isFav = !trayModel.isFav!;
    notifyListeners();
  }

  bool isMarkToAddYourFavCombo = false;

  void updateMarkToAddYourFavCombo() {
    isMarkToAddYourFavCombo = !isMarkToAddYourFavCombo;
    notifyListeners();
  }

  String additionalNoteText = '';

  void updateAdditionalNoteText(String note) {
    additionalNoteText = note;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  CartRepository cartRepository;
  OrderRepository orderRepository;

  MyTrayController(this.cartRepository, this.orderRepository);

  var cartCountState = UIState<CartCountResponseModel>();

  clearCart() {
    cartListState.success = null;
    notifyListeners();
  }

  /// Cart Count API
  Future<void> cartCountApi(BuildContext context) async {
    cartCountState.isLoading = true;
    cartCountState.success = null;
    notifyListeners();

    final result = await cartRepository.cartCountApi();

    result.when(success: (data) async {
      cartCountState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    cartCountState.isLoading = false;
    notifyListeners();
  }

  var cartListState = UIState<CartListResponseModel>();

  /// Cart List API
  Future<void> cartListApi(BuildContext context) async {
    cartListState.isLoading = true;
    cartListState.success = null;
    notifyListeners();

    final result = await cartRepository.cartListApi();

    result.when(success: (data) async {
      cartListState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    cartListState.isLoading = false;
    notifyListeners();
  }

  var cartDetailState = UIState<CartDetailResponseModel>();

  /// Cart Detail API
  Future<void> cartDetailApi(BuildContext context,
      {String? webSideUDID}) async {
    cartDetailState.isLoading = true;
    cartDetailState.success = null;
    notifyListeners();

    final result = await cartRepository
        .cartDetailApi(kIsWeb ? webSideUDID ?? '' : forCartDetailproductUDID);

    result.when(success: (data) async {
      cartDetailState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    cartDetailState.isLoading = false;
    notifyListeners();
  }

  var updateCartQtyState = UIState<CommonResponseModel>();

  /// Update Cart Qty
  Future<void> updateCartQtyApi(
      BuildContext context, String productUuid, int qty) async {
    updateCartQtyState.isLoading = true;
    updateCartQtyState.success = null;
    selectedProductUuid = productUuid;
    notifyListeners();

    final result = await cartRepository.updateCartQtyApi('', productUuid, qty);

    result.when(success: (data) async {
      updateCartQtyState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    updateCartQtyState.isLoading = false;
    notifyListeners();
  }

  var addCartState = UIState<CommonResponseModel>();

  /// Add Cart Qty
  Future<void> addCartApi(BuildContext context, String productUuid, int qty,
      List<CartAttributeDataDtoList> selectedAttributeList,
      {String? uuid, bool? isFromEdit}) async {
    addCartState.isLoading = true;
    addCartState.success = null;
    notifyListeners();

    AddCartRequestModel requestModel =
        addCartValue(productUuid, qty, selectedAttributeList, uuid, isFromEdit);
    String request = addCartRequestModelToJson(requestModel);

    final result = await cartRepository.addCartApi(request);

    result.when(success: (data) async {
      addCartState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    addCartState.isLoading = false;
    notifyListeners();
  }

  addCartValue(
      String productUuid,
      int qty,
      List<CartAttributeDataDtoList> selectedAttributeList,
      String? uuid,
      bool? isFromEdit) {
    AddCartRequestModel requestModel = AddCartRequestModel();
    requestModel.cartAttributeDtoList = [];
    requestModel.productUuid = productUuid;
    requestModel.qty = qty;
    if (isFromEdit == true) {
      requestModel.uuid = uuid ?? '';
    }
    for (var element in selectedAttributeList) {
      requestModel.cartAttributeDtoList?.add(CartAttributeDtoListData(
          attributeNameUuid: element.attributeNameUuid,
          attributeUuid: element.attributeUuid));
    }
    return requestModel;
  }

  var validateItemState = UIState<ValidateItemResponseModel>();

  /// Update Cart Qty
  Future<void> validateItemApi(BuildContext context, String productUuid,
      int qty, List<CartAttributeDataDtoList> selectedAttributeList,
      {String? uuid, bool? isFromEdit}) async {
    validateItemState.isLoading = true;
    validateItemState.success = null;
    notifyListeners();
    AddCartRequestModel requestModel =
        addCartValue(productUuid, qty, selectedAttributeList, uuid, isFromEdit);
    String request = addCartRequestModelToJson(requestModel);

    final result = await cartRepository.validateItemApi(request);

    result.when(
      success: (data) async {
        validateItemState.success = data;
      },
      failure: (NetworkExceptions error) {
        String errorMsg = NetworkExceptions.getErrorMessage(error);
        showCommonErrorDialog(context: context, message: errorMsg);
      },
    );

    validateItemState.isLoading = false;
    notifyListeners();
  }

  var placeOrderState = UIState<CommonResponseModel>();

  ///Place Order Api
  Future<void> placeOrderApi(BuildContext context, WidgetRef ref,
      {bool isMobile = false, bool isGuest = false}) async {
    placeOrderState.isLoading = true;
    placeOrderState.success = null;
    notifyListeners();

    List<PlaceOrderCartList> placeOrderCartList = [];
    for (var item in cartListState.success?.data?.cartDtoList ?? []) {
      placeOrderCartList.add(PlaceOrderCartList(uuid: item.uuid));
    }
    String request;
    if (isGuest == true) {
      PlaceOrderRequestModel requestModel = PlaceOrderRequestModel(
          additionalNote: isMobile
              ? additionalNoteText
              : ref.read(additionalNoteController).additionalNoteCtr.text,
          cartList: placeOrderCartList,
          locationPointsUuid: Session.getLocationUuid());
      request = placeOrderRequestModelToJson(requestModel);
    } else {
      PlaceOrderRequestModel requestModel = PlaceOrderRequestModel(
          additionalNote: isMobile
              ? additionalNoteText
              : ref.read(additionalNoteController).additionalNoteCtr.text,
          cartList: placeOrderCartList,
          locationPointsUuid: ref
              .read(selectLocationDialogController)
              .selectedLocationPoint
              ?.uuid);
      request = placeOrderRequestModelToJson(requestModel);
    }

    final result = await orderRepository.placeOrderApi(request);

    result.when(success: (data) async {
      placeOrderState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    placeOrderState.isLoading = false;
    notifyListeners();
  }

  /// Add item list in Cart
  var addItemListCartState = UIState<CommonResponseModel>();
  List<CartDto> itemListCartDto = [];
  List<CartAttributeDtoList> itemListAttributeDto = [];

  Future<void> addItemListCartApi(BuildContext context,
      List<OrderDetailsOrdersItem>? orderItemsList) async {
    addItemListCartState.isLoading = true;
    addItemListCartState.success = null;
    notifyListeners();

    orderItemsList?.forEach((element) {
      element.ordersItemAttributes?.forEach((element) {
        CartAttributeDtoList itemList = CartAttributeDtoList(
            attributeUuid: element.attributeUuid,
            attributeNameUuid: element.attributeNameUuid);
        itemListAttributeDto.add(itemList);
      });

      CartDto cart = CartDto(
        productUuid: element.productUuid,
        qty: element.qty,
        cartAttributeDtoList: itemListAttributeDto,
      );
      itemListCartDto.add(cart);
      itemListAttributeDto = [];
      notifyListeners();
    });

    AddItemListCartRequestModel requestModel =
        AddItemListCartRequestModel(cartDtOs: itemListCartDto);

    String request = addItemListCartRequestModelToJson(requestModel);

    final result = await cartRepository.addItemListCartApi(request);

    result.when(success: (data) async {
      addItemListCartState.success = data;
      addItemListCartState.isLoading = false;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    addItemListCartState.isLoading = false;
    itemListCartDto = [];
    notifyListeners();
  }

  var frequentlyBoughtListState = UIState<FrequentlyBoughtListResponseModel>();

  /// Cart List API
  Future<void> frequentlyBoughtListApi(BuildContext context) async {
    frequentlyBoughtListState.isLoading = true;
    frequentlyBoughtListState.success = null;
    notifyListeners();

    final result = await cartRepository.frequentlyBoughtListApi();

    result.when(success: (data) async {
      frequentlyBoughtListState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    frequentlyBoughtListState.isLoading = false;
    notifyListeners();
  }

  /// Clear Cart Api
  var clearCartState = UIState<CommonResponseModel>();

  Future<void> clearCartApi(BuildContext context) async {
    clearCartState.isLoading = true;
    clearCartState.success = null;
    notifyListeners();

    final result = await cartRepository.clearCartApi();

    result.when(success: (data) async {
      clearCartState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    clearCartState.isLoading = false;
    notifyListeners();
  }
}

class TrayModel {
  String? name;
  String? des;
  int? qty;
  bool? isFav;

  TrayModel({this.name, this.des, this.qty, this.isFav = false});
}
