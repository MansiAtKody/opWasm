import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/dialog_transition.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:lottie/lottie.dart';

/// Tray Details Dialog
showAnimatedTrayDialog(
  BuildContext context, {
  required String title,
  required Widget child,
  required double heightPercentage,
  required double widthPercentage,
  required GestureTapCallback onCloseTap,
  Function(AnimationController animationController)? onPopCall,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.4, sigmaY: 8.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DialogTransition(
                  onPopCall: onPopCall,
                  child: Container(
                    height: context.height * (heightPercentage / 100),
                    width: context.width * (widthPercentage / 100),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Scaffold(
                      backgroundColor: AppColors.transparent,
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CommonText(
                                  title: title,
                                  textStyle: TextStyles.medium.copyWith(fontSize: 20.sp, color: AppColors.black171717),
                                ),
                              ),
                              InkWell(
                                onTap: onCloseTap,
                                child: Container(
                                  // padding: EdgeInsets.all(10.h),
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteF7F7FC),
                                  child: CommonSVG(
                                    strIcon: AppAssets.svgCross,
                                    height: context.height * 0.03,
                                  ).paddingAll(10.h),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: context.height * 0.03),
                          Expanded(child: child),
                        ],
                      ).paddingSymmetric(horizontal: context.width * 0.04, vertical: context.height * 0.05),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    },
  );
}

/// Tray Details Dialog Mobile
showAnimatedTrayDialogMobile(
  BuildContext context, {
  required String title,
  required Widget child,
  required double heightPercentage,
  required double widthPercentage,
  required GestureTapCallback onCloseTap,
  Function(AnimationController animationController)? onPopCall,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.4, sigmaY: 8.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DialogTransition(
                  onPopCall: onPopCall,
                  child: Container(
                    height: context.height * 0.85,
                    width: context.width * 0.92,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Scaffold(
                      backgroundColor: AppColors.transparent,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            title: title,
                            textStyle: TextStyles.medium.copyWith(fontSize: 16.sp, color: AppColors.black171717),
                          ),
                          // SizedBox(height: context.height * 0.03),
                          Expanded(child: child),
                        ],
                      ).paddingAll(20.h),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    },
  );
}

showAnimatedDialog(
  BuildContext context, {
  String? title,
  required Widget child,
  required double heightPercentage,
  required double widthPercentage,
  GestureTapCallback? onCloseTap,
  bool isCloseButtonVisible = true,
  Color? backgroundColor,
  bool givePadding = true,
  Function(AnimationController animationController)? onPopCall,
}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DialogTransition(
                onPopCall: onPopCall,
                child: Container(
                  height: context.height * (heightPercentage / 100),
                  width: context.width * (widthPercentage / 100),
                  decoration: BoxDecoration(
                    color: backgroundColor ?? AppColors.servicesScaffoldBgColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Scaffold(
                    backgroundColor: AppColors.transparent,
                    body: Container(
                      padding: givePadding ? EdgeInsets.symmetric(horizontal: context.width * 0.03, vertical: context.height * 0.05) : null,
                      child: Column(
                        children: [
                          isCloseButtonVisible
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CommonText(
                                            title: title ?? '',
                                            textStyle: TextStyles.medium.copyWith(fontSize: 20.sp, color: AppColors.black171717),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: onCloseTap,
                                          child: CommonSVG(
                                            strIcon: AppAssets.svgCross,
                                            height: context.height * 0.03,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: context.height * 0.03),
                                  ],
                                )
                              : const Offstage(),
                          Expanded(child: child),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
        ],
      );
    },
  );
}

showAnimatedFilterDialog(BuildContext context, {required Widget child}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Row(
        children: [
          const Expanded(child: SizedBox()),
          child,
        ],
      );
    },
  );
}

