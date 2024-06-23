import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:lottie/lottie.dart';


class ErrorMobile extends ConsumerStatefulWidget {
  final ErrorType? errorType;

  const ErrorMobile({super.key, required this.errorType});

  @override
  ConsumerState createState() => _ErrorMobileState();
}

class _ErrorMobileState extends ConsumerState<ErrorMobile> {
  String errorAsset = '';
  String buttonText = '';

  @override
  void initState() {
    super.initState();
    switch (widget.errorType) {
      case null:
        break;
      case ErrorType.error403:
        errorAsset = AppAssets.animError403Mobile;
        buttonText = LocalizationStrings.keyBackToLogin.localized;
        break;
      case ErrorType.error404:
        if (Session.getUserAccessToken().isNotEmpty) {
          errorAsset = AppAssets.animError404Mobile;
          buttonText = LocalizationStrings.keyBackToHome.localized;
        } else {
          buttonText = LocalizationStrings.keyBackToLogin.localized;
        }
        break;
      case ErrorType.noInternet:
        errorAsset = AppAssets.animNoInternet;
        buttonText = LocalizationStrings.keyRefresh.localized;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: context.height,
          width: context.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: context.height * 0.05),
                  Expanded(
                    child: Lottie.asset(errorAsset, width: context.width, fit: BoxFit.fitWidth),
                  ),
                ],
              ),
              Positioned(
                bottom: 30.h,
                child: CommonButton(
                  width: context.width * 0.5,
                  buttonEnabledColor: Colors.black,
                  buttonTextColor: AppColors.white,
                  borderColor: AppColors.white,
                  isButtonEnabled: true,
                  height: context.height * 0.065,
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
                      // ref.read(navigationStackProvider).refresh();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

