import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  DeviceScreenType get deviceType => getDeviceType(MediaQuery.of(this).size);

  bool get isMobileScreen => deviceType == DeviceScreenType.mobile;

  bool get isWebScreen => deviceType == DeviceScreenType.desktop;

  void get nextField => FocusScope.of(this).nextFocus();

  void get hideKeyboard => FocusScope.of(this).unfocus();

  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 200;
}