/// Confirmation dialog  message
showConfirmationDialog(
  BuildContext context,
  String negativeButtonTitle,
  String positiveButtonTitle,
  Function(bool isPositive) didTakeAction, {
  Color? positiveButtonColor,
  String? icon,
  String? title,
  String? message,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    // barrierColor: AppColors.black.withOpacity(0.6),
    builder: (context) => Dialog(
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.all(20.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(30.r),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 56.h, bottom: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != '' && icon != null)
                  icon.contains('.svg')
                      ? CommonSVG(strIcon: icon)
                      : Image.asset(
                          icon,
                        ),
                if (title != '')
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      style: TextStyles.medium.copyWith(color: AppColors.black, fontSize: 20.sp),
                    ),
                  ),
                if (title != '')
                  SizedBox(
                    height: 15.h,
                  ),
                if (message != '')
                  Text(
                    message ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyles.medium.copyWith(color: AppColors.black, fontSize: 16.sp),
                  ).paddingOnly(bottom: 16.h),
                if (title != '')
                  SizedBox(
                    height: 30.h,
                  ),
                Row(
                  children: [
                    Expanded(
                      child: CommonButtonMobile(
                          buttonText: positiveButtonTitle,
                          height: 50.h,
                          width: 116.w,
                          borderRadius: BorderRadius.circular(32.r),
                          onTap: () {
                            didTakeAction(true);
                            Navigator.pop(context);
                          },
                          buttonEnabledColor: positiveButtonColor ?? AppColors.black0A0A0A,
                          borderColor: AppColors.black0A0A0A,
                          borderWidth: 1.w,
                          buttonTextColor: AppColors.white),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: CommonButtonMobile(
                          height: 50.h,
                          width: 116.w,
                          borderRadius: BorderRadius.circular(32.r),
                          buttonText: negativeButtonTitle,
                          onTap: () {
                            Navigator.pop(context);
                            didTakeAction(false);
                          },
                          borderColor: AppColors.transparent,
                          borderWidth: 1.w,
                          buttonEnabledColor: positiveButtonColor ?? AppColors.whiteF7F7FC,
                          buttonTextColor: AppColors.grey7D7D7D),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

showCommonAnimationDialog({
  required BuildContext context,
  String? image,
  required String title,
  required String description,
  required String buttonText,
  TextStyle? buttonTextStyle,
  Widget? animationWidget,
  GestureTapCallback? onButtonTap,
  NavigationStackItem? item,
}) {
  return showCommonWebDialog(
    context: context,
    dialogBody: Consumer(builder: (context, ref, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: CommonText(
                    title: title,
                    maxLines: 2,
                    textStyle: TextStyles.semiBold.copyWith(
                      fontSize: 26.sp,
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  child: CommonText(
                    title: description,
                    textStyle: TextStyles.light.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.grey8D8C8C,
                    ),
                    maxLines: 10,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CommonButton(
                  buttonText: buttonText,
                  height: 60.h,
                  width: 151.w,
                  buttonTextStyle: buttonTextStyle,
                  onTap: onButtonTap ??
                      () {
                        ref.watch(profileController).clearFormData();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        ref.read(navigationStackProvider).pushRemove(item ?? const NavigationStackItem.profile());
                      },
                  isButtonEnabled: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: animationWidget ?? SizedBox(
              height: context.height * 0.6,
              child: Column(
                children: [
                  SizedBox(
                    height: context.height * 0.1,
                  ),
                  Image.asset(
                    image ?? AppAssets.icMap,
                    height: context.height * 0.5,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ).paddingOnly(right: 60.w,left: 40);
    }),
  );
}

/// Common Web Dialog
showHelpAndSupportDialog({
  required BuildContext context,
  Widget? widget,
  Widget? topWidget,
  Widget? buttonWidget,
  String? topText,
  double? width,
  double? topVerticalPadding,
  double? topHorizontalPadding,
  double? iconTopPadding,
  double? iconRightPadding,
  double? topPadding,
  GestureTapCallback? onTapCrossIconButton,
  bool isButtonEnabled = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColors.white,
        insetPadding: EdgeInsets.all(20.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: width ?? MediaQuery.sizeOf(context).width * 0.3,

                  ///Dialog Top Text and Cross Button
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      topWidget ??
                          CommonText(
                            title: topText ?? '',
                            textStyle: TextStyles.medium.copyWith(fontSize: 20.sp, color: AppColors.black272727),
                          ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const CommonSVG(
                          strIcon: AppAssets.svgCross,
                          svgColor: AppColors.black272727,
                        ),
                      ).paddingOnly(top: iconTopPadding ?? 0.0, right: iconRightPadding ?? 0.0)
                    ],
                  ),
                ).paddingOnly(
                  right: topHorizontalPadding ?? 30.w,
                  left: topHorizontalPadding ?? 30.w,
                  top: topPadding ?? topVerticalPadding ?? 30.h,
                  bottom: topVerticalPadding ?? 30.h,
                ),

                /// Dialog Widget
                SizedBox(
                  width: width ?? MediaQuery.sizeOf(context).width * 0.3,
                  child: widget,
                ),

                ///Common Bottom Button
                buttonWidget != null
                    ? SizedBox(
                  width: width ?? MediaQuery.sizeOf(context).width * 0.3,
                  child: buttonWidget,
                ).paddingOnly(top: 50.h, bottom: 30.h)
                    : const Offstage(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

showCommonWebDialog({
  required BuildContext context,
  required Widget dialogBody,
  bool? barrierDismissible,
  double? width,
  double? height,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible ?? false,
    builder: (context) {
      return FadeBoxTransition(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30.r),
            ),
            width: width ?? context.width * 0.5,
            height: height ?? context.height * 0.6,
            child: dialogBody,
          ),
        ),
      );
    },
  );
}

/// Widget Dialog
showWidgetDialog(BuildContext context, Widget? widget, Function()? didDismiss, {bool isDismissDialog = false, int autoDismissTimer = 0}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.grey.withOpacity(0.3),
      builder: (context) => FadeBoxTransition(
            child: Dialog(
              backgroundColor: AppColors.white,
              insetPadding: EdgeInsets.all(16.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(19.r),
                ),
              ),
              child: Wrap(
                children: [
                  widget!,
                ],
              ),
            ),
          ));

  if (autoDismissTimer > 0) {
    Future.delayed(Duration(seconds: autoDismissTimer), () {
      if (didDismiss != null) {
        didDismiss();
      }
    });
  } else {
    if (isDismissDialog) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        didDismiss!();
      });
    }
  }
}

showCommonMobileDialog({
  required BuildContext context,
  required Widget dialogBody,
  double? height,
  double? width,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return FadeBoxTransition(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30.r),
            ),
            height: height,
            width: width,
            child: dialogBody,
          ),
        ),
      );
    },
  );
}
//
// Future showAnimatedDialog(BuildContext context, {required Widget child}) async {
//   await showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) => Column(
//       children: [
//         const Expanded(child: SizedBox()),
//         Row(
//           children: [
//             const Expanded(child: SizedBox()),
//             child,
//             const Expanded(child: SizedBox()),
//           ],
//         ),
//         const Expanded(child: SizedBox()),
//       ],
//     ),
//   );
// }

