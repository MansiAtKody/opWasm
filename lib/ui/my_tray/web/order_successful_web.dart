import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/order_home_controller.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessfulWeb extends StatelessWidget with BaseStatelessWidget {
  final FromScreen fromScreen;

  const OrderSuccessfulWeb({super.key, required this.fromScreen});

  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// bg image
            SafeArea(child: Lottie.asset(AppAssets.animOrderSuccessfulNewLottieWeb)).paddingOnly(bottom: 100.h),

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
          ],
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
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Container(
          height: 224.h,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
            ),
            color: AppColors.primary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      title: LocalizationStrings.keyYourOrderIsPlaced.localized,
                      fontWeight: TextStyles.fwMedium,
                      fontSize: 18.sp,
                      clrfont: AppColors.black,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CommonText(
                      title: LocalizationStrings.keyYourOrderIsPreparingMsg.localized,
                      fontWeight: TextStyles.fwRegular,
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
                rightIconLeftPadding: 5.w,
                isButtonEnabled: true,
                buttonEnabledColor: AppColors.blue009AF1,
                height: 50.h,
                onTap: () {
                   final homeWatch = ref.watch(orderHomeController);
                  // homeWatch.updateOrderStatus(OrderStatusHomeEnum.orderProcessing);
                   homeWatch.updateIsShowOrderStatusWidget(true);
                   Navigator.pop(context);
                  if (fromScreen != FromScreen.orderHome) {
                    ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.orderHome());
                  }
                },
              ).paddingSymmetric(horizontal: 125.w)
            ],
          ).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
        );
      },
    );
  }
}
