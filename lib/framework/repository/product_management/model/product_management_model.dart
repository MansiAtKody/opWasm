import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';

/// Product Model
class ProductModel {
  final String? productUuid;
  final String? productImage;
  final String? productName;
  final String? productCategory;
  final ProductStatusEnum status;
  final List<List<SeeCustomizedItemModel>> productComponentList;
  bool isSwitchOn;
  bool isExpanded;

  ProductModel({
    required this.productComponentList,
    this.productUuid,
    this.productImage,
    this.productName,
    this.productCategory,
    required this.status,
    required this.isSwitchOn,
    required this.isExpanded,
  });
}

/// Dasher Status Style
class ProductStatusStyle {
  final String productStatus;
  final Color productStatusTextColor;

  ProductStatusStyle({
    required this.productStatus,
    required this.productStatusTextColor,
  });
}

///Customization Item Model
class SeeCustomizedItemModel {
  final String icon;
  final String name;
  bool isEnabled;
  bool isSelected;

  SeeCustomizedItemModel({
    required this.icon,
    required this.name,
    required this.isEnabled,
    required this.isSelected,
  });
}