/// Common Web Dialog
showCommonWebDialog2({
  required BuildContext context,
  Widget? widget,
  Widget? topWidget,
  Widget? buttonWidget,
  String? topText,
  double? width,
  double? topVerticalPadding,
  double? topHorizontalPadding,
  double? iconTopPadding,
  double? iconRightPadding,
  double? topPadding,
  GestureTapCallback? onTapCrossIconButton,
  bool isButtonEnabled = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return FadeBoxTransition(
        child: Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.all(20.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: width ?? MediaQuery.sizeOf(context).width * 0.3,

                    ///Dialog Top Text and Cross Button
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        topWidget ??
                            CommonText(
                              title: topText ?? '',
                              textStyle: TextStyles.medium.copyWith(fontSize: 20.sp, color: AppColors.clr272727),
                            ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const CommonSVG(
                            strIcon: AppAssets.svgCross,
                            svgColor: AppColors.clr272727,
                          ),
                        ).paddingOnly(top: iconTopPadding ?? 0.0, right: iconRightPadding ?? 0.0)
                      ],
                    ),
                  ).paddingOnly(
                    right: topHorizontalPadding ?? 30.w,
                    left: topHorizontalPadding ?? 30.w,
                    top: topPadding ?? topVerticalPadding ?? 30.h,
                    bottom: topVerticalPadding ?? 30.h,
                  ),

                  /// Dialog Widget
                  SizedBox(
                    width: width ?? MediaQuery.sizeOf(context).width * 0.3,
                    child: widget,
                  ),

                  ///Common Bottom Button
                  buttonWidget != null
                      ? SizedBox(
                          width: width ?? MediaQuery.sizeOf(context).width * 0.3,
                          child: buttonWidget,
                        ).paddingOnly(top: 50.h, bottom: 30.h)
                      : const Offstage(),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void showSuccessDialogue({
  required BuildContext context,
  required String animation,
  required String successMessage,
  required String successDescription,
  required String buttonText,
  void Function()? onTap,
  bool? isIconRequired,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return FadeBoxTransition(
        child: Dialog(
          elevation: 0.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          backgroundColor: AppColors.white,
          child: SizedBox(
            width: 573.w,
            height: 543.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SizedBox(
                    width: 421.w,
                    height: 348.h,
                    child: Lottie.asset(
                      width: 421.w,
                      height: 348.h,
                      animation,
                      fit: BoxFit.fitHeight,
                      repeat: true,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  left: 0.0,
                  child: Container(
                    height: 195.h,
                    width: 573.w,
                    decoration: BoxDecoration(
                      color: AppColors.clr272727,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: SizedBox(
                            height: 30.h,
                          ),
                        ),
                        Text(
                          successMessage,
                          textAlign: TextAlign.center,
                          style: TextStyles.medium.copyWith(
                            fontSize: 18.sp,
                            color: AppColors.white,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 10.h,
                          ),
                        ),
                        Text(
                          successDescription,
                          textAlign: TextAlign.center,
                          style: TextStyles.regular.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 35.h,
                          ),
                        ),
                        CommonButton(
                          buttonText: buttonText,
                          buttonTextStyle: TextStyles.regular.copyWith(
                            color: AppColors.white,
                          ),
                          height: 50.h,
                          width: 300.w,
                           rightIcon: isIconRequired??false ?const Icon(Icons.arrow_forward,
                             color: AppColors.white):const Offstage(),
                          buttonEnabledColor: AppColors.blue0083FC,
                          isButtonEnabled: true,
                          onTap: onTap,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// Request Send Dialog Web
showRequestSendDialogWeb({
  required BuildContext context,
  String? titleText,
  String? subTitleText,
  String? buttonText,
  GestureTapCallback? onButtonTap,
}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: AppColors.black.withOpacity(0.84),
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: AppColors.white,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              width: MediaQuery.sizeOf(context).width * 0.7,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Title Text
                      CommonText(
                        title: titleText ?? LocalizationStrings.keyYourRequestIsSuccessfullySend.localized,
                        textStyle: TextStyles.regular.copyWith(fontSize: 24.sp, color: AppColors.black),
                      ),

                      /// Subtitle Text
                      CommonText(
                        title: subTitleText ?? LocalizationStrings.keyYourRequestForwardedToRobot.localized,
                        textStyle: TextStyles.light.copyWith(fontSize: 14.sp, color: AppColors.clr8D8D8D),
                      ).paddingOnly(top: 22.h, bottom: 24.h),

                      /// Close Button
                      CommonButton(
                        width: MediaQuery.sizeOf(context).width * 0.1,
                        height: MediaQuery.sizeOf(context).height * 0.090,
                        onTap: onButtonTap ??
                            () {
                              Navigator.of(context).pop();
                            },
                        buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.white),
                        buttonText: buttonText ?? LocalizationStrings.keyClose.localized,
                        isButtonEnabled: true,
                      )
                    ],
                  ).paddingOnly(left: 80.w),
                  Expanded(
                    child: Lottie.asset(
                      AppAssets.animOrderSuccessfull,
                    ),
                  ),
                ],
              ),
            ));
      });
}

