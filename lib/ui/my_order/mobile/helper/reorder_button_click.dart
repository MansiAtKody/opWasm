


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_details_response_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';

///Reorder manage tap call
void reorderButtonClick(OrderDetailsResponseModel? orderDetails,BuildContext context,WidgetRef ref){
  if(orderDetails != null){
    List<OrderDetailsOrdersItem> notAvailableProducts = [];
    List<OrderDetailsOrdersItem> availableProducts = [];
    notAvailableProducts = orderDetails.data?.ordersItems?.where((orderItem) => (!(orderItem.productAvailable ?? false))).toList() ?? [];
    availableProducts = orderDetails.data?.ordersItems?.toList() ?? [];
    if(notAvailableProducts.isNotEmpty){
      print('Product Not Available');
      for (var productAttribute in notAvailableProducts) {
        availableProducts.removeWhere((product) => product.uuid == productAttribute.uuid);
      }
      _checkAttributes(availableProducts,context,ref);
    }else{
      _checkAttributes(availableProducts,context,ref);
    }
  }
}

/// Check attributes and attributes name avaibility
_checkAttributes(List<OrderDetailsOrdersItem> availableProducts,BuildContext context,WidgetRef ref){
  List<OrderDetailsOrdersItem> attributesNotAvailableProducts = [];
  for (var orderItems in availableProducts) {
    orderItems.ordersItemAttributes?.forEach((attributes) {
      if(!(attributes.productAttributeAvailable ?? false) || !(attributes.productAttributeNameAvailable ?? false)){
        attributesNotAvailableProducts.add(orderItems);
      }
    });
  }
  if(attributesNotAvailableProducts.isEmpty){
    if(availableProducts.isEmpty){
      print('No Product Available');
      print('List Of Available Products: ${List<dynamic>.from(availableProducts.map((x) => x.toJson()))}');
      _confirmationOfAvailableProduct(availableProducts,context,ref);
    }else{
      print('Re Order Successful');
      print('List Of Available Products: ${List<dynamic>.from(availableProducts.map((x) => x.toJson()))}');
      _confirmationOfAvailableProduct(availableProducts,context,ref);
    }
  }else{
    for (var productAttribute in attributesNotAvailableProducts) {
      availableProducts.removeWhere((product) => product.uuid == productAttribute.uuid);
    }
    print('Attribute Or Attribute Name Not Available');
    print('List Of Available Products: ${List<dynamic>.from(availableProducts.map((x) => x.toJson()))}');
    _confirmationOfAvailableProduct(availableProducts,context,ref);
  }
}

/// Confirmation of Available products
_confirmationOfAvailableProduct(List<OrderDetailsOrdersItem> availableProducts,BuildContext context,WidgetRef ref ){
  final myOrderWatch = ref.watch(myOrderController);
  if(availableProducts.isEmpty){
    ///If no products are available
    showCommonErrorDialogMobile(context: context, message: LocalizationStrings.keyAllProductsNotAvailable.localized);
  } else if(availableProducts.length ==  myOrderWatch.orderDetailsState.success?.data?.ordersItems?.length ){

    /// If all products are avaialable
    _reorderApiCall(availableProducts,ref,context);
  }else{
    ///If one or more product is not avaialble
    showConfirmationDialog(
      context,
      LocalizationStrings.keyNo.localized,
      LocalizationStrings.keyYes.localized,
          (isPositive){
        if(isPositive){
          print('List Of Available Productsss: ${List<dynamic>.from(availableProducts.map((x) => x.toJson()))}');
          _reorderApiCall(availableProducts,ref,context);
        }
      },
      message: LocalizationStrings.keyOneOrMoreProductAvailable.localized,
      title: LocalizationStrings.keyProductNotAvailable.localized,
    );
  }
}

/// Re-Order Api Call
_reorderApiCall(List<OrderDetailsOrdersItem> availableProducts,WidgetRef ref, BuildContext context) async{
  final myTrayWatch = ref.watch(myTrayController);

  await myTrayWatch.cartListApi(context).then((value)async{
    if(myTrayWatch.cartListState.success?.status == ApiEndPoints.apiStatus_200) {
      if(myTrayWatch.cartListState.success?.data?.cartDtoList?.isNotEmpty ??false){
        _cartValidationTapCall(context,myTrayWatch,ref,availableProducts);
      }else{
        await myTrayWatch.addItemListCartApi(context,availableProducts).then((value) {
          if(myTrayWatch.addItemListCartState.success?.status == ApiEndPoints.apiStatus_200){
            ref.read(navigationStackProvider).push(const NavigationStackItem.myTray());
          }

        });
      }
    }
  });
}

/// Cart empty Validation call
_cartValidationTapCall(BuildContext context,MyTrayController myTrayWatch, WidgetRef ref,List<OrderDetailsOrdersItem> availableProducts) {
  showConfirmationDialog(
    context,
    LocalizationStrings.keyNo.localized,
    LocalizationStrings.keyYes.localized,
    title: LocalizationStrings.keyAlreadyItemsConfirmationMessage.localized,
    message: LocalizationStrings.keyAlreadyItemsRemoveConfirmationMessage.localized,
    (isPositive) async{
      if (isPositive) {
        await myTrayWatch.clearCartApi(context).then((value) async{
          if(myTrayWatch.clearCartState.success?.status == ApiEndPoints.apiStatus_200){
            await  myTrayWatch.addItemListCartApi(context,availableProducts).then((value) {
              if(myTrayWatch.addItemListCartState.success?.status == ApiEndPoints.apiStatus_200){
                ref.read(navigationStackProvider).push(const NavigationStackItem.myTray());
              }
            });
          }
        });

      }
    },
  );
}