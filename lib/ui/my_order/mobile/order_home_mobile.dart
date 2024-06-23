import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/order_home_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/categories_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/looking_for_something_else_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/helper/order_status_bottom_widget.dart';
import 'package:kody_operator/ui/my_order/mobile/shimmer/shimmer_order_home_mobile.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/slide_right_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class OrderHomeMobile extends ConsumerStatefulWidget {
  const OrderHomeMobile({Key? key, }) : super(key: key);

  @override
  ConsumerState<OrderHomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends ConsumerState<OrderHomeMobile> with TickerProviderStateMixin, BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ScrollController gridScrollController = ScrollController();
  ScrollController listScrollController = ScrollController();

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final homeWatch = ref.read(orderHomeController);
      homeWatch.disposeController(isNotify: true);
      await homeWatch.productListApi(context).then((value) async{
        await homeWatch.categoryListApi(context);
      });
      listScrollController.addListener(() async {
        if (homeWatch.productListState.success?.hasNextPage ?? false) {
          if (listScrollController.position.maxScrollExtent == listScrollController.position.pixels) {
            if (!homeWatch.productListState.isLoadMore) {
              await homeWatch.productListApi( context);
            }
          }
        }
      });
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return CommonWhiteBackground(
        appBar:  CommonAppBar(
        backgroundColor: AppColors.black,
        title: LocalizationStrings.keyOrder.localized,
        isDrawerEnable: true,
    ), child: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Column(
      children: [
        SlideRightTransition(
          delay: 200,
          child: const CategoriesWidgetMobile().paddingOnly(top: 20.h),
        ),
        _bodyContent(),

        const Align(
          alignment: Alignment.bottomCenter,
          child: OrderStatusBottomWidget(),
        )
      ],
    );
  }


  List<Widget> _appBarActions() {
    return [
      InkWell(
        onTap: () {
          ref.read(navigationStackProvider).push(const NavigationStackItem.myTray());

        },
        child: const CommonSVG(strIcon: AppAssets.svgMyTrayEmpty),
      ),
      SizedBox(width: 15.w),
      /// Do not remove this code
      // InkWell(
      //   onLongPress: () {
      //     final visitorFormWatch = ref.watch(visitorFormController);
      //     visitorFormWatch.updateIsPopUpMenuOpen(isPopUpMenuOpen: true);
      //     Navigator.push(
      //       context,
      //       PageRouteBuilder(
      //         opaque: false,
      //         barrierDismissible: true,
      //         pageBuilder: (BuildContext context, _, __) {
      //           return const NotificationWidget();
      //         },
      //       ),
      //     );
      //   },
      //   onTap: () {
      //     ref.read(navigationStackProvider).push(const NavigationStackItem.notification());
      //   },
      //   child: const CommonSVG(strIcon: AppAssets.svgNotification),
      // ),
      // SizedBox(width: 20.w)
    ];
  }

  Widget _bodyContent() {
    final homeWatch = ref.watch(orderHomeController);
    return homeWatch.productListState.isLoading || homeWatch.categoryListState.isLoading
        ? const Expanded(child: ShimmerOrderHomeMobile())
        : Expanded(
          child: ListView(
      padding: EdgeInsets.zero,
      controller: listScrollController,
      physics: const ClampingScrollPhysics(),
      children: [

          SizedBox(height: 20.h),

          ///Fav List Widget
          // const SlideRightTransition(
          //   delay: 300,
          //   child: FavoriteListWidget(),
          // ),
          // SizedBox(height: 20.h),

          ///Something Else Widget
          const SlideRightTransition(
            delay: 400,
            child: LookingForSomeThingElseWidget(),
          ),
          SizedBox(
            height: homeWatch.getIsShowingOrderStatusWidget() ? 100.h : 0,
          ),
      ],
    ),
        );
  }
}