/// Widget Dialog for Image Picker
showWidgetDialogIP(BuildContext context, Widget? widget, Function()? didDismiss, {bool isDismissDialog = false, int autoDismissTimer = 0}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.grey.withOpacity(0.3),
      builder: (context) => Dialog(
            backgroundColor: AppColors.white,
            insetPadding: EdgeInsets.all(25.sp),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(20.r),
              ),
            ),
            child: Wrap(
              children: [
                widget!,
              ],
            ),
          ));

  if (autoDismissTimer > 0) {
    Future.delayed(Duration(seconds: autoDismissTimer), () {
      if (didDismiss != null) {
        didDismiss();
      }
    });
  } else {
    if (isDismissDialog) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        didDismiss!();
      });
    }
  }
}

/// Request Send Dialog Mobile
showCommonSuccessDialogMobile({
  required BuildContext context,
  String? titleText,
  String? buttonText,
  String? anim,
  GestureTapCallback? onButtonTap,
}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: AppColors.black.withOpacity(0.84),
      builder: (BuildContext context) {
        return FadeBoxTransition(
          child: Dialog(
              backgroundColor: AppColors.white,
              insetPadding: EdgeInsets.all(30.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(anim ?? AppAssets.animYourRequestSentCropped, height: context.height * 0.6, width: context.width * 0.9, fit: BoxFit.fill),
                    SizedBox(height: 30.h),

                    /// Title Text
                    Center(
                      child: CommonText(
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        title: titleText ?? LocalizationStrings.keyYourRequestIsSuccessfullySend.localized,
                        textStyle: TextStyles.regular.copyWith(fontSize: 17.sp, color: AppColors.black),
                      ),
                    ).paddingSymmetric(vertical: 0.h, horizontal: 40.w),

                    /// Close Button
                    CommonButtonMobile(
                      borderColor: AppColors.blue009AF1,
                      width: context.width,
                      height: context.height * 0.07,
                      onTap: onButtonTap ??
                          () {
                            Navigator.of(context).pop();
                          },
                      buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.blue009AF1),
                      buttonText: buttonText ?? LocalizationStrings.keyClose.localized,
                      isButtonEnabled: true,
                      buttonEnabledColor: AppColors.white,
                    ).paddingAll(10.h)
                  ],
                ),
              )),
        );
      });
}

