import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/order_home_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessfulMobile extends ConsumerStatefulWidget {
  final FromScreen fromScreen;

  const OrderSuccessfulMobile({Key? key, required this.fromScreen}) : super(key: key);

  @override
  ConsumerState<OrderSuccessfulMobile> createState() => _OrderSuccessfulMobileState();
}

class _OrderSuccessfulMobileState extends ConsumerState<OrderSuccessfulMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final orderPreparingWatch = ref.read(orderSuccessfulController);
      //orderPreparingWatch.disposeController(isNotify : true);
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
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        backgroundColor: AppColors.servicesScaffoldBgColor,
        body: _bodyWidget(),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Stack(
      children: [
        /// bg image
        SafeArea(
          child: Lottie.asset(
            AppAssets.animOrderSuccessfulNewLottieMobile,
          ),
        ),

        /// top right image
        SafeArea(
          child: Align(
              alignment: Alignment.topRight,
              child: CommonSVG(
                strIcon: AppAssets.svgOrderSuccessTop,
                width: 204.w,
                height: 174.h,
              ).paddingOnly(top: 30.h, right: 20.w)),
        ),

        /// bottom content
        Align(
          alignment: Alignment.bottomCenter,
          child: _widgetBottom(),
        )
      ],
    );
  }

  Widget _widgetBottom() {
    return Container(
      height: 224.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          color: AppColors.primary),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  title: LocalizationStrings.keyYourOrderIsPlaced.localized,
                  fontWeight: TextStyles.fwLight,
                  fontSize: 18.sp,
                  clrfont: AppColors.black,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CommonText(
                  title: LocalizationStrings.keyYourOrderIsPreparingMsg.localized,
                  fontWeight: TextStyles.fwLight,
                  fontSize: 14.sp,
                  clrfont: AppColors.black,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
               CommonButton(
                  buttonText: LocalizationStrings.keyBackToHome.localized,
                  buttonTextColor: AppColors.white,
                  rightIcon: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                  ),
                  isButtonEnabled: true,
                  rightIconLeftPadding: 5.w,
                  buttonEnabledColor: AppColors.black,
                  height: 60.h,
                  onTap: () {
                    // if (widget.fromScreen != FromScreen.guest) {
                      final homeWatch = ref.watch(orderHomeController);
                    //   homeWatch.updateOrderStatus(OrderStatusHomeEnum.orderProcessing);

                    //   ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
                    // }
                    homeWatch.updateIsShowOrderStatusWidget(true);
                    ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.orderHome());
                  },
                )
        ],
      ).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
    );
  }

  Future<bool> _onWillPopScope() async {
    //ref.read(navigationStackProvider).pushAndRemoveAll( NavigationStackItem.guestOrder());
    return true;
  }
}
