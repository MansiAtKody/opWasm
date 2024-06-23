import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/drawer/drawer_menu_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonSliverAppBar extends ConsumerWidget with BaseConsumerWidget {
  final bool isLeadingEnable;
  final bool isDrawerEnable;
  final bool centerTitle;
  final bool isBorderRadiusEnable;
  final GestureTapCallback? onLeadingPress;
  final String title;
  final Widget? leftImage;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? titleSize;
  final double? expandedHeight;
  final Widget appBarWidget;
  final Widget bodyWidget;

  const CommonSliverAppBar({
    Key? key,
    required this.title,
    this.leftImage,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.titleSize,
    this.expandedHeight,
    this.centerTitle = true,
    required this.appBarWidget,
    this.isBorderRadiusEnable = true,
    required this.bodyWidget,
    this.isLeadingEnable = true,
    this.onLeadingPress, this.isDrawerEnable =false,
  }) : super(key: key);

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget buildPage(BuildContext context,ref) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(15.h),
              child: SizedBox(
                height: 10.h,
              ),
            ),
            leadingWidth: 70.w,
            leading:(isLeadingEnable)
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
            backgroundColor: AppColors.black171717,
            pinned: true,
            floating: false,
            shape: isBorderRadiusEnable
                ? RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                ))
                : null,
            expandedHeight: expandedHeight ?? 275.h,
            centerTitle: centerTitle,
            title: CommonText(
              title: title,
              textStyle: TextStyles.medium.copyWith(
                color: titleColor ?? AppColors.white,
                fontSize: titleSize ?? 21.sp,
              ),
              textAlign: TextAlign.center,
            ),
            actions: actions,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: SafeArea(
                child: appBarWidget,
              ),
            ),
          ),
        ];
      },
      body: bodyWidget,
    );
  }
}
// ----------Usage -------///
// Widget _bodyWidget() {
//   return CommonSliverAppBar(
//       title: LocalizationStrings().keyMyAccount,
//       centerTitle: true,
//       isLeadingEnable: true,
//       expandedHeight: 0.h, you can give height as per your requirement or it will take default height
//       appBarWidget: const ProfileAppBarWidget().paddingOnly(top: 50.h),
//       bodyWidget: _bodyWidget());
// }