/// Confirmation dialog  message Web
showConfirmationDialogWeb({
  required BuildContext context,
  required String title,
  required String message,
  String? negativeButtonTitle,
  String? positiveButtonTitle,
  Function(bool isPositive)? didTakeAction,
  Color? positiveButtonColor,
  double? dialogWidth,
  double? titleFontSize,
  double? messageFontSize,
}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.all(20.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            width: dialogWidth,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 30.h, bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CommonSVG(strIcon: AppAssets.svgInfo),
                  SizedBox(
                    height: 10.h,
                  ),
                  if (title.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: CommonText(
                        title: title,
                        fontSize: 18.sp,
                        maxLines: 6,
                        clrfont: AppColors.black171717,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (title.isNotEmpty)
                    SizedBox(
                      height: 20.h,
                    ),
                  if (message.isNotEmpty)
                    CommonText(
                      title: message,
                      fontSize: 14.sp,
                      clrfont: AppColors.grey7E7E7E,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                    ).paddingOnly(bottom: 16.h),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonButton(
                        height: 40.h,
                        width: 92.w,
                        buttonText: positiveButtonTitle ?? LocalizationStrings.keyYes.localized,
                        onTap: () {
                          Navigator.pop(context);
                          didTakeAction!(true);
                        },
                        buttonEnabledColor: AppColors.black171717,
                        isButtonEnabled: true,
                        buttonTextColor: AppColors.white,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      CommonButton(
                        height: 40.h,
                        width: 92.w,
                        buttonText: negativeButtonTitle ?? LocalizationStrings.keyNo.localized,
                        onTap: () {
                          didTakeAction!(false);
                          Navigator.pop(context);
                        },
                        isButtonEnabled: true,
                        buttonEnabledColor: AppColors.lightPinkF7F7FC,
                        buttonTextColor: AppColors.black171717,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

/// Dialog for the
commonTitleWithCrossIcon(
    BuildContext context, {
      required String title,
      required Widget child,
      required double heightPercentage,
      required double widthPercentage,
      GestureTapCallback? onTap,
      bool? isEdit,
      GestureTapCallback? onCompulsoryTap,
      GestureTapCallback? onCloseTap,
    }) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return FadeBoxTransition(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: AppColors.white,
          child: SizedBox(
            height: context.height * (heightPercentage / 100),
            width: context.width * (widthPercentage / 100),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonText(
                        title: title,
                        textStyle: TextStyles.medium.copyWith(fontSize: 20.sp, color: AppColors.black171717),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        onCloseTap?.call();
                        Navigator.pop(context);
                      },
                      child: CommonSVG(
                        strIcon: AppAssets.svgCross,
                        height: 40.h,
                        width: 40.h,
                      ),
                    )
                  ],
                ),
                SizedBox(height: context.height * 0.03),
                Expanded(child: child),
              ],
            ).paddingSymmetric(horizontal: context.width * 0.02, vertical: context.height * 0.03),
          ),
        ),
      );
    },
  );
}

