import 'package:flutter/scheduler.dart';
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

class RequestSentMobile extends ConsumerStatefulWidget {
  const RequestSentMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<RequestSentMobile> createState() => _RequestSentMobileState();
}

class _RequestSentMobileState extends ConsumerState<RequestSentMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final requestSentWatch = ref.read(requestSentController);
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
      onWillPop: () async => false,
      child: Scaffold(
        body: _bodyWidget(),
        backgroundColor: AppColors.servicesScaffoldBgColor,
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Stack(
      children: [
        ///Lottie Animation On Successfully sending request
        Positioned(
          top: 50.h,
          right: 100.w,
          bottom: 50.h,
          child: Lottie.asset(
            AppAssets.animRecycleService,
            // AppAssets.animServiceRequestSent,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            fit: BoxFit.cover,
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
                  title: LocalizationStrings.keyRequestSentSuccessfully.localized,
                  textOverflow: TextOverflow.ellipsis,
                  textStyle: TextStyles.medium.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.white,
                  ),
                ).paddingOnly(bottom: 15.h, top: 40.h),
                CommonText(
                  title: LocalizationStrings.keyYourRequestForwardedToRobot.localized,
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  textStyle: TextStyles.light.copyWith(
                    color: AppColors.white,
                  ),
                ).paddingOnly(bottom: 15.h),
                CommonButtonMobile(
                  buttonText: LocalizationStrings.keyBackToHome.localized,
                  onTap: () {
                    ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
                  },
                  rightIcon: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                  ),
                ).paddingAll(20.h),
              ],
            ),
          ),
        )
      ],
    );
  }
}
