import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:lottie/lottie.dart';

class ErrorWeb extends ConsumerStatefulWidget {
  final ErrorType? errorType;

  const ErrorWeb({Key? key, this.errorType}) : super(key: key);

  @override
  ConsumerState<ErrorWeb> createState() => _ErrorWebState();
}

class _ErrorWebState extends ConsumerState<ErrorWeb> with BaseConsumerStatefulWidget{
  String errorAsset = '';
  String buttonText = '';

  @override
  void initState() {
    super.initState();
    switch (widget.errorType) {
      case null:
        break;
      case ErrorType.error403:
        errorAsset = AppAssets.animError403;
        buttonText = LocalizationStrings.keyBackToLogin.localized;
        break;
      case ErrorType.error404:
        if (Session.getUserAccessToken().isNotEmpty) {
          errorAsset = AppAssets.animError404;
          buttonText = LocalizationStrings.keyBackToHome.localized;
        } else {
          buttonText = LocalizationStrings.keyBackToLogin.localized;
        }
        break;
      case ErrorType.noInternet:
        errorAsset = AppAssets.animError404;
        buttonText = LocalizationStrings.keyRefresh.localized;
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Lottie.asset(errorAsset, fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 10.h,
            child: CommonButton(
              width: context.width * 0.15,
              buttonEnabledColor: AppColors.white.withOpacity(0.18),
              isButtonEnabled: true,
              height: context.height * 0.08,
              // prefixIcon: Icon(CupertinoIcons.chevron_back, color: AppColors.white, size: 30.r).paddingOnly(left: 10.w),
              buttonText: buttonText,
              onTap: () {
                switch (widget.errorType) {
                  case null:
                  case ErrorType.error403:
                    ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.login());
                  case ErrorType.error404:
                    if (Session.getUserAccessToken().isNotEmpty) {
                      ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
                    } else {
                      ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.login());
                    }
                  case ErrorType.noInternet:
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
