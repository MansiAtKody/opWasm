import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class CommonAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool isLeadingEnable;
  final bool isDrawerEnable;
  final bool centerTitle;
  //final bool isBorderRadiusEnable;
  final GestureTapCallback? onLeadingPress;
  final GestureTapCallback? onDrawerPress;
  final String title;
  final Widget? leftImage;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? statusBarColor;
  final double? titleSize;
  final double? appBarHeight;
  final double? titleTextPadding;
  final double? topTitlePadding;
  final Widget? titleWidget;
  final Widget? customTitleWidget;
  final double? titleTopPadding;
  final Brightness? statusBarIconBrightness;
  final Brightness? statusBarBrightness;
  final PreferredSizeWidget? bottomWidget;

  const CommonAppBar({
    Key? key,
    this.isLeadingEnable = true,
    this.isDrawerEnable = false,
    this.centerTitle = true,
    this.onLeadingPress,

   // this.isBorderRadiusEnable = true,
    this.leftImage,
    this.title = '',
    this.backgroundColor,
    this.titleColor,
    this.appBarHeight,
    this.actions,
    this.onDrawerPress,
    this.titleWidget,
    this.customTitleWidget,
    this.titleSize,
    this.titleTextPadding,
    this.topTitlePadding,
    this.titleTopPadding,
    this.statusBarColor,
    this.statusBarIconBrightness,
    this.statusBarBrightness,
    this.bottomWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    return AppBar(
      leadingWidth: 70.w,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? AppColors.black171717,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light,
        statusBarBrightness: statusBarBrightness ?? Brightness.dark,
      ),
      centerTitle: centerTitle,
      title: customTitleWidget ??
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyles.medium.copyWith(
              fontSize: titleSize ?? 19.sp,
              color: titleColor ?? AppColors.white,
            ),
          ).paddingOnly(top: titleTopPadding ?? 5.h),
      leading:  (isLeadingEnable)
          ? ((isDrawerEnable)
          ? Container(
        margin: EdgeInsets.only(left: 10.w),
        child: Consumer(
          builder: (context, ref, child) {
            return InkWell(
              onTap: onLeadingPress ??
                      () {
                        FocusScope.of(context).unfocus();
                        final drawerWatch = ref.watch(drawerController);
                        drawerWatch.key.currentState?.openDrawer();
                  },
              child: leftImage ??
                  CommonSVG(
                    strIcon: AppAssets.svgDrawer,
                    height: 33.h,
                    width: 33.w,
                  ).paddingOnly(left: 2.w, right: 2.w, top: 6.h, bottom: 5.h),
            );
          },
        ),
      ): Container(
            margin: EdgeInsets.only(left: 10.w),
            child: InkWell(
              onTap: onLeadingPress ??
                  () {
                    ref.read(navigationStackProvider).pop();
                  },
              child: leftImage ??
                  CommonSVG(
                    strIcon: AppAssets.svgRoundedBack,
                    height: 33.h,
                    width: 33.w,
                  ).paddingOnly(left: 2.w, right: 2.w, top: 6.h, bottom: 5.h),
            ),
          ))
          : const Offstage(),
      elevation: 0,
      actions: actions,
      backgroundColor: backgroundColor ?? AppColors.black171717,
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? AppBar().preferredSize.height + 17.h);
// Size get preferredSize => Size.fromHeight(appBarHeight??0.h);
}
