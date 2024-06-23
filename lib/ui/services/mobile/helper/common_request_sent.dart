import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:lottie/lottie.dart';

class CommonRequestSentWidget extends ConsumerWidget with BaseConsumerWidget {
  final String animImage;
  final String? title;
  final String? message;
  final GestureTapCallback? onTap;

  const CommonRequestSentWidget({super.key, required this.animImage, this.title, this.message, this.onTap});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        ///Lottie Animation On Successfully sending request
        Positioned(
          top: 0.h,
          right: 0.w,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Lottie.asset(
            animImage,
            fit: BoxFit.contain,
          ),
        ),

        ///Bottom Navigation Bar navigates back to home screen
        Positioned(
          bottom: 0.0,
          right: 0.0,
          left: 0.0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.black171717,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  title: title ?? LocalizationStrings.keyRequestSentSuccessfully.localized,
                  textOverflow: TextOverflow.ellipsis,
                  textStyle: TextStyles.medium.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.white,
                  ),
                ).paddingOnly(top: 40.h),
                CommonText(
                  title: message ?? LocalizationStrings.keyYourRequestForwardedToRobot.localized,
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  textStyle: TextStyles.light.copyWith(
                    color: AppColors.white,
                  ),
                ).paddingOnly(top: 11.h, bottom: 15.h),

                /// Back to home button
                CommonButtonMobile(
                  buttonText: LocalizationStrings.keyBackToHome.localized,
                  onTap: onTap ??
                      () {
                        // final homeWatch = ref.watch(homeController);
                        // homeWatch.updateOrderStatus(OrderStatusHomeEnum.processing);
                        // homeWatch.updateIsShowOrderStatusWidget(true);
                        // ref.read(bottomMenuController).updateBottomSelectedIndex(selectedBottomIndex: 0);
                        ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
                      },
                  rightIcon: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                  ),
                ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
              ],
            ),
          ),
        )
      ],
    );
  }
}