showCommonDialog({
  required BuildContext context,
  required Widget dialogBody,
  double? width,
  bool? barrierDismissible,
  double? height,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible ?? false,
    builder: (context) {
      return FadeBoxTransition(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30.r),
            ),
            width: width ?? context.width * 0.5,
            height: height ?? context.height * 0.6,
            child: dialogBody,
          ),
        ),
      );
    },
  );
}



showCommonErrorDialogWeb({
  required BuildContext context,
  required String message,
  TextStyle? textStyle,
  Function()? onButtonTap,
  Function()? onCrossTap,
  double? height,
  double? width,
}){
  if(errorDialogKey.currentState == null && errorDialogKey.currentContext == null){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context)
      {
        return AlertDialog(
          key: errorDialogKey,
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          content: Builder(
              builder: (BuildContext context){
                return   SizedBox(
                  // height: height ??context.height * 0.2,
                  width: width??context.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: onCrossTap ?? (){
                          Navigator.of(context).pop();
                        },
                        child: CommonSVG(
                          strIcon: AppAssets.svgCross,
                          height: context.height * 0.03,
                        ),
                      ).alignAtBottomRight(),
                      Wrap(
                        children: [
                          Text(
                            message,
                            style: textStyle ?? TextStyles.medium.copyWith(
                                color: AppColors.black171717,
                                fontSize: 22.sp),
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ).paddingOnly(bottom: 30.h),
                      CommonButton(
                        height: 45.h,
                        width: 100.w,
                        buttonText:
                        LocalizationStrings.keyOk.localized,
                        isButtonEnabled: true,
                        onTap: onButtonTap ?? () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              }

          ),

        );
      });
  }
}

GlobalKey errorDialogKey = GlobalKey();

showCommonErrorDialogMobile({
  required BuildContext context,
  required String message,
  TextStyle? textStyle,
  Function()? onButtonTap,
  double? height,
  double? width,
}){
  if(errorDialogKey.currentState == null && errorDialogKey.currentContext == null) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context)
      {
        return AlertDialog(
          key: errorDialogKey,
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          content: Builder(
              builder: (BuildContext context){
                return   SizedBox(
                  // height: height ??context.height * 0.18,
                  width: width??context.width * 0.17,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        children: [
                          Text(
                            message,
                            style: textStyle ?? TextStyles.medium.copyWith(
                                color: AppColors.black171717,
                                fontSize: 18.sp),
                            maxLines: 10,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ).paddingOnly(bottom: 30.h),
                      CommonButton(
                        height: 45.h,
                        width: 100.w,
                        buttonText:
                        LocalizationStrings.keyOk.localized,
                        isButtonEnabled: true,
                        onTap: onButtonTap ?? () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              }

          ),

        );
      });
  }
}

showAnimatedDialogForOrder(
    BuildContext context, {
      required String title,
      double? titleTextSize,
      Widget? titleWidget,
      FontWeight? titleFontWeight,
      bool isCloseButtonVisible = true,
      bool givePadding = true,
      Color? dialogBg,
      required Widget child,
      required double heightPercentage,
      required double widthPercentage,
      required GestureTapCallback onCloseTap,
      Function(AnimationController animationController)? onPopCall,
    }) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DialogTransition(
                onPopCall: onPopCall,
                child: Container(
                  height: context.height * (heightPercentage / 100),
                  width: context.width * (widthPercentage / 100),
                  decoration: BoxDecoration(
                    color: dialogBg ?? AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Scaffold(
                    backgroundColor: AppColors.transparent,
                    body: Column(
                      children: [
                        if (isCloseButtonVisible) ...{
                          Row(
                            children: [
                              Expanded(
                                child: titleWidget ??
                                    CommonText(
                                      title: title,
                                      textStyle: TextStyles.medium.copyWith(
                                          fontSize: titleTextSize ?? 20.sp,
                                          color: AppColors.black171717,
                                          fontWeight: titleFontWeight ??
                                              TextStyles.fwMedium),
                                    ),
                              ),
                              InkWell(
                                onTap: onCloseTap,
                                child: const CommonSVG(
                                  strIcon: AppAssets.svgCrossRounded,
                                  // height: context.height * 0.03,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: context.height * 0.03),
                        },
                        Expanded(child: child),
                      ],
                    ).paddingSymmetric(
                      horizontal: givePadding ? context.width * 0.03 : 0,
                      vertical: givePadding ? context.height * 0.05 : 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
        ],
      );
    },
  );
}
