import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/controller/home/home_controller.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/order/contract/order_repository.dart';
import 'package:kody_operator/framework/repository/order/model/response/product_detail_response_model.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final orderCustomizationController = ChangeNotifierProvider(
  (ref) => getIt<OrderCustomizationController>(),
);

@injectable
class OrderCustomizationController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    selectedDairy = null;
    selectedQuantity = null;
    selectedSugar = null;
    isRememberCustomization = false;
    selectedAttributeList=[];
    qty = 1;
    if (isNotify) {
      notifyListeners();
    }
  }
  
  CustomizeItemModel? selectedDairy;
  CustomizeItemModel? selectedQuantity;
  CustomizeItemModel? selectedSugar;
  bool isRememberCustomization = false;
  int qty = 1;

 // ItemModel? product;

  // void updateItemModel(ItemModel? product) {
  //   // this.product = product;
  //   // if (product?.sugarCustomization != null) {
  //   //   selectedSugar = sugarList.firstWhere((element) => element.customisationType == product?.sugarCustomization);
  //   //   selectedDairy = dairyList.firstWhere((element) => element.customisationType == product?.dairyCustomization);
  //   //   selectedQuantity = quantityMilkList.firstWhere((element) => element.customisationType == product?.quantityCustomization);
  //   //   isRememberCustomization = true;
  //   // }
  //   // selectedQuantity?.controller?.forward();
  //   // selectedDairy?.controller?.forward();
  //   // selectedSugar?.controller?.forward();
  //   // notifyListeners();
  // }

  updateUi(){
    notifyListeners();
  }
  void updateQtyMilkSelected({CustomizeItemModel? selectedQuantity}) {
    this.selectedQuantity = selectedQuantity;
    this.selectedQuantity?.controller?.forward();
    for (var milk in quantityMilkList) {
      if (this.selectedQuantity != milk) {
        milk.controller?.reset();
      }
    }
    notifyListeners();
  }

  void updateDairySelected({CustomizeItemModel? selectedDairy}) {
    this.selectedDairy = selectedDairy;
    this.selectedDairy?.controller?.forward();
    for (var dairy in dairyList) {
      if (this.selectedDairy != dairy) {
        dairy.controller?.reset();
      }
    }
    notifyListeners();
  }

  void updateSugarSelected({CustomizeItemModel? selectedSugar}) {
    this.selectedSugar = selectedSugar;
    this.selectedSugar?.controller?.forward();
    for (var sugar in sugarList) {
      if (this.selectedSugar != sugar) {
        sugar.controller?.reset();
      }
    }
    notifyListeners();
  }

  // void updatedFav({required HomeController homeWatch,ItemModel? model}) {
  //   // homeWatch.itemList.map((element) => element.id == model?.id ? element.isFavourite = !element.isFavourite : null);
  //   // model?.isFavourite = !model.isFavourite;
  //   // updateItemModel(model);
  //   // notifyListeners();
  // }

  ///Update if customization clicked
  void updateCustomizationIfRemembered({required HomeController homeWatch}) {
    // ItemModel item = homeWatch.itemList.firstWhere((element) => element.id == product?.id);
    // if (isRememberCustomization) {
    //   item.quantityCustomization = selectedQuantity?.customisationType;
    //   item.dairyCustomization = selectedDairy?.customisationType;
    //   item.sugarCustomization = selectedSugar?.customisationType;
    // } else {
    //   item.quantityCustomization = null;
    //   item.dairyCustomization = null;
    //   item.sugarCustomization = null;
    // }
    //
    // updateItemModel(item);
    // notifyListeners();
  }

  void updateRememberCustomize() {
    isRememberCustomization = !isRememberCustomization;
    notifyListeners();
  }

  List<CustomizeItemModel> quantityMilkList = [];

  ///Update Milk Quantity List
  void updateMilkQuantityList(orderCustomizationMobileState) {
    // quantityMilkList = [
    //   CustomizeItemModel(icon: AppAssets.animSmallMilk, name: 'Small', customisationType: OrderCustomisationEnum.smallMilk, controller: AnimationController(vsync: orderCustomizationMobileState, duration: const Duration(milliseconds: 800))),
    //   CustomizeItemModel(icon: AppAssets.animMediumMilk, name: 'Medium', customisationType: OrderCustomisationEnum.mediumMilk, controller: AnimationController(vsync: orderCustomizationMobileState, duration: const Duration(milliseconds: 800))),
    //   CustomizeItemModel(icon: AppAssets.animLargeMilk, name: 'Large', customisationType: OrderCustomisationEnum.largeMilk, controller: AnimationController(vsync: orderCustomizationMobileState, duration: const Duration(milliseconds: 800))),
    // ];
  }

  List<CustomizeItemModel> dairyList = [];

  ///Update Dairy List
  void updateDairyList(orderCustomizationMobileState) {
    dairyList = [
      // CustomizeItemModel(
      //     icon: AppAssets.animWithoutMilk, name: 'Without Milk', customisationType: OrderCustomisationEnum.withoutMilk, controller: AnimationController(vsync: orderCustomizationMobileState, duration: const Duration(milliseconds: 800))),
      // CustomizeItemModel(icon: AppAssets.animAlmondMilk, name: 'Almond Milk', customisationType: OrderCustomisationEnum.almondMilk, controller: AnimationController(vsync: orderCustomizationMobileState, duration: const Duration(milliseconds: 800))),
      // CustomizeItemModel(icon: AppAssets.animSoyaMilk, name: 'Soya Milk', customisationType: OrderCustomisationEnum.soyaMilk, controller: AnimationController(vsync: orderCustomizationMobileState, duration: const Duration(milliseconds: 800))),
    ];
  }

  List<CustomizeItemModel> sugarList = [];

  ///Update Sugar List
  void updateSugarList(orderCustomizationMobileState) {
    // sugarList = [
    //   CustomizeItemModel(
    //       icon: AppAssets.animWithoutSugar, name: 'Without Sugar', customisationType: OrderCustomisationEnum.withoutSugar, controller: AnimationController(vsync: orderCustomizationMobileState, duration: const Duration(milliseconds: 800))),
    //   CustomizeItemModel(
    //       icon: AppAssets.animSingleSugar, name: 'Single Sachet', customisationType: OrderCustomisationEnum.singleSugar, controller: AnimationController(vsync: orderCustomizationMobileState, duration: const Duration(milliseconds: 800))),
    //   CustomizeItemModel(
    //       icon: AppAssets.animDoubleSugar, name: 'Double Sachet', customisationType: OrderCustomisationEnum.doubleSugar, controller: AnimationController(vsync: orderCustomizationMobileState, duration: const Duration(milliseconds: 800))),
    // ];
  }

  void updateQty({required bool isPlus}) {
    if (isPlus) {
      qty++;
    } else {
      if (qty > 1) {
        qty--;
      }
    }
    notifyListeners();
  }

  int sameItemQyt =1;
  addItemCount(int count){
    sameItemQyt=qty +count;
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */


  List<CartAttributeDataDtoList> selectedAttributeList =[];

  void updateAttributeSelection(String attributeUuid,String attributeNameUuid ){

    if((selectedAttributeList.any((element) => element.attributeUuid == attributeUuid))  && (selectedAttributeList.any((element) => element.attributeNameUuid == attributeNameUuid))){
      selectedAttributeList.removeWhere((element) => element.attributeNameUuid==attributeNameUuid);
    }
    else {
      // if(selectedAttributeList.any((element) => element.attributeUuid == attributeUuid)){
      //   selectedAttributeList.removeWhere((element) => element.attributeNameUuid==attributeNameUuid);
      // }else {
      //
      // }
      selectedAttributeList.removeWhere((element) => element.attributeUuid==attributeUuid);

      selectedAttributeList.add(
          CartAttributeDataDtoList(attributeUuid: attributeUuid,attributeNameUuid:attributeNameUuid )
      );


    }
    /*productDetailState.success?.data?.productAttributes?.where((element) => element.attributeUuid == attributeUuid).first.active =
    selectedAttributeList.any((element) => element.attributeUuid == attributeUuid)? true: false;*/
    notifyListeners();
  }


  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  OrderRepository orderRepository;
  OrderCustomizationController(this.orderRepository);

  var productDetailState = UIState<ProductDetailResponseModel>();

  /// Product List API
  Future<void> productDetailApi(BuildContext context,String productUuid) async {
    productDetailState.isLoading = true;
    productDetailState.success = null;
    notifyListeners();


    final result = await orderRepository.productDetailApi(productUuid);

    result.when(success: (data) async {
      productDetailState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
          showCommonErrorDialog(context: context, message: errorMsg);
        });

    productDetailState.isLoading = false;
    notifyListeners();
  }


  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }
}

class CustomizeItemModel {
  OrderCustomisationEnum customisationType;
  String icon;
  String name;
  AnimationController? controller;

  CustomizeItemModel({required this.icon, required this.name, required this.controller, required this.customisationType});
}

class CartAttributeDataDtoList {
  String? attributeUuid;
  String? attributeNameUuid;

  CartAttributeDataDtoList({
    this.attributeUuid,
    this.attributeNameUuid,
  });

  factory CartAttributeDataDtoList.fromJson(Map<String, dynamic> json) => CartAttributeDataDtoList(
    attributeUuid: json['attributeUuid'],
    attributeNameUuid: json['attributeNameUuid'],
  );

  Map<String, dynamic> toJson() => {
    'attributeUuid': attributeUuid,
    'attributeNameUuid': attributeNameUuid,
  };
}
